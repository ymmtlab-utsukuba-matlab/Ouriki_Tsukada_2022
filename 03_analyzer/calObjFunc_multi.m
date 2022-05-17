function [J,R_ave] = calObjFunc_multi(X,s, Veh, Bri, Sim, dat,nL, count)
%CALOBJFUNC_MULTI 複数台走行のための目的関数の設定
%   全ての車両の前輪と後輪の平均との差の２乗和を目的関数として設定
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
% coded by tsukada kento, 2022/02/23

% 
% 全ての走行データの前・後輪路面プロファイル推定

    
% X=assumedParameters(Veh,Bri);


parfor ii= 1:count
    
%     %-- Fixing the seed value of a random number generator
%     RMS_sig = sqrt(sum(S.^2,2)/length(S));  %-- RMS of measured Data
%     noise   = (RMS_sig*nL).*randn(size(S)); %-- generate noise
%     
%     %-- add noise to simulated signal data
%     ddz = S+noise;
%     
%     %-- numerical integration by Newmark-beta method
%     %[z, ~] = newmark_integration( ddz,Sim.dt,Sim.gamma,Sim.beta );
% 
%     %-- highpass filter
%     %z = highpass(z',Sim.f_HF,1/Sim.dt)'; %-- highpass (0.1Hz)
%     s = [ddz]; %-- observation vector, Eq.(48)
    

    %-- covariance matrix Q, R
    [Q, R] = QRinitial(nL,dat(ii+1,:));
    
    dat0=dat(ii+1,:)
    Pc=dat0.Pc
    
    ss=s(ii+1,:,:);
    sk=reshape(ss,4,6001);
    
    [~,~,Rf(:,ii),Rr(:,ii)]=calObjFunc(X,sk,Veh,Bri,Sim,Q,R,Pc);
%     [~,~,Rf(:,ii),Rr(:,ii)]=calObjFunc_withoutKF(X,sk,Veh,Bri,Sim);

end

% 推定精度の高い振動データの使用(上位70％)

    use_data=ceil(count*0.7);                    %上位70％
    J0_EachDif=sqrt(sum((Rf-Rr).^2))/length(Rf); %各データの前輪と後輪の二乗誤差
    Rf(1107,:)=J0_EachDif;
    Rr(1107,:)=J0_EachDif; 
    Rf=Rf';
    Rr=Rr';
    Rf_apply0=sortrows(Rf,1107);                 %昇順(前輪)
    Rr_apply0=sortrows(Rr,1107);                 %昇順(後輪)
    Rf_apply1=Rf_apply0(1:use_data,:);           %上位70％のデータを使用(前輪)
    Rr_apply1=Rr_apply0(1:use_data,:);           %上位70％のデータを使用(後輪)
    Rf_apply=Rf_apply1(:,1:1106);                %必要なデータの抽出(前輪)
    Rr_apply=Rr_apply1(:,1:1106);                %必要なデータの抽出(後輪)

% 目的関数設定
%     Rf=Rf';
%     Rr=Rr';
    R_ave=((mean(Rf_apply)+mean(Rr_apply))/2);
    
%     J0=(Rf-R_ave).^2
%     J1=sum((Rf-R_ave).^2)
%     J2=(sum((Rf-R_ave).^2))/count
%     J3=sum((sum((Rf-R_ave).^2))/count)
%     J4=sum((sum((Rf-R_ave).^2))/count)/length(Rf)
%     J5=sum((sum((Rf-R_ave).^2))/count)/length(Rf)+sum((sum((Rr-R_ave).^2))/count)/length(Rr)

    J=sum((sum((Rf_apply-R_ave).^2))/count)/length(Rf_apply)+sum((sum((Rr_apply-R_ave).^2))/count)/length(Rr_apply);

end

