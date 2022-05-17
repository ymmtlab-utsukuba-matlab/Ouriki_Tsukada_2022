% This script runs a code of VBI system identification.
% It appears the shape of Objective function with 1% noise.
%
% coded by SHIN on june/17, 2021

%-- Fixing the seed value of a random number generator
% rng('default');rng(1);
tic
clear;

VModel = 'YMMT';
Re     = 100;

%-- Simulation Parameters Loading
Sim   = mk_simulation_parameters; %-- simulation param
Veh   = mk_vehicle_model_01(Sim);    %-- half_car
Bri   = mk_bridge_model_01(Sim);     %-- intact bridge

t     = Sim.t;
TT    = length(t);

temp1   = zeros(1,100);
temp2   = zeros(1,100);

for nL = [0 0.15 0.35]
    resultV.mu1 = 0;
    resultV.mu2 = 0;
    resultV.cs1 = 0;
    resultV.cs2 = 0;
    resultV.ks1 = 0;
    resultV.ks2 = 0;
    resultV.ku1 = 0;
    resultV.ku2 = 0;
    resultV.d1  = 0;
    resultV.EI  = 0*ones(15,1);
    resultV.rhoA  = 0;
    
    resRnd1 = repmat(resultV, Re, 1);
    resRnd2 = repmat(resultV, Re, 1);
    
    for L =1:Re
        C = zeros(27,1);
        C(1)     = 0.6+0.8*rand(1,1);
        C(2:5)   = 0.2+2.8*rand(4,1); 
        C(6:7)   = 0.6+0.8*rand(2,1); 
        C(8:9)   = 10.^(-2+4*rand(2,1)); 
        C(10:12) = 0.8+0.4*rand(3,1); 
        C(13:27) = 10.^(-3+6*rand(15,1)); 
        
        %-- Vehicle Parameters
        X.D   = Veh.D;        %-- [m] distance between the front-rear axles
        X.d1  = C(1)*Veh.d1;       %-- [m] distance to the front axle from G
        X.cs1 = C(2)*Veh.cs1; %-- [kg/s] damping of front sus
        X.cs2 = C(3)*Veh.cs2; %-- [kg/s] damping of rear sus
        X.ks1 = C(4)*Veh.ks1; %-- [N/m] spring stiffness of front sus
        X.ks2 = C(5)*Veh.ks2; %-- [N/m] spring stiffness of rear sus
        X.mu1 = C(6)*Veh.mu1; %-- [kg] unsprung-mass at front
        X.mu2 = C(7)*Veh.mu2; %-- [kg] unsprung-mass at rear
        X.ku1 = C(8)*Veh.ku1; %-- [N/m] spring stiffness of front tyre
        X.ku2 = C(9)*Veh.ku2; %-- [N/m] spring stiffness of rear tyre
        X.M     = Veh.M;
        X.ms  = X.M-X.mu1-X.mu2; %-- [kg] spring-mass of the vehicle
        X.ms1   = (X.D-X.d1)/X.D*X.ms;
        X.ms2   = X.d1/X.D*X.ms;
        
        %-- Bridge Parameters
        X.rhoA = C(10)*Bri.rhoA; %-- [kg/m] mass per unit length
        X.EI   = Bri.EI;   %-- [N m3] flexual rigidity
        X.aC   = Bri.aC;   % alpha of Rayleigh damping for mass matirx
        X.bC   = Bri.bC;   % beta of Rayleigh damping for stiffness matrix
        
        % Beam-Element Properties
        X.EI_DATA   = C(13:27)*X.EI;
        
        [R,~] = mk_road_profile_01;          %-- road profile
        %-- numerical experiments
        fprintf('--- Simulating Intact Case /n')
        [z,s0,dat] = vbi_simulator(Veh, Bri, R, Sim);
        Z = dat.Z;
        Veh.Pc=(Z(:,1)-mean(Z,2))*(Z(:,1)-mean(Z,2))';
        %-- Fixing the seed value of a random number generator
        RMS_sig = sqrt(sum(s0.^2,2)/length(s0));  %-- RMS of measured Data
        noise   = (RMS_sig*nL).*randn(size(s0)); %-- generate noise
        %-- add noise to simulated signal data
        s = s0+noise;
        
        [Q, R] = QRinitial(nL,dat);

        
        %--- mu1 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = 2*Veh.mu1/100*ii;
            XRnd0(ii).mu1   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = CHE1/Veh.mu1;
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).mu1      = temp1(I);
        resRnd2(L).mu1      = temp2(I);
        
        %--- mu2 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = 2*Veh.mu2/100*ii;
            XRnd0(ii).mu2   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = CHE1/Veh.mu2;
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).mu2      = temp1(I);
        resRnd2(L).mu2      = temp2(I);
        
        %--- cs1 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = 2*Veh.cs1/100*ii;
            XRnd0(ii).cs1   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = CHE1/Veh.cs1;
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).cs1      = temp1(I);
        resRnd2(L).cs1      = temp2(I);
        
        %--- cs2 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = 2*Veh.cs2/100*ii;
            XRnd0(ii).cs2   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = CHE1/Veh.cs2;
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).cs2      = temp1(I);
        resRnd2(L).cs2      = temp2(I);
        
        %--- ks1 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = 2*Veh.ks1/100*ii;
            XRnd0(ii).ks1   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = CHE1/Veh.ks1;
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).ks1      = temp1(I);
        resRnd2(L).ks1      = temp2(I);
        
        %--- ks2 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = 2*Veh.ks2/100*ii;
            XRnd0(ii).ks2   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = CHE1/Veh.ks2;
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).ks2      = temp1(I);
        resRnd2(L).ks2      = temp2(I);
        
        %--- ku1 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = Veh.ku1*10^(-2+4/100*ii);
            XRnd0(ii).ku1   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = log10(CHE1/Veh.ku1);
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).ku1      = temp1(I);
        resRnd2(L).ku1      = temp2(I);
        
        %--- ku2 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = Veh.ku2*10^(-2+4/100*ii);
            XRnd0(ii).ku2   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = log10(CHE1/Veh.ku2);
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).ku2      = temp1(I);
        resRnd2(L).ku2      = temp2(I);
        
        %--- d1 ------------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:99
            CHE1            = 2*Veh.d1/100*ii;
            XRnd0(ii).d1    = CHE1;   %-- unsprung-mass (kg)
            XRnd0(ii).d2    = Veh.D - XRnd0(ii).d1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = CHE1/Veh.d1;
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).d1       = temp1(I);
        resRnd2(L).d1       = temp2(I);
        
        %--- EI ------------------------------------------------------------------
        for A=1:6:7
            XRnd0               = repmat(X, 100,1);
            parfor ii=1:100
                CHE1                   = Bri.EI_DATA(A,1)*10^(-5+10/100*ii);
                XRnd0(ii).EI_DATA(A,1) = CHE1;
                Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
                Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
                X0              = [Xv; Xb];
                [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
                temp1(ii)             = J0;
                temp2(ii)             = log10(CHE1/Bri.EI_DATA(A,1));
            end
            [~,I]                     = min(temp1(:));
            resRnd1(L).EI(A,1)        = temp1(I);
            resRnd2(L).EI(A,1)        = temp2(I);
        end
        
        %--- rhoA ----------------------------------------------------------------
        XRnd0               = repmat(X, 100,1);
        parfor ii=1:100
            CHE1            = 2*Bri.rhoA/100*ii;
            XRnd0(ii).rhoA   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0              = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            temp1(ii)       = J0;
            temp2(ii)       = CHE1/Bri.rhoA;
        end
        [~,I]               = min(temp1(:));
        resRnd1(L).rhoA     = temp1(I);
        resRnd2(L).rhoA     = temp2(I);
    end
    
    str=['084_result/Experiment4_data_nL_' num2str(nL)  '.mat'];
    save(str,'resRnd1','resRnd2');
end

T=toc;
fprintf(['実行時間:' num2str(T,'%-7.4f') '[s] \n'])
