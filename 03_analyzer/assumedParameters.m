function [X] = assumedParameters(Veh,Bri)
%ASSUMEDPARAMETERS returns assumed parameters

C = zeros(19,1);
C(1)     = 0.1+0.8*rand(1,1);  %-- d1= D*(10%-90%)
C(2:10)  = 0.8+0.4*rand(9,1); %-- ms=ms*(80%-120%)
C(11:12) = ones(2,1); %-- ms=ms*(80%-120%)
C(13:19) = 0.8+0.4*rand(7,1); %-- EI=EI*(80%-120%)
% C(1)     = 0.1+0.8*rand(1,1); %-- d1= D*(10%-90%)
% C(2:8)  = 0.8+0.4*rand(7,1); %-- ms=ms*(80%-120%)
% C(9:10) = 10.^(-1+2*rand(2,1)); %-- EI=EI*(80%-120%)
% C(11:12) = ones(2,1); %-- ms=ms*(80%-120%)
% C(13:19) = 10.^(-1+2*rand(7,1)); %-- EI=EI*(80%-120%)

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
EI_DATA   = C(13:19)*EI;

Xv = [d1 cs1 cs2 ks1 ks2 mu1 mu2 ku1 ku2]';
% Xb = [EI_DATA; rhoA; aC; bC];
Xb = [EI_DATA; rhoA];
X  = [Xv; Xb];

end

