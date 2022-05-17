clear;
respass = 'temp/081_result/';
Sim   = mk_simulation_parameters; %-- simulation param
Bri   = mk_bridge_model_01(Sim);     %-- intact bridge

%% figure size
%-- metallic ratio
n=3; r=(n+sqrt(n^2+4))/2;
m=7; p=(m+sqrt(m^2+4))/2;

%-- axis
x=0.06; y=0.18; w=0.92;
num=3;
VModel = 'YMMT';

Veh   = mk_vehicle_model_03(Sim);    %-- half_car
para_list = ["mu1", "mu2", "cs1", "cs2", "ks1", "ks2", "ku1", "ku2", "EI1", "EI7", "d1", "rhoA"];
valu_list = [Veh.mu1, Veh.mu2, Veh.cs1, Veh.cs2, Veh.ks1, Veh.ks2, Veh.ku1, Veh.ku2, Bri.EI_DATA(1,1), Bri.EI_DATA(7,1), Veh.d1, Bri.rhoA];

for nL = [0 0.15 0.35]
    figure('Name',['figure_' VModel '_noise' num2str(nL)],'NumberTitle','off')
    set(gcf,'Unit','centimeter','Position',[5,3,17,17/r])
    set(gcf,'Color',[1 1 1])
    tiledlayout(6,2)
    for ii = 1:length(para_list)
        nexttile
        
        chan=[char(para_list(ii)) '_' VModel '_noise' num2str(nL)];
        cd([respass chan]);
        list = dir();
        [MM,~]=size(list);
        go=zeros(3,MM-2);
        for a=3:MM
            b=a-2;
            file=list(a).name;
            load(file,'J0','CHE1');
            go(1,b)=J0;
            if para_list(ii)=="ku1"
                go(2,b)=log10(CHE1/Veh.ku1);
            elseif para_list(ii)=="ku2"
                go(2,b)=log10(CHE1/Veh.ku2);
            elseif para_list(ii)=="EI1"
                go(2,b)=log10(CHE1/Bri.EI_DATA(1,1));
            elseif para_list(ii)=="EI7"
                go(2,b)=log10(CHE1/Bri.EI_DATA(7,1));
            else
                go(2,b)=CHE1/valu_list(ii);
            end
        end
        
        plot(go(2,:),go(1,:),'b');
        hold on;
        [~,I]=min(go(1,:));
        plot(go(2,I),go(1,I),'ro');
        hold off;
        set(gca,'FontSize',15)
        set(gca,'FontName','Times New Roman')
%         title(char(para_list(ii)), 'FontSize',10, 'FontName','Times New Roman');

        cd ../../../;
    end
%     saveas(gcf,['091_figure/Experiment1_' VModel '_noise' num2str(nL) '.fig'])
end