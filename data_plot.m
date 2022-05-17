clear;
clc;

% load SINGLE_SHIN_7_0120\DATA_10t.mat;
% load SINGLE_SHIN_7_0120\DATA_18t.mat;
% load MULTI_SHIN_7_0120\DATA_MULTI_1018.mat;
% load MULTI_SHIN_7_0120\DATA_MULTI_1010.mat;
% load MULTI_SHIN_7_0120\DATA_MULTI_1818.mat;
% load Ouriki_multi_T\DATA_OB18t.mat;
% load Ouriki_multi_T\DATA_OB18t_28mean.mat;
% load Ouriki_multi_T\DATA_OB18t_1000mean.mat;
% load Multi_28\DATA_Y10t.mat;


%%
label = cell2table(DATA_N10t.SUMMARY([19:20 7:8 3:6 9:18],1)); 
figure(1)
set(gcf,'Position',[100,100,500,400])
set(gcf,'Color',[1 1 1])
%subplot(1,4,1)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[ cell2mat(DATA_N10t.SUMMARY([19:20 7:8 3:6 9:18],4)) cell2mat(DATA_OB18t.SUMMARY([19:20 7:8 3:6 9:18],4))...
    cell2mat(DATA_T10t.SUMMARY([19:20 7:8 3:6 9:18],4)) cell2mat(DATA_T20t.SUMMARY([19:20 7:8 3:6 9:18],4))])
yline(1,'k','LineWidth',1)
%legend('','','')
ylim([0.0 2.0])
%xlabel('')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
xticks([])
% yticks([])

% print(gcf,'-dsvg','-r1200')



label = cell2table(DATA_18t.SUMMARY([9:17],1)); 
set(gcf,'Color',[1 1 1])
%subplot(1,4,2)
bar(categorical(table2array(label)),[cell2mat(DATA_18t.SUMMARY([9:17],4)) cell2mat(DATA_OB18t.NOISE015_intact([9:17],2))...
    cell2mat(DATA_OB18t_28mean.NOISE015_intact([9:17],2)) cell2mat(DATA_OB18t_1000mean.NOISE015_intact([9:17],2))])
% legend('noise0','noise15', 'noise35','')
yline(1,'k','LineWidth',1)
%ylim([0.0 2.0])
%xlabel("OB18t noise035")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')

label = cell2table(DATA_18t.SUMMARY([2:8 26],1)); 
set(gcf,'Color',[1 1 1])
%subplot(1,4,3)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[ cell2mat(DATA_18t.SUMMARY([2:8 26],6)) cell2mat(DATA_OB18t.NOISE035_intact([2:8 18],2))...
    cell2mat(DATA_OB18t_28mean.NOISE035_intact([2:8 18],2)) cell2mat(DATA_OB18t_1000mean.NOISE035_intact([2:8 18],2))])
yline(1,'k','LineWidth',1)
%legend('1台28回推定','1台28回走行','')
%ylim([0.0 2.0])
%xlabel('OB18t noise035')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
label = cell2table(DATA_18t.SUMMARY([9:17],1)); 
set(gcf,'Color',[1 1 1])
%subplot(1,4,4)
bar(categorical(table2array(label)),[cell2mat(DATA_18t.SUMMARY([9:17],6)) cell2mat(DATA_OB18t.NOISE035_intact([9:17],2))...
    cell2mat(DATA_OB18t_28mean.NOISE035_intact([9:17],2)) cell2mat(DATA_OB18t_1000mean.NOISE035_intact([9:17],2))])
% legend('noise0','noise15', 'noise35','')
yline(1,'k','LineWidth',1)
ylim([0.0 2.0])
%xlabel("OB18t noise035")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')






label = cell2table(DATA_OB18t.NOISE000_intact([2:8 18],1)); 
figure(1)
set(gcf,'Color',[1 1 1])
subplot(1,2,1)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_OB18t.NOISE000_intact([2:8 18],2)) cell2mat(DATA_OB18t.NOISE015_intact([2:8 18],2)) cell2mat(DATA_OB18t.NOISE035_intact([2:8 18],2))])
yline(1,'k','LineWidth',1)
legend('noise000','noise015', 'noise035','')
ylim([0.0 2.0])
xlabel('OB18t')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
label = cell2table(DATA_OB18t.NOISE000_intact([9:17],1)); 
set(gcf,'Color',[1 1 1])
subplot(1,2,2)
bar(categorical(table2array(label)),[cell2mat(DATA_OB18t.NOISE000_intact([9:17],2)) cell2mat(DATA_OB18t.NOISE015_intact([9:17],2)) cell2mat(DATA_OB18t.NOISE035_intact([9:17],2))])
% legend('noise0','noise15', 'noise35','')
yline(1,'k','LineWidth',1)
ylim([0.0 2.0])
xlabel("OB18t")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')

