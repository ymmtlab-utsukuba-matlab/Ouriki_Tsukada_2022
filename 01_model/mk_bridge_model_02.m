function [Bri] = mk_bridge_model_02(Sim)
% MK_BRIDGE_MODEL_01 returns the system parameters of a 30m-span bridge
% 1) damaged at L/2 (50% reduction in EI, 2m width)
% 2) 
% 
% coded by Shin Ryota, Feb/21, 2021

%% System Parameters
L    = 30.00;       %-- [m] span length
rhoA = 4400;        %-- [kg/m] mass per unit length
EI   = 15600000000; %-- [N m3] flexual rigidity
aC   = 0.7024;      % alpha of Rayleigh damping for mass matirx
bC   = 0.0052;      % beta of Rayleigh damping for stiffness matrix

%% Beam-Element Properties
ENUM      = 7; %-- number of elements
dL_DATA   = L/ENUM * ones(ENUM,1);
rhoA_DATA = rhoA * ones(ENUM, 1);
EI_DATA   = EI * ones(ENUM, 1);
EI_DATA(4)= EI * 0.50; %-- damaged

%% System Parameter Matrix
DOF = 2 * (ENUM+1); %-- degree of freedom

%-- MCK matrices, Eq.(A.1), Eq(A.2)
MASS = mk_global_mass(rhoA_DATA, dL_DATA); %-- mass matrix
STIF = mk_global_stif(EI_DATA, dL_DATA);   %-- stiffness matrix
DAMP = aC * MASS + bC * STIF;              %-- damping matrix (Rayleigh)

%-- initialization
t = Sim.t; %-- time (vector)
Y = zeros(DOF, 3); %-- initial disp/velc/accl of responses

%-- external force
f = zeros(DOF, length(t)); %-- external force

%-- boundary condition
bc_dof = [1  DOF-1]; %-- pin supports (fixed disp, free rotation)
bc_ddy = [0; 0];     %-- displacement at each pin support
bc_dy =  [0; 0];     %-- velocity at each pin support
bc_y =   [0; 0];     %-- acceleration at each pin support

%-- MCK matrices with considering the boundary condition
dof_itr = 1:DOF; 
dof_itr(bc_dof)=[]; %-- dof iterator for calculation
b0 = MASS(dof_itr, bc_dof)*bc_ddy;
b1 = DAMP(dof_itr, bc_dof)*bc_dy;
b2 = STIF(dof_itr, bc_dof)*bc_y;
f0 = f(dof_itr, :) - ( b0 + b1 + b2 )*ones(1,length(t)); %-- rhs
Y0 = Y(dof_itr, :);
MASS0 = MASS(dof_itr, dof_itr);
DAMP0 = DAMP(dof_itr, dof_itr);
STIF0 = STIF(dof_itr, dof_itr);

%-- return values
Bri.L         = L;
Bri.rhoA      = rhoA;
Bri.EI        = EI;
Bri.aC        = aC;
Bri.bC        = bC;
Bri.ENUM      = ENUM;
Bri.dL_DATA   = dL_DATA;
Bri.rhoA_DATA = rhoA_DATA;
Bri.EI_DATA   = EI_DATA;
Bri.DOF       = DOF;
Bri.bc_dof    = bc_dof;
Bri.bc_ddy    = bc_ddy;
Bri.bc_dy     = bc_dy;
Bri.bc_y      = bc_y;
Bri.dof_itr   = dof_itr;
Bri.b0        = b0;
Bri.b1        = b1;
Bri.b2        = b2;
Bri.f0        = f0;
Bri.Y0        = Y0;
Bri.MASS0     = MASS0;
Bri.DAMP0     = DAMP0;
Bri.STIF0     = STIF0;

end

