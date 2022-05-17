function fig_09(Bri_1,Sim,dat1,dat2)

%% figure size
%-- metallic ratio
n=5; r=(n+sqrt(n^2+4))/2;
m=11; p=(m+sqrt(m^2+4))/2;

%-- axis
x=0.06; y=0.18; w=0.92;
num=3;


%% Displacement

figure(1)

%-- figure setting
set(gcf,'Unit','centimeter','Position',[5,3,17,17/r])
set(gcf,'Color',[1 1 1])

%-- plot
dL = Bri_1.dL_DATA(8);
y1 = [1/2 dL/4 1/2 -dL/4]*dat1.y([15 16 17 18],:); %-- intact at L/2
y2 = [1/2 dL/4 1/2 -dL/4]*dat2.y([15 16 17 18],:); %-- damaged at L/2
PL = plot(Sim.t,[y2; y1]);

%-- plot setting
set(PL(1),'Color',[1 0 0])
set(PL(2),'Color',[0 0 1])

%-- axis setting
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
set(gca,'Position',[x y w p*w/r/num])

savefig(gcf,'figure\fig_09_a.fig')
print('figure\fig_09_a','-dsvg','-r1200')


%% Velocity

figure(2)

%-- figure setting
set(gcf,'Unit','centimeter','Position',[5,7,17,17/r])
set(gcf,'Color',[1 1 1])

%-- plot
dL = Bri_1.dL_DATA(8);
dy1 = [1/2 dL/4 1/2 -dL/4]*dat1.dy([15 16 17 18],:); %-- intact at L/2
dy2 = [1/2 dL/4 1/2 -dL/4]*dat2.dy([15 16 17 18],:); %-- damaged at L/2
PL = plot(Sim.t,[dy2; dy1]);

%-- plot setting
set(PL(1),'Color',[1 0 0])
set(PL(2),'Color',[0 0 1])

%-- axis setting
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
set(gca,'Position',[x y w p*w/r/num])

savefig(gcf,'figure\fig_09_b.fig')
print('figure\fig_09_b','-dsvg','-r1200')

%% Acceleration

figure(3)

%-- figure setting
set(gcf,'Unit','centimeter','Position',[5,11,17,17/r])
set(gcf,'Color',[1 1 1])

%-- plot
dL = Bri_1.dL_DATA(8);
ddy1 = [1/2 dL/4 1/2 -dL/4]*dat1.ddy([15 16 17 18],:); %-- intact at L/2
ddy2 = [1/2 dL/4 1/2 -dL/4]*dat2.ddy([15 16 17 18],:); %-- damaged at L/2
PL = plot(Sim.t,[ddy2; ddy1]);

%-- plot setting
set(PL(1),'Color',[1 0 0])
set(PL(2),'Color',[0 0 1])

%-- axis setting
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
set(gca,'Position',[x y w p*w/r/num])

savefig(gcf,'figure\fig_09_c.fig')
print('figure\fig_09_c','-dsvg','-r1200')

end