label = cell2table(DATA_Y10t.NOISE000_intact([2:8 18],1)); 
figure(2)
set(gcf,'Color',[1 1 1])
subplot(1,2,1)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_Y10t.NOISE000_intact([2:8 18],2)) cell2mat(DATA_Y10t.NOISE015_intact([2:8 18],2)) cell2mat(DATA_Y10t.NOISE035_intact([2:8 18],2))])
yline(1,'k','LineWidth',1)
legend('noise000','noise015', 'noise035','')
ylim([0.0 2.0])
xlabel('Y10t')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
label = cell2table(DATA_Y10t.NOISE000_intact([9:17],1)); 
set(gcf,'Color',[1 1 1])
subplot(1,2,2)
bar(categorical(table2array(label)),[cell2mat(DATA_Y10t.NOISE000_intact([9:17],2)) cell2mat(DATA_Y10t.NOISE015_intact([9:17],2)) cell2mat(DATA_Y10t.NOISE035_intact([9:17],2))])
% legend('noise0','noise15', 'noise35','')
yline(1,'k','LineWidth',1)
ylim([0.0 2.0])
xlabel("Y10t")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')







subplot(2,2,2)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_10t.SUMMARY([2:8 18],3)) cell2mat(DATA_MULTI_1018.SUMMARY([2:8 18],3)) cell2mat(DATA_MULTI_1010.SUMMARY([2:8 18],3))])
yline(1,'k','LineWidth',1)
% legend('single','10-18', '10-10','')
ylim([0.5 1.5])
xlabel('10t NOISE-001%')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,3)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_18t.SUMMARY([2:8 18],2)) cell2mat(DATA_MULTI_1018.SUMMARY([2:8 18],4)) cell2mat(DATA_MULTI_1818.SUMMARY([2:8 18],2))])
yline(1,'k','LineWidth',1)
% legend('single','10-18', '18-18','')
ylim([0.5 1.5])
xlabel('18t NOISE-000%')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,4)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_18t.SUMMARY([2:8 18],3)) cell2mat(DATA_MULTI_1018.SUMMARY([2:8 18],5)) cell2mat(DATA_MULTI_1818.SUMMARY([2:8 18],3))])
yline(1,'k','LineWidth',1)
% legend('single','10-18', '18-18','')
% ylim([0 7])
ylim([0.5 1.5])
xlabel("18t NOISE-001%")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')

figure(2)
set(gcf,'Color',[1 1 1])
label = cell2table(DATA_10t.SUMMARY([9:17],1)); 
subplot(2,2,1)
bar(categorical(table2array(label)),[cell2mat(DATA_10t.SUMMARY([9:17],2)) cell2mat(DATA_MULTI_1018.SUMMARY([9:17],2)) cell2mat(DATA_MULTI_1010.SUMMARY([9:17],2))])
% legend('single','10-18', '10-10','Location','southeast')
ylim([-0.1 0.1])
xlabel("10t NOISE-000%")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,2)
bar(categorical(table2array(label)),[cell2mat(DATA_10t.SUMMARY([9:17],3)) cell2mat(DATA_MULTI_1018.SUMMARY([9:17],3)) cell2mat(DATA_MULTI_1010.SUMMARY([9:17],3))])
% legend('single','10-18', '10-10','Location','southeast')
ylim([-0.1 0.1])
xlabel("10t NOISE-001%")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,3)
bar(categorical(table2array(label)),[cell2mat(DATA_18t.SUMMARY([9:17],2)) cell2mat(DATA_MULTI_1018.SUMMARY([9:17],4)) cell2mat(DATA_MULTI_1818.SUMMARY([9:17],2))])
% legend('single','10-18', '18-18','Location','southeast')
ylim([-0.1 0.1])
xlabel("18t NOISE-000%")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,4)
bar(categorical(table2array(label)),[cell2mat(DATA_18t.SUMMARY([9:17],3)) cell2mat(DATA_MULTI_1018.SUMMARY([9:17],5)) cell2mat(DATA_MULTI_1818.SUMMARY([9:17],3))])
% legend('single','10-18', '18-18','Location','southeast')
ylim([-0.1 0.1])
xlabel("18t NOISE-001%")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')

