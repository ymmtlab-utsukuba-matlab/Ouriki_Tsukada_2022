function fig_06(Veh_1,R)
%FIG_06 
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

%-- plot

PL = plot(R(:,1)+Veh_1.x_0-Veh_1.D,R(:,2));

%-- plot setting
set(PL,'Color',[0 0 0])

%-- axis setting
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
set(gca,'Position',[x y w p*w/r/num])
xlim([-20 50])
% ylim([-0.10 0.10])

savefig(gcf,'figure\fig_06.fig')
print('figure\fig_06','-dsvg','-r1200')

end

