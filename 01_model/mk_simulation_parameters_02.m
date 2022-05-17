function Sim = mk_simulation_parameters_02()
%MK_SIMULATION_PARAMETERS returns the parameters for the simulation
% 
% coded by Shin Ryota, Feb/21, 2021

%%-- simulation parameters
dt      = 0.001; %-- [s] time increment
T       = 6.000; %-- [s] end time
gamma   = 1/2;   %-- gamma coef. for Newmark-beta method
beta    = 1/4;   %-- beta coef. for Newmark-beta method (for stability)
MAX_ITR = 100;   %-- max repeat num for "k" in Eq.(43) (Newton-Raphson)
MAX_ERR = 1e-6;  %-- tolerance
g       = 9.81;  %-- [m/s2] gravity acceleration
f_HF    = 0.05;  %-- [Hz] highpass filter

%-- analizer parameters
Exp_Count    = 100;
PSO_samp_num = 60;
PSO_step_num = 20; 

PSO_inertia  = 0.60;
PSO_local    = 0.30;
PSO_global   = 0.10;

t  = 0:dt:T; %-- time

%-- return values
Sim.dt      = dt;
Sim.T       = T;
Sim.gamma   = gamma;
Sim.beta    = beta;
Sim.MAX_ITR = MAX_ITR;
Sim.MAX_ERR = MAX_ERR;
Sim.g       = g;
Sim.f_HF    = f_HF;
Sim.t       = t;

Sim.Exp_Count    = Exp_Count;
Sim.PSO_samp_num = PSO_samp_num;
Sim.PSO_step_num = PSO_step_num;
Sim.PSO_inertia  = PSO_inertia;
Sim.PSO_local    = PSO_local;
Sim.PSO_global   = PSO_global;

end

