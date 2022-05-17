function [J,Z_hat,R1,R2,RP] = calObjFunc(X,sk,Veh,Bri,Sim,Q,R,Pc)
%CALOBJFUNC returns the value of objective function and estimated road
%unevenness.
%
% coded by Shin Ryota, Feb/23, 2021

%% System Parameters
% Xv = [ms d1 cs1 cs2 ks1 ks2 mu1 mu2 ku1 ku2]';
% Xb = [EI_DATA; rhoA; aC; bC];
% X  = [Xv; Xb];

D   = Veh.D;     %-- [m] distance between the front-rear axles
d1  = X(1);      %-- [m] distance to the front axle from G
d2  = D-d1;      %-- [m] distance to the rear axle from G
cs1 = X(2);      %-- [kg/s] damping of front sus
cs2 = X(3);      %-- [kg/s] damping of rear sus
ks1 = X(4);      %-- [N/m] spring stiffness of front sus
ks2 = X(5);      %-- [N/m] spring stiffness of rear sus
mu1 = X(6);      %-- [kg] unsprung-mass at front
mu2 = X(7);      %-- [kg] unsprung-mass at rear
ku1 = X(8);      %-- [N/m] spring stiffness of front tyre
ku2 = X(9);      %-- [N/m] spring stiffness of rear tyre
ms  = Veh.M-mu1-mu2; %-- [kg] spring-mass of the vehicle
I   = ms*d1*d2;  %-- [kg m2] Inertia
ms1 = d2/D*ms;
ms2 = d1/D*ms;

%-- mass matrix, Eq.(22)
%      [ ******** ******** ******** ******** ]
MASS = [ d2*ms/D  d1*ms/D  0        0        ;
         I/D      -I/D     0        0        ;
         0         0       mu1      0        ;
         0         0       0        mu2      ];

%-- damping matrix, Eq.(25)
%      [ ******** ******** ******** ******** ]
DAMP = [ cs1      cs2      -cs1     -cs2     ;
         d1*cs1   -d2*cs2  -d1*cs1  d2*cs2   ;
         -cs1     0        cs1      0        ;
         0        -cs2     0        cs2      ];

%-- stiffness matrix, Eq.(26)
%      [ ******** ******** ******** ******** ]
STIF = [ ks1      ks2      -ks1     -ks2     ;
         d1*ks1   -d2*ks2  -d1*ks1  d2*ks2   ;
         -ks1     0        ks1+ku1  0        ;
         0        -ks2     0        ks2+ku2  ];

%-- stiffness matrix for the external force, Eq.(27)
%      [ ******** ******** ]
F   =  [ 0        0        ;
         0        0        ;
         ku1      0        ;
         0        ku2      ];

%-- State Equation, Eq.(46)
%   [ ********** ********** ********** ********** ]     
V = [ zeros(4,4) eye(4)     zeros(4,2) zeros(4,2)  ;
      -MASS\STIF -MASS\DAMP MASS\F     zeros(4,2)  ;
      zeros(2,4) zeros(2,4) zeros(2,2) eye(2)      ;
      zeros(2,4) zeros(2,4) zeros(2)   zeros(2,2)  ];
  
%-- Observation Equation, Eq.(49)
%   [ ************** ************** ************** ************** ************** ************** ************** ************** ************** ************** ************** ************** ]    
H = [ -ks1/ms1       0              ks1/ms1        0              -cs1/ms1       0              cs1/ms1        0              0              0              0              0              ;
      0              -ks2/ms2       0              ks2/ms2        0              -cs2/ms2       0              cs2/ms2        0              0              0              0              ;
      ks1/mu1        0              -(ks1+ku1)/mu1 0              cs1/mu1        0              -cs1/mu1       0              ku1/mu1        0              0              0              ;
      0              ks2/mu2        0              -(ks2+ku2)/mu2 0              cs2/mu2        0              -cs2/mu2       0              ku2/mu2        0              0              ];

  
%-- Kalman Filter
t     = Sim.t; 
dt    = Sim.dt;
TT    = length(t);
alpha_q = Sim.alpha_q;
alpha_r = Sim.alpha_r;

%-- initialization
%-- posterior covariance
Z_hat = zeros(12,TT); %-- estimated state vector, Eq.(60)
V_bar = expm(V * dt); %-- defined in Eq.(55), used in Eq.(53)

