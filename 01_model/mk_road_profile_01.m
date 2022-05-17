function [R,S] = mk_road_profile_01()
%MK_ROAD_PROFILE_01 returns a road uneveness
% 
% coded by Yamamoto Kyosuke, Feb/21, 2021

%% Profile Parameters
%-- Good
a  = 0.0116; %-- coefficient a  (Extra Good: 0.001, Average:0.0030, Standard:0.0098);
b  = 0.0600; %-- coefficient b  (Extra Good: 0.050, Average:0.0200, Standard:0.0800);
xi = 1.9600; %-- coefficient xi (Extra Good: 2.000, Average:2.5000, Standard:1.9200);

%-- pathway
L  = 300;  %-- [m] generated length
dX = 0.10; %-- [m] position increment
X  = 0:dX:L;

%% Power Spectrum
df = 1/L;                  %-- [cycle/cm] frequency increment
w  = (0:df:(1/dX/2))';     %-- [cycle/m] spatial frequency
S  = a*(w.^xi+b^xi).^(-1); %-- [cm2 cyc/m] power 

S  = S/100; %-- convert from [cm] to [m] (* S/10000 is different from ISO data)

%-- random phase generation (Monte Carlo Simulation)
PH = [0;2*pi*rand(length(w)-1,1)]; %-- phase

%% Spatial Frourier Transform of R
Rf = sqrt(S).*(cos(PH)+1i*sin(PH)); 

Rf = [Rf; conj(Rf(length(Rf):-1:2,:))];
R  = ifft(Rf/dX);

R  = [X' R];
S  = [w  S];

end

