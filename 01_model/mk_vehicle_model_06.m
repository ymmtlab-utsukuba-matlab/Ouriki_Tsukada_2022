function [Veh] = mk_vehicle_model_03(Sim)
%MK_VEHICLE_MODEL_01 returns the system parameters of 10-ton half-car
% 1) The parameters of the suspension are set in the same ratio
%    to the mass as those of Nagayama et al[*]. 
% 2) "D" (dist. from the front to rear) is set to that of a real bus. 
% 
% coded by Yamamoto Kyosuke, Feb/21, 2021

%% System Parameters

ms  = 18000;       %-- [kg] mass of the vehicle
D   = 3.750;      %-- [m] distance between the front-rear axles
d1  = 1.875;      %-- [m] distance to the front axle from G
d2  = D-d1;       %-- [m] distance to the rear axle from G
I   = ms*d1*d2;   %-- [kg m2] Inertia
cs1 = 2000;      %-- [kg/s] damping of front sus
cs2 = 2000;      %-- [kg/s] damping of rear sus
ks1 = 1000;     %-- [N/m] spring stiffness of front sus
ks2 = 1000;     %-- [N/m] spring stiffness of rear sus
mu1 = 1100;     %-- [kg] unsprung-mass at front
mu2 = 1100;     %-- [kg] unsprung-mass at rear
ku1 = 30000;    %-- [N/m] spring stiffness of front tyre
ku2 = 30000;    %-- [N/m] spring stiffness of rear tyre


M   = ms+mu1+mu2; %-- [kg] total weight of the vehicle
ms1 = d2*ms/D;
ms2 = d1*ms/D;

v   = 10.0;       %-- [m/s] running speed
x_0 = -10;        %-- [m] initial position

t   = Sim.t;
x   = [x_0+v*t; x_0-D+v*t]; %-- [m] vehicle position (the front/rear axles)
n   = size(x,1);            %-- axis number, Eq.(1)

%% System Parameter Matrix

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
%   [ *********** *********** *********** *********** ]     
V = [ zeros(4,4)  eye(4)      zeros(4,2)  zeros(4,2)  ;
      -MASS\STIF  -MASS\DAMP  MASS\F      zeros(4,2)  ;
      zeros(2,4)  zeros(2,4)  zeros(2,2)  eye(2)      ;
      zeros(2,4)  zeros(2,4)  zeros(2)    zeros(2,2)  ];
  
%-- Observation Equation, Eq.(49)
%   [ ************** ************** ************** ************** ************** ************** ************** ************** ************** ************** ************** ************** ]    
H = [ -ks1/ms1       0              ks1/ms1        0              -cs1/ms1       0              cs1/ms1        0              0              0              0              0              ;
      0              -ks2/ms2       0              ks2/ms2        0              -cs2/ms2       0              cs2/ms2        0              0              0              0              ;
      ks1/mu1        0              -(ks1+ku1)/mu1 0              cs1/mu1        0              -cs1/mu1       0              ku1/mu1        0              0              0              ;
      0              ks2/mu2        0              -(ks2+ku2)/mu2 0              cs2/mu2        0              -cs2/mu2       0              ku2/mu2        0              0              ];

%-- return values
Veh.ms  = ms;
Veh.D   = D;
Veh.d1  = d1;
Veh.d2  = d2;
Veh.I   = I;
Veh.cs1 = cs1;
Veh.cs2 = cs2;
Veh.ks1 = ks1;
Veh.ks2 = ks2;
Veh.mu1 = mu1;
Veh.mu2 = mu2;
Veh.ku1 = ku1;
Veh.ku2 = ku2;
Veh.M   = M;
Veh.v   = v;
Veh.x_0 = x_0;
Veh.x   = x;
Veh.n   = n;
Veh.MASS= MASS;
Veh.DAMP= DAMP;
Veh.STIF= STIF;
Veh.F   = F;
Veh.V   = V;
Veh.H   = H;

end

