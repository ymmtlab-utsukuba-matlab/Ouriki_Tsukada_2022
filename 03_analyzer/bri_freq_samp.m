%% Bridge Model
%-- bridge length and number of elements
BLEN = 30.00; %-- [m]
ENUM = 15; %-- number of elements
dL_DATA = BLEN/ENUM*ones(ENUM,1);
DOF = 2*(ENUM+1);

%-- mass per unit lenght values of all elements
rhoA = 4400; %-- [kg/m]
rhoA_DATA  =  rhoA * ones(ENUM, 1);

%-- flexual rigidities of all elements 
EI = 15600000000; %-- [N m3]
EI_DATA = EI *  ones(ENUM, 1);

%-- damping (coefficients of Rayleigh Damping)
aC  =      0.7024; % alpha (=0.7024) for mass matirx
bC  =      0.0052; % beta for stiffness matrix

%% Making matrices for the bridge model
%-- Global Mass, Dampling and Stiffness matrices of the bridge
MASS_B = mk_global_mass( rhoA_DATA, dL_DATA );
STIF_B = mk_global_stif( EI_DATA, dL_DATA );
DAMP_B = aC * MASS_B + bC * STIF_B;

%-- boundary condition
bc_dof = [1   DOF-1];
bc_ddy = [0; 0];
bc_dy = [0; 0];
bc_y = [0; 0];
dof_itr = 1:DOF;
dof_itr(bc_dof)=[];
MASS0_B = MASS_B(dof_itr, dof_itr);
DAMP0_B = DAMP_B(dof_itr, dof_itr);
STIF0_B = STIF_B(dof_itr, dof_itr);

%% natural frequnecy

%-- non-damping natural frequency
A = MASS0_B\STIF0_B;
[V0, D0] = eig(A); %-- eigne value decomposition
L0=diag(D0).^(1/2)*(1i); %-- lambda
f0=diag(D0).^(1/2)/2/pi; %-- non-damping natural frequency [Hz]

%-- natural frequency
L1=L0;
for itr=1:100 %-- Newton-Raphson method
    for kk=1:30
        A = L1(kk)*MASS0_B\DAMP0_B + MASS0_B\STIF0_B;
        [V, D] = eig(A); %-- eigne value decomposition
        L1(kk)=D(kk,kk)^(1/2); %-- lambda
    end
end
f1=real(L1)/2/pi; %-- natural frequency [Hz]