%-- State Vector Estimation
for tt = 2:TT
    Sigma_a     = V_bar*Pc*V_bar' + Q;                              %-- prior covariance
    G           = Sigma_a * H' / (H*Sigma_a*H' + R);                %-- Karman Gain
    Z_hat(:,tt) = (eye(12)-G*H)*(V_bar*Z_hat(:,tt-1))+G*sk(:,tt); %-- state vector
%     Z_hat(:,tt) = V_bar*Z_hat(:,tt-1); %-- state vector
%     Z_hat(:,tt) = G*sk(:,tt-1); %-- state vector
%     Pc          = (Sigma_a*H'*R*H + eye(12))\Sigma_a;
    Pc          = (eye(12)-G*H)*Sigma_a;
    Q(1:8,1:8) = (1 - alpha_q) * Q(1:8,1:8) + alpha_q * G(1:8,:) * (sk(:,tt) - H*Z_hat(:,tt)) * (sk(:,tt) - H*Z_hat(:,tt))' * G(1:8,:)';
    R(:,:)     = (1 - alpha_r) * R(:,:)     + alpha_r * (sk(:,tt) - H*Z_hat(:,tt)) * (sk(:,tt) - H*Z_hat(:,tt))';
end
% Z_hat=(highpass(Z_hat',Sim.f_HF,1/Sim.dt))'; %-- highpass (0.1Hz)

%-- Extract vehcle input only
u       = Z_hat(9:10, :);

%-- Bridge profile
%-- parameter setting
ENUM      = Bri.ENUM; %-- number of elements
dL_DATA   = Bri.L/ENUM * ones(ENUM,1);
rhoA_DATA = X(17) * ones(ENUM, 1);
EI_DATA   = X(10:16);

%-- MCK matrices, Eq.(A.1), Eq(A.2)
MASS = mk_global_mass(rhoA_DATA, dL_DATA); %-- mass matrix
STIF = mk_global_stif(EI_DATA, dL_DATA);   %-- stiffness matrix
DAMP = Bri.aC * MASS + Bri.bC * STIF;              %-- damping matrix (Rayleigh)

%-- preparation of bridge response simulation
BDOF    = Bri.DOF;          %-- DoF of bridge model
x       = Veh.x;            %-- [m] vehicle position
dof_itr = Bri.dof_itr;
bc_dof  = Bri.bc_dof;
f0      = Bri.f0;
n       = Veh.n;            %-- axis number of the vehicle, Eq.(1)

MASS0 = MASS(dof_itr, dof_itr);
DAMP0 = DAMP(dof_itr, dof_itr);
STIF0 = STIF(dof_itr, dof_itr);


%-- Calcurate contact force
%-- parameter setting
g       = Sim.g;
dZ_hat  = V*Z_hat;
P1 = -ms1*(g+dZ_hat(5,:)) - mu1*(g+dZ_hat(7,:)); %-- [N] at the front axle
P2 = -ms2*(g+dZ_hat(6,:)) - mu2*(g+dZ_hat(8,:)); %-- [N] at the rear axle
P  = [P1;P2];

%-- external force vector for the bridge model
%-- initialization
y  = zeros(BDOF,TT);
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
    f1(:,tt) =L*P(:,tt); %-- [m] bridge profile
end
f1=f1(dof_itr,:);

%-- newmark beta method for the bridge
%-- simulates the bridge responses 
Y0 = Bri.Y0;
[~,y0,~,~] = newmark_beta(MASS0,DAMP0,STIF0,f0+f1,dt,Y0,Sim.gamma,Sim.beta);

%-- combine the boundary condition values
y(dof_itr, :) = y0;
y(bc_dof, :)  = Bri.bc_y*ones(1, TT);

%-- Calcurate road profile
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

% y_VEH = (highpass(y_VEH',Sim.f_HF,1/Sim.dt))';
r  = u - y_VEH;
dx = 0.05;
xx = min(x(1,:),[],2):dx:max(x(2,:),[],2);

R1  = spline(x(1,:)',r(1,:)',xx');
R2  = spline(x(2,:)',r(2,:)',xx');

%-- objective function, Eq.(65)
J = sqrt(sum((R1-R2).^2))/length(R1);
RP = [xx' R1 R2];

end

