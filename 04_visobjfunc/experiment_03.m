% This script runs a code of VBI system identification.
% It appears the shape of Objective function.
%
% coded by SHIN on june/17, 2021
%-- Fixing the seed value of a random number generator
% rng('default');rng(1);
tic
clear;

VModel = 'YMMT';
for nL = [0.15 0.35]
    %-- Simulation Parameters Loading
    Sim   = mk_simulation_parameters; %-- simulation param
    Veh   = mk_vehicle_model_03(Sim);    %-- half_car
    Bri   = mk_bridge_model_01(Sim);     %-- intact bridge
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
    
    C = zeros(27,1);
    C(1)    = 0.6+0.8*rand(1,1);
    C(2:5)  = 0.2+2.8*rand(4,1);
    C(6:7)  = 0.6+0.8*rand(2,1);
    C(8:9)  = 10.^(-2+4*rand(2,1));
    C(10:12)= 0.8+0.4*rand(3,1);
    C(13:27)= 10.^(-3+6*rand(15,1));
    
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
    
    t     = Sim.t;
    TT    = length(t);
    [Q, R] = QRinitial(nL,dat);
    
    respass = '083_result/';
    
    %% mu1
    chan=['mu1_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X,100,1);
    
    for ii=1:100
        j=ii+1000;
        CHE1=2*Veh.mu1/100*ii;
        XRnd0(ii).mu1   = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=CHE1/Veh.mu1;
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan  '.fig']);
    
    
    %% mu2
    chan=['mu2_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:100
        j=ii+1000;
        CHE1=2*Veh.mu2/100*ii;
        XRnd0(ii).mu2   = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=CHE1/Veh.mu2;
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% cs1
    
    chan=['cs1_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:100
        j=ii+1000;
        CHE1=2*Veh.cs1/100*ii;
        XRnd0(ii).cs1   = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=CHE1/Veh.cs1;
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% cs2
    chan=['cs2_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:100
        j=ii+1000;
        CHE1=2*Veh.cs2/100*ii;
        XRnd0(ii).cs2   = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=CHE1/Veh.cs2;
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% ks1
    chan=['ks1_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:100
        j=ii+1000;
        CHE1=2*Veh.ks1/100*ii;
        XRnd0(ii).ks1   = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=CHE1/Veh.ks1;
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% ks2
    chan=['ks2_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:100
        j=ii+1000;
        CHE1=2*Veh.ks2/100*ii;
        XRnd0(ii).ks2   = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=CHE1/Veh.ks2;
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% ku1????????????
    
    chan=['ku1_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:100
        j=ii+1000;
        CHE1=Veh.ku1*10^(-2+4/100*ii);
        XRnd0(ii).ku1   = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=log10(CHE1/Veh.ku1);
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% ku2????????????
    chan=['ku2_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:100
        j=ii+1000;
        CHE1=Veh.ku2*10^(-2+4/100*ii);
        XRnd0(ii).ku2   = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=log10(CHE1/Veh.ku2);
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% d1????????????
    chan=['d1_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:99
        j               = ii+1000;
        CHE1            = 2*Veh.d1/100*ii;
        XRnd0(ii).d1    = CHE1;   %-- unsprung-mass (kg)
        XRnd0(ii).d2    = Veh.D - XRnd0(ii).d1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0               = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=CHE1/Veh.d1;
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% EI????????????
    
    for A=1:6:7
        chan=['EI' num2str(A) '_' VModel '_noise' num2str(nL)];
        mkdir([respass chan]);
        addpath([respass chan]);
        XRnd0=repmat(X, 100,1);
        for ii=1:100
            j                   = ii+1000;
            CHE1                = Bri.EI_DATA(A,1)*10^(-3+6/100*ii);
            XRnd0(ii).EI_DATA(A,1)   = CHE1;
            Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
            Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
            X0               = [Xv; Xb];
            [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
            
            cd([respass chan]);
            CT=clock;
            str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
            save(str,'J0','CHE1');
            cd ../../;
        end
        
        list = dir([respass chan]);
        [MM,~]=size(list);
        go=zeros(3,MM-2);
        for a=3:MM
            b=a-2;
            file=list(a).name;
            load(file,'J0','CHE1');
            go(1,b)=J0;
            %             go(2,b)=CHE1/X.EI_DATA(A,1);
            go(2,b)=log10(CHE1/Bri.EI_DATA(A,1));
        end
        
        plot(go(2,:),go(1,:),'b');
        hold on;
        [~,I]=min(go(1,:));
        plot(go(2,I),go(1,I),'ro');
        hold off;
        
        saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    end
    
    %% rA????????????
    
    chan=['rhoA_' VModel '_noise' num2str(nL)];
    mkdir([respass chan]);
    addpath([respass chan]);
    XRnd0=repmat(X, 100,1);
    
    for ii=1:100
        j               = ii+1000;
        CHE1            = 2*Bri.rhoA/100*ii;
        XRnd0(ii).rhoA  = CHE1;
        Xv              = [XRnd0(ii).d1 XRnd0(ii).cs1 XRnd0(ii).cs2 XRnd0(ii).ks1 XRnd0(ii).ks2 XRnd0(ii).mu1 XRnd0(ii).mu2 XRnd0(ii).ku1 XRnd0(ii).ku2]';
        Xb              = [XRnd0(ii).EI_DATA; XRnd0(ii).rhoA; XRnd0(ii).aC; XRnd0(ii).bC];
        X0              = [Xv; Xb];
        [J0,~,~]        = calObjFunc(X0,s,Veh,Bri,Sim,Q,R);
        cd([respass chan]);
        CT=clock;
        str=['Experiment3_data_' num2str(j,'%0+2u')  '.mat'];
        save(str,'J0','CHE1');
        cd ../../;
    end
    
    list = dir([respass chan]);
    [MM,~]=size(list);
    go=zeros(3,MM-2);
    for a=3:MM
        b=a-2;
        file=list(a).name;
        load(file,'J0','CHE1');
        go(1,b)=J0;
        go(2,b)=CHE1/Bri.rhoA;
    end
    
    plot(go(2,:),go(1,:),'b');
    hold on;
    [~,I]=min(go(1,:));
    plot(go(2,I),go(1,I),'ro');
    hold off;
    
    saveas(gcf,['093_figure/Experiment3_' chan '.fig'])
    
    %% save
    T=toc;
    fprintf(['????????????:' num2str(T,'%-7.4f') '[s] /n'])
end

% 
% for VModel = ["NGYM","YMMT"]
%     VModel = char(VModel);
%     if strcmp(VModel,'YMMT')
%         Veh   = mk_vehicle_model_01(Sim);    %-- half_car
%     else
%         Veh   = mk_vehicle_model_02(Sim);    %-- half_car
%     end
%     para_list = ["mu1", "mu2", "cs1", "cs2", "ks1", "ks2", "ku1", "ku2", "d1", "EI1", "EI7", "rhoA"];
%     valu_list = [Veh.mu1, Veh.mu2, Veh.cs1, Veh.cs2, Veh.ks1, Veh.ks2, Veh.ku1, Veh.ku2, Veh.d1, X.EI_DATA(1,1), X.EI_DATA(7,1), Bri.rhoA];
% 
%     for nL = [0 0.15 0.35]
%         figure('Name',['figure_' VModel '_noise' num2str(nL)],'NumberTitle','off')
%         tiledlayout(3,4)
%         for ii = 1:length(para_list)
%             nexttile
%             
%             chan=[char(para_list(ii)) '_' VModel '_noise' num2str(nL)];
%             cd([respass chan]);
%             list = dir();
%             [MM,~]=size(list);
%             go=zeros(3,MM-2);
%             for a=3:MM
%                 b=a-2;
%                 file=list(a).name;
%                 load(file,'J0','CHE1');
%                 go(1,b)=log10(J0);
%                 if para_list(ii)=="ku1"
%                     go(2,b)=log10(CHE1/Veh.ku1);
%                 elseif para_list(ii)=="ku2"                    
%                     go(2,b)=log10(CHE1/Veh.ku2);
%                 elseif para_list(ii)=="EI1"
%                     go(2,b)=log10(CHE1/X.EI_DATA(1,1));
%                 elseif para_list(ii)=="EI7"
%                     go(2,b)=log10(CHE1/X.EI_DATA(7,1));
%                 else
%                     go(2,b)=CHE1/valu_list(ii);
%                 end
%             end
%             
%             plot(go(2,:),go(1,:),'b');
%             hold on;
%             [~,I]=min(go(1,:));
%             plot(go(2,I),go(1,I),'ro');
%             hold off;
%             title(para_list(ii))
%             cd ../../;
%         end
%     end
% end