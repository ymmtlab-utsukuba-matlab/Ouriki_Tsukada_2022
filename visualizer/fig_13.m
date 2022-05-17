function fig_13(R,Veh_1,VBI_est1_000,filename)
%FIG_13 

KL=plot(R(:,1)+Veh_1.x_0-Veh_1.D,R(:,2),'k-'); hold on
PL=plot(VBI_est1_000{2,4}(:,1),VBI_est1_000{2,4}(:,2:3)); hold off
PL(1).Color = [0 0 1];
PL(2).Color = [1 0 0];

%% figure size
%-- metallic ratio
n=5; r=(n+sqrt(n^2+4))/2;
m=11; p=(m+sqrt(m^2+4))/2;

%-- axis
x=0.06; y=0.18; w=0.92;
num=3;

%% Road Profile

figure(1)

%-- figure setting
set(gcf,'Unit','centimeter','Position',[5,3,17,17/r])
set(gcf,'Color',[1 1 1])

%-- axis setting
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
set(gca,'Position',[x y w p*w/r/num])
xlim([-20 50])
ylim([-0.025 0.030])    

savefig(gcf,['figure\fig_13' filename '.fig'])
print(['figure\fig_13' filename],'-dsvg','-r1200')

end

