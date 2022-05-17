%-- 複数回走行データを用いた時のVBISI
%-- 1～n回の時のパラメータ推定結果履歴



for ii = 1:100
    
    Param_his_d1(ii) = VBI_est1_015_multi(ii).GX(1,1)/Veh_3.d1;
    Param_his_cs1(ii) = VBI_est1_015_multi(ii).GX(1,2)/Veh_3.cs1;
    Param_his_cs2(ii) = VBI_est1_015_multi(ii).GX(1,3)/Veh_3.cs2;
    Param_his_ks1(ii) = VBI_est1_015_multi(ii).GX(1,4)/Veh_3.ks1;
    Param_his_ks2(ii) = VBI_est1_015_multi(ii).GX(1,5)/Veh_3.ks2;
    Param_his_mu1(ii) = VBI_est1_015_multi(ii).GX(1,6)/Veh_3.mu1;
    Param_his_mu2(ii) = VBI_est1_015_multi(ii).GX(1,7)/Veh_3.mu2;
    Param_his_ku1(ii) = VBI_est1_015_multi(ii).GX(1,8)/Veh_3.ku1;
    Param_his_ku2(ii) = VBI_est1_015_multi(ii).GX(1,9)/Veh_3.ku2;
    Param_his_EI1(ii) = VBI_est1_015_multi(ii).GX(1,10)/Bri_1.EI;
    Param_his_EI2(ii) = VBI_est1_015_multi(ii).GX(1,11)/Bri_1.EI;
    Param_his_EI3(ii) = VBI_est1_015_multi(ii).GX(1,12)/Bri_1.EI;
    Param_his_EI4(ii) = VBI_est1_015_multi(ii).GX(1,13)/Bri_1.EI;
    Param_his_EI5(ii) = VBI_est1_015_multi(ii).GX(1,14)/Bri_1.EI;
    Param_his_EI6(ii) = VBI_est1_015_multi(ii).GX(1,15)/Bri_1.EI;
    Param_his_EI7(ii) = VBI_est1_015_multi(ii).GX(1,16)/Bri_1.EI;
    Param_his_rhoA(ii) = VBI_est1_015_multi(ii).GX(1,17)/Bri_1.rhoA;

end

ms1 = Veh_3.ms*(Veh_3.D -Veh_3.d1)/Veh_3.D;
ms2 = Veh_3.ms*Veh_3.d1/Veh_3.D;

for ii=1:100
    Param_his_ms1(ii) = Veh_3.ms*(Veh_3.D-VBI_est1_015_multi(ii).GX(1,1))/Veh_3.D/ms1;
    Param_his_ms2(ii) = Veh_3.ms*VBI_est1_015_multi(ii).GX(1,1)/Veh_3.D/ms2;
    
end


set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot([VBI_est1_015_multi.J])
set(gca,'FontSize',10)


figure(1)
subplot(4,3,1)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_ms1)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('ms1')
subplot(4,3,2)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_ms2)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('ms2')
subplot(4,3,3)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_mu1)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('mu1')
subplot(4,3,4)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_mu2)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('mu2')
subplot(4,3,5)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_cs1)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('cs1')
subplot(4,3,6)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_cs2)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('cs2')
subplot(4,3,7)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_ks1)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('ks1')
subplot(4,3,8)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_ks2)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('ks2')
subplot(4,3,9)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_ku1)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('ku1')
subplot(4,3,10)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_ku2)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('ku2')

figure(2)
subplot(4,3,1)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_EI1)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('EI1')
subplot(4,3,2)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_EI2)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('EI2')
subplot(4,3,3)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_EI3)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('EI3')
subplot(4,3,4)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_EI4)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('EI4')
subplot(4,3,5)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_EI5)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('EI5')
subplot(4,3,6)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_EI6)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('EI6')
subplot(4,3,7)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_EI7)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('EI7')
subplot(4,3,8)
set(gcf,'Position',[100,100,400,170])
set(gcf,'Color',[1 1 1])
plot(Param_his_rhoA)
set(gca,'FontSize',10)
yline(1,'k','LineWidth',1)
ylim([0 2.0])
xlabel('rhoA')


%-- 路面凹凸推定　平均

set(gcf,'Position',[100,100,1000,200])
set(gcf,'Color',[1 1 1])
plot(RP(:,1),RP(:,2),'r');hold on
% plot(RP(:,1),RP(:,3),'b');hold on
plot(R(:,1)+Veh_3.x_0-Veh_3.D,R(:,2),'k');
xlim([0 50])
ylim([-0.02 0.02])
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')


