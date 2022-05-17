function [VBI_est] = vbi_analyzer(Veh, Bri, Sim, R, nL)
%VBI_ANALYZER returns the estimated parameters and road profiles
% 
% INPUT
% S:   simulated data [m/s2], [slope/s]
% Veh: vehicle parameters
%  - M:  vehicle's total weight [kg]
%  - D:  distance between the front and rear axles [m] 
%  - d:  distance from the front axle to sensor position [m]
% Sim: simulation parameters
%  - dt:    time increment [s]
%  - gamma: gamma of Newmark-beta method
%  - beta:  beta of Newmark-beta method
% dat: correct data
% nL: noise level (ratio to RMS)
% 
% coded by Yamamoto Kyosuke, Feb/21, 2021

% %-- initialization
% Veh_0=mk_vehicle_model_01_randV(Sim);%-- half_car(N_10 t) random vehicle speed
% [~,S,dat0] = vbi_simulator(Veh_0, Bri, R, Sim);
%         
% Z = dat0.Z;
% dat0.Pc=(Z(:,1)-mean(Z,2))*(Z(:,1)-mean(Z,2))';
%         
% %-- Fixing the seed value of a random number generator
% RMS_sig = sqrt(sum(S.^2,2)/length(S));  %-- RMS of measured Data
% noise   = (RMS_sig*nL).*randn(size(S)); %-- generate noise
% 
% %-- add noise to simulated signal data
% ddz = S+noise;
% s0 = ddz; %-- observation vector, Eq.(48)
%         
% s_multi(1,:,:)=s0;
% dat_multi(1,:)=dat0;

% parfor count=1:Exp_Count
maxNumTrip =100;

for count=1:maxNumTrip
    
    for jj=count+1
        
        Veh_0=mk_vehicle_model_03_randV(Sim);%-- half_car(N_10 t) random vehicle speed
        [~,S,dat0] = vbi_simulator(Veh_0, Bri, R, Sim);
        
        Z = dat0.Z;
        dat0.Pc=(Z(:,1)-mean(Z,2))*(Z(:,1)-mean(Z,2))';
        
        %-- Fixing the seed value of a random number generator
        RMS_sig = sqrt(sum(S.^2,2)/length(S));  %-- RMS of measured Data
        noise   = (RMS_sig*nL).*randn(size(S)); %-- generate noise

        %-- add noise to simulated signal data
        ddz = S+noise;
        s0 = ddz; %-- observation vector, Eq.(48)
        
        s_multi(jj,:,:)=s0;
        dat_multi(jj,:)=dat0;
    
     end

    
    fprintf(['NumTrip=' num2str(count,'%0.3d') '\n'])
    [GX, RP, X, J]=system_identifer(s_multi,Veh,Bri,Sim,dat_multi,nL,count);
%     fprintf(['NumTrip=' num2str(count,'%0.3d') '\n'])
%     [GX, RP, X, J]=system_identifer(s_multi,Veh,Bri,Sim,nL,count);
    
%     VBI_est(count).noise =noise;
%     VBI_est(count).s     =s;
    VBI_est(count).GX    =GX;
    VBI_est(count).RP    =RP;
    VBI_est(count).J     =J;
    VBI_est(count).Z     =X;
%     VBI_est(count).Z_hat =Z_hat;

end

end

