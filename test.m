S   = S1;
Veh = Veh_3;
Bri = Bri_1;
dat = dat1;
nL  = 0.35;

Z = dat.Z;
Veh.Pc=(Z(:,1)-mean(Z,2))*(Z(:,1)-mean(Z,2))';
%-- Fixing the seed value of a random number generator
RMS_sig = sqrt(sum(S.^2,2)/length(S));  %-- RMS of measured Data
noise   = (RMS_sig*nL).*randn(size(S)); %-- generate noise
%-- add noise to simulated signal data
ddz = S+noise;
s = [ddz]; %-- observation vector, Eq.(48)
sk =  s;

C = zeros(27,1);
C(1)     = 1/2;  %-- d1= D*(10%-90%)
C(2:12)  = ones(11,1); %-- ms=ms*(80%-120%)
C(13:27) = ones(15,1); %-- EI=EI*(80%-120%)

%-- Vehicle Parameters 
D   = Veh.D;        %-- [m] distance between the front-rear axles
d1  = C(1)*D;       %-- [m] distance to the front axle from G
cs1 = C(2)*Veh.cs1; %-- [kg/s] damping of front sus
cs2 = C(3)*Veh.cs2; %-- [kg/s] damping of rear sus
ks1 = C(4)*Veh.ks1; %-- [N/m] spring stiffness of front sus
ks2 = C(5)*Veh.ks2; %-- [N/m] spring stiffness of rear sus
mu1 = C(6)*Veh.mu1; %-- [kg] unsprung-mass at front
mu2 = C(7)*Veh.mu2; %-- [kg] unsprung-mass at rear
ku1 = C(8)*Veh.ku1; %-- [N/m] spring stiffness of front tyre
ku2 = C(9)*Veh.ku2; %-- [N/m] spring stiffness of rear tyre

%-- Bridge Parameters
rhoA = C(10)*Bri.rhoA; %-- [kg/m] mass per unit length
EI   = Bri.EI;         %-- [N m3] flexual rigidity
aC   = C(11)*Bri.aC;   % alpha of Rayleigh damping for mass matirx
bC   = C(12)*Bri.bC;   % beta of Rayleigh damping for stiffness matrix

%% Beam-Element Properties
EI_DATA   = C(13:27)*EI;

Xv = [d1 cs1 cs2 ks1 ks2 mu1 mu2 ku1 ku2]';
Xb = [EI_DATA; rhoA; aC; bC;];
X  = [Xv; Xb];
[Q, R] = QRinitial(nL,dat);

[J,Z_hat,RP] = calObjFunc(X,sk,Veh,Bri,Sim,Q,R);
para_list = ["z_{s1}", "z_{s2}", "z_{u1}", "z_{u2}", "dz_{s1}", "dz_{s2}", "dz_{u1}", "dz_{u2}", "u_{1}", "u_{2}", "du_{1}", "du_{2}"];

for ff=1:4
    subplot(3,4,ff);plot(dat.z(ff,:),'r-');hold on;plot(Z_hat(ff,:)','b-');hold off
    title(para_list(ff));
end
for ff=5:8
    subplot(3,4,ff);plot(dat.dz(ff-4,:),'r-');hold on;plot(Z_hat(ff,:)','b-');hold off
    title(para_list(ff));
end
for ff=9:10
    subplot(3,4,ff);plot(dat.u(ff-8,:),'r-');hold on;plot(Z_hat(ff,:)','b-');hold off
    title(para_list(ff));
end
for ff=11:12
    subplot(3,4,ff);plot(dat.du(ff-10,:),'r-');hold on;plot(Z_hat(ff,:)','b-');hold off
    title(para_list(ff));
end