function Sim = mk_simulation_parameters()
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
alpha_r    = 1/7;
alpha_q    = 1/7;

%-- analizer parameters
Exp_Count    = 6;
stem_num     = 100; 

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
Sim.alpha_r       = alpha_r;
Sim.alpha_q       = alpha_q;
Sim.step_num      = stem_num;
end

