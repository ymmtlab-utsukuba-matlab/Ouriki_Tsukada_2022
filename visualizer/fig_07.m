function fig_07(S1, VBI_est1_015, VBI_est1_035, Sim)

%% figure size
%-- metallic ratio
n=5; r=(n+sqrt(n^2+4))/2;
m=11; p=(m+sqrt(m^2+4))/2;

%-- axis
x=0.06; y=0.18; w=0.92;
num=3;


%% Measured Data 1

figure(1)

%-- figure setting
set(gcf,'Unit','centimeter','Position',[5,3,17,17/r])
set(gcf,'Color',[1 1 1])

%-- plot
s1_000=S1(1,:);
s1_015=S1(1,:)+VBI_est1_015{2,1}(1,:);
s1_035=S1(1,:)+VBI_est1_035{2,1}(1,:);
PL = plot(Sim.t,[s1_035; s1_015; s1_000]);

%-- plot setting
set(PL(1),'Color',[1 0 0])
set(PL(2),'Color',[0 0 1])
set(PL(3),'Color',[0 0 0])

%-- axis setting
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
set(gca,'Position',[x y w p*w/r/num])
% ylim([-0.10 0.10])

savefig(gcf,'figure\fig_07_a.fig')
print('figure\fig_07_a','-dsvg','-r1200')

%% Measured Data 2

figure(2)

%-- figure setting
set(gcf,'Unit','centimeter','Position',[5,7,17,17/r])
set(gcf,'Color',[1 1 1])

%-- plot
s2_000=S1(2,:);
s2_015=S1(2,:)+VBI_est1_015{2,1}(2,:);
s2_035=S1(2,:)+VBI_est1_035{2,1}(2,:);
PL = plot(Sim.t,[s2_035; s2_015; s2_000]);

%-- plot setting
set(PL(1),'Color',[1 0 0])
set(PL(2),'Color',[0 0 1])
set(PL(3),'Color',[0 0 0])

%-- axis setting
set(gca,'FontSize',10)
set(gca,'FontName','Times New Roman')
set(gca,'Position',[x y w p*w/r/num])
% ylim([-0.10 0.10])

savefig(gcf,'figure\fig_07_b.fig')
print('figure\fig_07_b','-dsvg','-r1200')



end

