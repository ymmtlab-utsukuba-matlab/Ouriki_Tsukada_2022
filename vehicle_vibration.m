% 前輪バネした振動
clear;
clc;
load data_2021_01_26.mat;

%10t
figure(1)
set(gcf,'Position',[100,100,1000,200])
set(gcf,'Color',[1 1 1])
% subplot(2,1,1)
plot(Veh_1.x(1,:),dat1.ddz(1,:));hold on
plot(Veh_1.x(2,:),dat1.ddz(2,:));
plot(Veh_1.x(1,:),dat1.ddz(3,:));hold on
plot(Veh_1.x(2,:),dat1.ddz(4,:));
xline([0 30],'--')
yline(0)
xlim([-10 50])
%ylim([-0.02 0.02])
set(gca,'FontSize',10)
set(gca,'Color',[1 1 1])
set(gca,'FontName','Times New Roman')
% xticks([]);
% yticks([]);

% 18t
figure(2)
set(gcf,'Position',[100,100,1200,400])
set(gcf,'Color',[1 1 1])
% subplot(2,1,1)
plot(Veh_3.x(1,:),dat31.z(3,:),'r');hold on
plot(Veh_3.x(2,:),dat31.z(4,:),'b');
xline([0 30],'--')
yline(0)
xlim([-10 50])
% ylim([-0.02 0.02])
set(gca,'FontSize',10)
set(gca,'Color',[1 1 1])
set(gca,'FontName','Times New Roman')
xticks([]);
yticks([]);

% 前輪バネ上振動
%10t
figure(3)
set(gcf,'Position',[100,100,1200,400])
set(gcf,'Color',[1 1 1])
% subplot(2,1,1)
plot(Veh_2.x(1,:),dat21.z(1,:),'r');hold on
plot(Veh_2.x(2,:),dat21.z(2,:),'b');
xline([0 30],'--')
yline(0)
xlim([-10 50])
ylim([-0.02 0.02])
set(gca,'FontSize',10)
set(gca,'Color',[1 1 1])
set(gca,'FontName','Times New Roman')
xticks([]);
yticks([]);

% 18t
figure(4)
set(gcf,'Position',[100,100,1200,400])
set(gcf,'Color',[1 1 1])
% subplot(2,1,1)
plot(Veh_3.x(1,:),dat31.z(1,:),'r');hold on
plot(Veh_3.x(2,:),dat31.z(2,:),'b');
xline([0 30],'--')
yline(0)
xlim([-10 50])
% ylim([-0.02 0.02])
set(gca,'FontSize',10)
set(gca,'Color',[1 1 1])
set(gca,'FontName','Times New Roman')
xticks([]);
yticks([]);

% 路面凹凸
figure(5)
set(gcf,'Position',[100,100,1200,400])
set(gcf,'Color',[1 1 1])
plot(Veh_3.x(1,:),dat21.r(1,:),'k')
xline([0 30],'--')
yline(0)
xlim([-10 50])
ylim([-0.02 0.02])
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
set(gca,'Color',[1 1 1])
xticks([]);
yticks([]);