% MAIN script executes all tasks related with numerical simulation and
% analysis for Journal of Sound and Vibration
% 
% coded by Yamamoto Kyosuke, Mar/07, 2021

%% 1) Numerical Experiment
%-- simulates the vehicle vibration data

%-- parallel computing (when you execute "main.m" first, please uncomment out)
% parpool

%-- Fixing the seed value of a random number generator
rng('default');rng(1);

%-- Simulation Parameters Loading
Sim   = mk_simulation_parameters; %-- simulation param 
% Veh_1 = mk_vehicle_model_01(Sim); %-- half_car(N_10 t)
% Veh_2 = mk_vehicle_model_02(Sim); %-- half_car(T2_20 t)
Veh_3 = mk_vehicle_model_03(Sim); %-- half_car(OB_18 t)
% Veh_5 = mk_vehicle_model_05(Sim); %-- half_car(T1_10 t)
% Veh_6 = mk_vehicle_model_06(Sim); %-- half_car(S_20 t)
% Veh_7 = mk_vehicle_model_07(Sim); %-- half_car(I_10 t)
Bri_1 = mk_bridge_model_01(Sim);  %-- intact bridge
% Bri_2 = mk_bridge_model_02(Sim);  %-- intact bridge
[R,~] = mk_road_profile_01;       %-- road profile

%-- numerical experiments
% fprintf('--- Simulating Intact Case \n')
% [Z1,S1,dat1] = vbi_simulator(Veh_1, Bri_1, R, Sim);
% [Z2,S2,dat2] = vbi_simulator(Veh_2, Bri_1, R, Sim);
% [Z3,S3,dat3] = vbi_simulator(Veh_3, Bri_1, R, Sim);
% [Z5,S5,dat5] = vbi_simulator(Veh_5, Bri_1, R, Sim);
% [Z6,S6,dat6] = vbi_simulator(Veh_6, Bri_1, R, Sim);
% [Z7,S7,dat7] = vbi_simulator(Veh_7, Bri_1, R, Sim);

%% 2) System Identification
%-- estimates the system parameters of vehicle and bridge, road uneveness

%-- カルマンフィルタを用いて，複数回走行データを取得した際のVBISI
%-- 走行速度は約時速28km～43km ⇒ 約時速21km～43km(2022/04/26)
%-- 

tic
fprintf(['--- Signal Processing\n'])
VBI_est1_015_multi = vbi_analyzer(Veh_3, Bri_1, Sim, R, 0.15);
toc

save data_2022_05___withoutKF1.mat















