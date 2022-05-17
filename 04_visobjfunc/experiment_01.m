% This script runs a code of VBI system identification.
% It appears the shape of Objective function.
%
% coded by SHIN on june/17, 2021

%-- Fixing the seed value of a random number generator
tic
VModel = 'YMMT';
for nL = [0 0.15 0.35]
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
    
    %-- Vehicle Parameters
    X.D   = Veh.D;        %-- [m] distance between the front-rear axles
    X.d1  = Veh.d1;       %-- [m] distance to the front axle from G
    X.cs1 = Veh.cs1; %-- [kg/s] damping of front sus
    X.cs2 = Veh.cs2; %-- [kg/s] damping of rear sus
    X.ks1 = Veh.ks1; %-- [N/m] spring stiffness of front sus
    X.ks2 = Veh.ks2; %-- [N/m] spring stiffness of rear sus
    X.mu1 = Veh.mu1; %-- [kg] unsprung-mass at front
    X.mu2 = Veh.mu2; %-- [kg] unsprung-mass at rear
    X.ku1 = Veh.ku1; %-- [N/m] spring stiffness of front tyre
    X.ku2 = Veh.ku2; %-- [N/m] spring stiffness of rear tyre
    X.M     = Veh.M;
    Veh.ms  = Veh.M-Veh.mu1-Veh.mu2; %-- [kg] spring-mass of the vehicle
    X.ms1   = (Veh.D-Veh.d1)/Veh.D*Veh.ms;
    X.ms2   = Veh.d1/Veh.D*Veh.ms;
    
    %-- Bridge Parameters
    X.rhoA = Bri.rhoA; %-- [kg/m] mass per unit length
    X.EI   = Bri.EI;   %-- [N m3] flexual rigidity
    X.aC   = Bri.aC;   % alpha of Rayleigh damping for mass matirx
    X.bC   = Bri.bC;   % beta of Rayleigh damping for stiffness matrix
    
    % Beam-Element Properties
    X.EI_DATA   = ones(15,1)*X.EI;
    
    t     = Sim.t;
    TT    = length(t);
    [Q, R] = QRinitial(nL,dat);
    
    respass = '081_result/';
    
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan  '.fig']);
    
    
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
    %% ku1について
    
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
    %% ku2について
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
    %% d1について
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
    %% EIについて
    
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
            str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
        
        saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    end
    
    %% rAについて
    
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
        str=['Experiment1_data_' num2str(j,'%0+2u')  '.mat'];
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
    
    saveas(gcf,['091_figure/Experiment1_' chan '.fig'])
    
    %% save
    T=toc;
    fprintf(['実行時間:' num2str(T,'%-7.4f') '[s] /n'])
end

