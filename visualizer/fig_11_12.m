function fig_11_12(Veh_1,Bri_1,VBI_est1_000,name_val)
%FIG_11 

% -- after PSO
d1=[];  for ii=1:20; d1 =[d1;  VBI_est1_000(ii).GX( 1,1)]; end
cs1=[]; for ii=1:20; cs1=[cs1; VBI_est1_000(ii).GX( 1,2)]; end
cs2=[]; for ii=1:20; cs2=[cs2; VBI_est1_000(ii).GX( 1,3)]; end
ks1=[]; for ii=1:20; ks1=[ks1; VBI_est1_000(ii).GX( 1,4)]; end
ks2=[]; for ii=1:20; ks2=[ks2; VBI_est1_000(ii).GX( 1,5)]; end
mu1=[]; for ii=1:20; mu1=[mu1; VBI_est1_000(ii).GX( 1,6)]; end
mu2=[]; for ii=1:20; mu2=[mu2; VBI_est1_000(ii).GX( 1,7)]; end
ku1=[]; for ii=1:20; ku1=[ku1; VBI_est1_000(ii).GX( 1,8)]; end
ku2=[]; for ii=1:20; ku2=[ku2; VBI_est1_000(ii).GX( 1,9)]; end
EI01=[]; for ii=1:20; EI01=[EI01; VBI_est1_000(ii).GX(1,10)]; end
EI02=[]; for ii=1:20; EI02=[EI02; VBI_est1_000(ii).GX(1,11)]; end
EI03=[]; for ii=1:20; EI03=[EI03; VBI_est1_000(ii).GX(1,12)]; end
EI04=[]; for ii=1:20; EI04=[EI04; VBI_est1_000(ii).GX(1,13)]; end
EI05=[]; for ii=1:20; EI05=[EI05; VBI_est1_000(ii).GX(1,14)]; end
EI06=[]; for ii=1:20; EI06=[EI06; VBI_est1_000(ii).GX(1,15)]; end
EI07=[]; for ii=1:20; EI07=[EI07; VBI_est1_000(ii).GX(1,16)]; end
EI08=[]; for ii=1:20; EI08=[EI08; VBI_est1_000(ii).GX(1,17)]; end
EI09=[]; for ii=1:20; EI09=[EI09; VBI_est1_000(ii).GX(1,18)]; end
EI10=[]; for ii=1:20; EI10=[EI10; VBI_est1_000(ii).GX(1,19)]; end
EI11=[]; for ii=1:20; EI11=[EI11; VBI_est1_000(ii).GX(1,20)]; end
EI12=[]; for ii=1:20; EI12=[EI12; VBI_est1_000(ii).GX(1,21)]; end
EI13=[]; for ii=1:20; EI13=[EI13; VBI_est1_000(ii).GX(1,22)]; end
EI14=[]; for ii=1:20; EI14=[EI14; VBI_est1_000(ii).GX(1,23)]; end
EI15=[]; for ii=1:20; EI15=[EI15; VBI_est1_000(ii).GX(1,24)]; end
rA=[]; for ii=1:20; rA=[rA; VBI_est1_000(ii).GX(1,25)]; end

figure(2)
tiledlayout(3,4);
nexttile(9);histogram(d1/(Veh_1.d1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(3);histogram(cs1/(Veh_1.cs1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(4);histogram(cs2/(Veh_1.cs2),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(5);histogram(ks1/(Veh_1.ks1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(6);histogram(ks2/(Veh_1.ks2),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(1);histogram(mu1/(Veh_1.mu1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(2);histogram(mu2/(Veh_1.mu2),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(7);histogram(ku1/(Veh_1.ku1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(8);histogram(ku2/(Veh_1.ku2),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(10);histogram(rA/Bri_1.rhoA,0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(11);histogram(EI01/Bri_1.EI,0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(12);histogram(EI08/Bri_1.EI,0.8:0.01:1.2,'Normalization','Probability');hold off

%-- figure setting
%% figure size
%-- metallic ratio
n=5; r=(n+sqrt(n^2+4))/2;
m=20; p=(m+sqrt(m^2+4))/2;

%-- axis
x=0.06; y=0.10; w=0.90;
num=4;

% Save

figure(2)
T2.Position=[x y w p*w/r/num];

%-- figure setting
set(gcf,'Unit','centimeter','Position',[8,4,17,5*17/r])
set(gcf,'color',[1 1 1]);
for ii=1:12
    nexttile(ii)
    set(gca,'FontSize',15,'FontName','Times New Roman')
    ylim([0 0.35])
end

end

