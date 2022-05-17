function [J,RP,R1,R2] = calObjFunc_withoutKF(X,sk,Veh,Bri,Sim)
%CALOBJFUNC returns the value of objective function and estimated road
%unevenness.
%
% coded by Shin Ryota, Feb/23, 2021

%% System Parameters
% Xv = [ms d1 cs1 cs2 ks1 ks2 mu1 mu2 ku1 ku2]';
% Xb = [EI_DATA; rhoA; aC; bC];
% X  = [Xv; Xb];

% D   = Veh.D;     %-- [m] distance between the front-rear axles
% d1  = Veh.d1;      %-- [m] distance to the front axle from G
% d2  = D-d1;      %-- [m] distance to the rear axle from G
% cs1 = Veh.cs1;      %-- [kg/s] damping of front sus
% cs2 = Veh.cs2;      %-- [kg/s] damping of rear sus
% ks1 = Veh.ks1;      %-- [N/m] spring stiffness of front sus
% ks2 = Veh.ks2;      %-- [N/m] spring stiffness of rear sus
% mu1 = Veh.mu1;      %-- [kg] unsprung-mass at front
% mu2 = Veh.mu2;      %-- [kg] unsprung-mass at rear
% ku1 = Veh.ku1;      %-- [N/m] spring stiffness of front tyre
% ku2 = Veh.ku2;      %-- [N/m] spring stiffness of rear tyre
% ms  = Veh.M-mu1-mu2; %-- [kg] spring-mass of the vehicle
% I   = ms*d1*d2;  %-- [kg m2] Inertia
% ms1 = d2/D*ms;
% ms2 = d1/D*ms;

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


  
% %-- Kalman Filter
% t     = Sim.t; 
% dt    = Sim.dt;
% TT    = length(t);
% alpha_q = Sim.alpha_q;
% alpha_r = Sim.alpha_r;
% 
% %-- initialization
% Pc    = Veh.Pc; %-- posterior covariance
% Z_hat = zeros(12,TT); %-- estimated state vector, Eq.(60)
% V_bar = expm(V * dt); %-- defined in Eq.(55), used in Eq.(53)
% 
% %-- State Vector Estimation
% for tt = 2:TT
%     Sigma_a     = V_bar*Pc*V_bar' + Q;                              %-- prior covariance
%     G           = Sigma_a * H' / (H*Sigma_a*H' + R);                %-- Karman Gain
%     Z_hat(:,tt) = (eye(12)-G*H)*(V_bar*Z_hat(:,tt-1))+G*sk(:,tt); %-- state vector
% %     Z_hat(:,tt) = V_bar*Z_hat(:,tt-1); %-- state vector
% %     Z_hat(:,tt) = G*sk(:,tt-1); %-- state vector
% %     Pc          = (Sigma_a*H'*R*H + eye(12))\Sigma_a;
%     Pc          = (eye(12)-G*H)*Sigma_a;
%     Q(1:8,1:8) = (1 - alpha_q) * Q(1:8,1:8) + alpha_q * G(1:8,:) * (sk(:,tt) - H*Z_hat(:,tt)) * (sk(:,tt) - H*Z_hat(:,tt))' * G(1:8,:)';
%     R(:,:)     = (1 - alpha_r) * R(:,:)     + alpha_r * (sk(:,tt) - H*Z_hat(:,tt)) * (sk(:,tt) - H*Z_hat(:,tt))';
% end
% % Z_hat=(highpass(Z_hat',Sim.f_HF,1/Sim.dt))'; %-- highpass (0.1Hz)
% 
% %-- Extract vehcle input only
% u       = Z_hat(9:10, :);

t = Sim.t;
dt=Sim.dt;
T =Sim.T;
TT= length(t);
%-- simulates the vehicle responses
ddz = sk;

%-- numerical integration of unsprung-mass vibrations
dz   = zeros(size(ddz));
z    = zeros(size(ddz));

%-- vehicle system
G  = 1/2;  %-- gammma coefficient for newmark-beta method
B  = 1/4;  %-- beta coefficient for newmark-beta method

%-- calculate input
t = 0:dt:T; %-- time, dt=0.001(s)
% xx= [x_0+v*t+d1; x_0+v*t-d2]; %-- vehicle position: x(t)

%-- calculation of velocity and displacement responses
for tt=2:length(t)
    dz(:,tt) = dz(:,tt-1) + dt*(1-G)*ddz(:,tt-1) + dt*G*ddz(:,tt);
    z(:,tt) = z(:,tt-1) + dt*dz(:,tt-1) + dt^2*(1/2-B)*ddz(:,tt-1) + dt^2*B*ddz(:,tt);
end

%-- calculation of engine vibration

Fv = MASS*ddz+DAMP*dz+STIF*z;
u  = Fv([3 4],:)./([ku1; ku2]);

% u=detrend(u);
u(isnan(u))=0;
u = (bandpass(u',[3 39],1/Sim.dt))';

%-- Bridge profile
%-- parameter setting
ENUM      = Bri.ENUM; %-- number of elements
dL_DATA   = Bri.L/ENUM * ones(ENUM,1);
rhoA_DATA = X(17) * ones(ENUM, 1);
EI_DATA   = X(10:16);
% rhoA_DATA = Bri.rhoA * ones(ENUM, 1);
% EI_DATA(1:7)   = Bri.EI;

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
g  = Sim.g;
P1 = -ms1*(g+ddz(1,:)) - mu1*(g+ddz(3,:)); %-- [N] at the front axle
P2 = -ms2*(g+ddz(2,:)) - mu2*(g+ddz(4,:)); %-- [N] at the rear axle
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

% y_VEH=detrend(y_VEH);
y_VEH(isnan(y_VEH))=0;
% y_VEH = (bandpass(y_VEH',[3 43],1/Sim.dt))';
y_VEH = (highpass(y_VEH',2,1/Sim.dt))';
r  = u - y_VEH;
dx = 0.05;
xx = min(x(1,:),[],2):dx:max(x(2,:),[],2);

R1  = spline(x(1,:)',r(1,:)',xx');
R2  = spline(x(2,:)',r(2,:)',xx');

% %フーリエ変換
% Fs=1000;
% R1_L=length(R2);
% R1_fft=fft(R2)';
% R1_P2=abs(R1_fft/R1_L);
% R1_P1=R1_P2(1:R1_L/2+1);
% R1_P1(2:end-1)=2*R1_P1(2:end-1);
% R1_f=Fs*(0:(R1_L/2))/R1_L;
% plot(R1_f,R1_P1);

%-- objective function, Eq.(65)
J = sqrt(sum((R1-R2).^2))/length(R1);
RP = [xx' R1 R2];

end


%%

% RR=bandpass(R(:,2),[3 43],500);
% figure(1)
% set(gcf,'Position',[100,100,1000,200])
% set(gcf,'Color',[1 1 1])
% plot(RP(:,1),RP(:,2),'r');hold on
% plot(RP(:,1),RP(:,3),'b');hold on
% plot(R(:,1)+Veh.x_0-Veh.D,RR(:,1),'k');
% xlim([0 50])
% ylim([-0.02 0.02])
% set(gca,'FontSize',10)
% set(gca,'FontName','Times New Roman')

% 2.134614351220963e-05 (u[3-43],y_VEH[なし])
% 1.847781777180448e-05 (u[3-39],y_VEH[なし])
% 1.419031081705257e-05 (u[3-39],y_VEH[2<])


% 8.952017664881661e-05 (1-42)
% 8.810918987255070e-05 (1-43)
% 8.853316692020251e-05 (1-44)
% 9.138887239073402e-05 (1-45)
% 1.005822465498771e-04 (1-50)
% 1.254041436338158e-04 (1-60)

% 8.810918987255070e-05 (1-43)
% 5.722852444442660e-05 (2-43)
% 1.821603956228001e-05 (3-43)
% 1.964037418573119e-05 (4-43)



