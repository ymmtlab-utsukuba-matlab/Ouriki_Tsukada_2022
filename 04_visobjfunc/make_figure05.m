%% figure size
%-- metallic ratio
n=3; r=(n+sqrt(n^2+4))/2;
m=7; p=(m+sqrt(m^2+4))/2;

%-- axis
x=0.06; y=0.18; w=0.92;
num=3;

%% figure size

TEXT_V = ["mu1", "mu2", "cs1", "cs2", "ks1", "ks2", "ku1", "ku2", "EI1", "EI7", "d1", "rhoA"];
for nL = [0 0.15 0.35]
    figure('Name',['figure_Hist_YMMT_noise' num2str(nL) ],'NumberTitle','off')
    set(gcf,'Unit','centimeter','Position',[5,3,17,17/r])
    set(gcf,'Color',[1 1 1])
    tiledlayout(6,2)
    for ii = 1:min(size(para_list))
        nexttile
        load(['082_result/Experiment2_data_nL_' num2str(nL) '.mat'])
        EI1 = arrayfun(@(x) x.EI(1,1), resRnd2);
        EI7 = arrayfun(@(x) x.EI(7,1), resRnd2);
        para_list = [[resRnd2.mu1]; [resRnd2.mu2]; [resRnd2.cs1]; [resRnd2.cs2]; [resRnd2.ks1]; [resRnd2.ks2]];
        para_list = [para_list; [resRnd2.ku1]; [resRnd2.ku2]; [EI1']; [EI7']; [resRnd2.d1]; [resRnd2.rhoA]];
        if 7<=ii&&ii<=8
            dedges = 4/100;
            edges = [-2:dedges:2];
        elseif 9<=ii&&ii<=10
            dedges = 6/100;
            edges = [-3:dedges:3];
        else
            dedges = 2/100;
            edges = [0:dedges:2];
        end
        
        histogram(para_list(ii,:),edges,'Normalization','Probability')
        set(gca,'FontSize',20)
        set(gca,'FontName','Times New Roman')
        title(char(TEXT_V(ii)), 'FontSize',20, 'FontName','Times New Roman');
    end
end