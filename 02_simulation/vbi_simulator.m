function [Z,S,dat] = vbi_simulator(Veh,Bri,R,Sim)
%VBI_SIMULATOR returns the state and observation vectors
% 
% coded by Yamamoto Kyosuke & Shin Ryota, Feb/21, 2021

%% Road Profile
%-- parameter setting
x = Veh.x; %-- [m] vehicle position

%-- road profile
R_DATA = R(:,2);               %-- [m] road unevenness
X_DATA = R(:,1)+Veh.x_0-Veh.D; %-- [m] corresponding position
pp = spline(X_DATA, R_DATA);   %-- spline interpolation of R
r  = ppval(pp, x);         %-- [m] road profile (time function)


%% VBI Simulation
%-- parameter setting
t       = Sim.t;            %-- [s] time
dt      = Sim.dt;           %-- [s] time increment
TT      = length(t);        %-- step number
BDOF    = Bri.DOF;          %-- DoF of bridge model
VDOF    = length(Veh.MASS); %-- DoF of vehicle model
MAX_ITR = Sim.MAX_ITR;      %-- max repeat num for Newton Raphson method
MAX_ERR = Sim.MAX_ERR;      %-- torelance, Eq.(45)
n       = Veh.n;            %-- axis number of the vehicle, Eq.(1)
dL_DATA = Bri.dL_DATA;      %-- [m] length of each beam element


%-- initialization
y   = zeros(BDOF,TT);
dy  = zeros(BDOF,TT);
ddy = zeros(BDOF,TT);

z   = zeros(VDOF,TT);
dz  = zeros(VDOF,TT);
ddz = zeros(VDOF,TT);

for kk=1:MAX_ITR
%     fprintf(['VBI SIMULATION: ITR=' num2str(kk) '/' num2str(MAX_ITR) '  '])
    
    %% Vehicle System
    
    %-- bridge profile
    y_VEH = zeros(n,TT);
    for tt=1:TT
        L = zeros(BDOF, n); %-- equvalent nodal force transform matrix
        for ii=1:Bri.ENUM
            %-- In-ELEM(ii) or NOT
            c = x(:,tt)>sum(dL_DATA(1:ii-1)) & x(:,tt)<=sum(dL_DATA(1:ii));
            
            %-- local position
            s = 2*(x(:,tt)-sum(dL_DATA(1:ii-1))-dL_DATA(ii)/2)/dL_DATA(ii);
            
            %-- the component of L matrix
            L(ii*2-1,:) = L(ii*2-1,:) + ( c.*1/4.*((s-1).^2).*(s+2) )';
            L(ii*2  ,:) = L(ii*2  ,:) + ( c.*1/4.*((s-1).^2).*(s+1)*dL_DATA(ii) )';
            L(ii*2+1,:) = L(ii*2+1,:) + ( c.*(-1/4).*((s+1).^2).*(s-2) )';
            L(ii*2+2,:) = L(ii*2+2,:) + ( c.*1/4.*((s+1).^2).*(s-1)*dL_DATA(ii) )';
        end
        y_VEH(:,tt)  = L'*y(:,tt); %-- [m] bridge profile
    end
    
    %-- input profile
    u  = r +y_VEH; %-- [m] input profile
    f_V = Veh.F*u; %-- external force of the vehicle system
    ddz0 = ddz; %-- memorizing ddz of kk-1 
    
    %-- newmark beta method for the vehicle
    %-- simulates the vehicle responses 
    Z0 = zeros(VDOF,3);
    [t,z,dz,ddz] = newmark_beta(Veh.MASS,Veh.DAMP,Veh.STIF,f_V,dt,Z0,Sim.gamma,Sim.beta);
    
    %-- termination condition
    err = norm(ddz-ddz0)/norm(ddz); %-- convergence error, Eq.(45)
%     fprintf(['ERR=' num2str(err) '\n'])
    if err<MAX_ERR, break; end
    
    %% Bridge System
    %-- parameter setting
    g       = Sim.g;
    D       = Veh.D;
    d1      = Veh.d1;
    d2      = Veh.d2;
    ms1     = d2/(d1+d2)*Veh.ms;
    ms2     = d1/(d1+d2)*Veh.ms;
    mu1     = Veh.mu1;
    mu2     = Veh.mu2;
    dof_itr = Bri.dof_itr;
    bc_dof  = Bri.bc_dof;
    f0      = Bri.f0;
    
    %-- contact force
    P1 = -ms1*(g+ddz(1,:)) - mu1*(g+ddz(3,:)); %-- [N] at the front axle
    P2 = -ms2*(g+ddz(2,:)) - mu2*(g+ddz(4,:)); %-- [N] at the rear axle
    P  = [P1;P2];
    
    %-- external force vector for the bridge model
    f1 = zeros(BDOF,TT);
    for tt=1:TT
        L = zeros(BDOF, n); %-- equvalent nodal force transform matrix
        for ii=1:Bri.ENUM
            %-- In-ELEM(ii) or NOT
            c = x(:,tt)>sum(dL_DATA(1:ii-1)) & x(:,tt)<=sum(dL_DATA(1:ii));
            
            %-- local position
            s = 2*(x(:,tt)-sum(dL_DATA(1:ii-1))-dL_DATA(ii)/2)/dL_DATA(ii);
            
            %-- the component of L matrix
            L(ii*2-1,:) = L(ii*2-1,:) + ( c.*1/4.*((s-1).^2).*(s+2) )';
            L(ii*2  ,:) = L(ii*2  ,:) + ( c.*1/4.*((s-1).^2).*(s+1)*dL_DATA(ii) )';
            L(ii*2+1,:) = L(ii*2+1,:) + ( c.*(-1/4).*((s+1).^2).*(s-2) )';
            L(ii*2+2,:) = L(ii*2+2,:) + ( c.*1/4.*((s+1).^2).*(s-1)*dL_DATA(ii) )';
        end
        f1(:,tt) = L*P(:,tt); %-- [m] bridge profile
    end
    f1=f1(dof_itr,:);
    
    %-- newmark beta method for the bridge
    %-- simulates the bridge responses 
    Y0 = Bri.Y0;
    [t,y0,dy0,ddy0] = newmark_beta(Bri.MASS0,Bri.DAMP0,Bri.STIF0,f0+f1,dt,Y0,Sim.gamma,Sim.beta);
    
    %-- combine the boundary condition values
    y(dof_itr, :) = y0;
    y(bc_dof, :) = Bri.bc_y*ones(1, TT);
    dy(dof_itr, :) = dy0;
    dy(bc_dof, :) = Bri.bc_dy*ones(1, TT);
    ddy(dof_itr, :) = ddy0;
    ddy(bc_dof, :) = Bri.bc_ddy*ones(1, TT);
end

%% State Space Modeling
%-- parameter setting
x = Veh.x; %-- [m] vehicle position

%-- state Vector
du = zeros(2,TT);
du(:,2:end) = diff(u,1,2)/dt;
Z = [z;dz;u;du]; %-- State Vector, Eq.(47)

%-- observation Vector
S = [ddz(1,:); ddz(2,:); ddz(3,:); ddz(4,:)];

%-- return data
dat.y     = y;
dat.dy    = dy;
dat.ddy   = ddy;
dat.z     = z;
dat.dz    = dz;
dat.ddz   = ddz;
dat.u     = u;
dat.du    = du;
dat.r     = r;
dat.y_VEH = y_VEH;
dat.Z     = Z;
dat.S     = S;
 

 

end