figure(3)
set(gcf,'Color',[1 1 1])
label = cell2table(DATA_10t.SUMMARY([2:8 18],1)); 
subplot(2,2,1)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_10t.SUMMARY([2:8 18],4)) cell2mat(DATA_MULTI_1018.SUMMARY([2:8 18],6)) cell2mat(DATA_MULTI_1010.SUMMARY([2:8 18],6))])
yline(1,'k','LineWidth',1)
% legend('single','10-18', '10-10','')
ylim([0.5 1.5])
xlabel('10t NOISE-000% damage')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,2)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_10t.SUMMARY([2:8 18],5)) cell2mat(DATA_MULTI_1018.SUMMARY([2:8 18],7)) cell2mat(DATA_MULTI_1010.SUMMARY([2:8 18],7))])
yline(1,'k','LineWidth',1)
% legend('single','10-18', '10-10','')
ylim([0.5 1.5])
xlabel('10t NOISE-001% damage')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,3)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_18t.SUMMARY([2:8 18],4)) cell2mat(DATA_MULTI_1018.SUMMARY([2:8 18],8)) cell2mat(DATA_MULTI_1818.SUMMARY([2:8 18],6))])
yline(1,'k','LineWidth',1)
% legend('single','10-18', '18-18','')
ylim([0.5 1.5])
xlabel('18t NOISE-000% damage')
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,4)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(DATA_18t.SUMMARY([2:8 18],5)) cell2mat(DATA_MULTI_1018.SUMMARY([2:8 18],9)) cell2mat(DATA_MULTI_1818.SUMMARY([2:8 18],7))])
yline(1,'k','LineWidth',1)
% legend('single','10-18', '18-18','')
ylim([0.5 1.5])
xlabel("18t NOISE-001% damage")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')

figure(4)
set(gcf,'Color',[1 1 1])
label = cell2table(DATA_10t.SUMMARY([9:17],1)); 

subplot(2,2,1)
bar(categorical(table2array(label)),[cell2mat(DATA_10t.SUMMARY([9:17],4)) cell2mat(DATA_MULTI_1018.SUMMARY([9:17],6)) cell2mat(DATA_MULTI_1010.SUMMARY([9:17],6))])
% legend('single','10-18', '10-10','Location','southeast')
ylim([-0.1 0.1])
xlabel("10t NOISE-000% damage")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,2)
bar(categorical(table2array(label)),[cell2mat(DATA_10t.SUMMARY([9:17],5)) cell2mat(DATA_MULTI_1018.SUMMARY([9:17],7)) cell2mat(DATA_MULTI_1010.SUMMARY([9:17],7))])
% legend('single','10-18', '10-10','Location','southeast')
ylim([-0.1 0.1])
xlabel("10t NOISE-001% damage")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,3)
bar(categorical(table2array(label)),[cell2mat(DATA_18t.SUMMARY([9:17],4)) cell2mat(DATA_MULTI_1018.SUMMARY([9:17],8)) cell2mat(DATA_MULTI_1818.SUMMARY([9:17],6))])
% legend('single','10-18', '18-18','Location','southeast')
ylim([-0.1 0.1])
xlabel("18t NOISE-000% damage")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
subplot(2,2,4)
bar(categorical(table2array(label)),[cell2mat(DATA_18t.SUMMARY([9:17],5)) cell2mat(DATA_MULTI_1018.SUMMARY([9:17],9)) cell2mat(DATA_MULTI_1818.SUMMARY([9:17],7))])
% legend('single','10-18', '18-18','Location','southeast')
ylim([-0.1 0.1])
xlabel("18t NOISE-001% damage")
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')






label = cell2table(VBI_est51_000.SUMMARY([2:8 18],1)); 
figure(1)
set(gcf,'Color',[1 1 1])
subplot(2,2,1)
bar(categorical(table2array(label),table2array(label),'Ordinal',true),[cell2mat(VBI_est51_000.SUMMARY([2:8 18],2))])
yline(1,'k','LineWidth',1)
 legend('single','10-18', '10-10','')
ylim([0.5 1.5])
xlabel('10t NOISE-000%')





