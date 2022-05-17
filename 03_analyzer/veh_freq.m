function Veh = veh_freq(Veh)
%VEH_FREQ calculates the natural frequency of the vehicle

%% Table 1, the vehicle parameters
ms  = Veh.ms;  %-- body mass [kg]
cs1 = Veh.cs1; %-- suspension damping [kg/s]
cs2 = Veh.cs2; %-- suspension damping [kg/s]
ks1 = Veh.ks1; %-- suspension stiffness [N/m]
ks2 = Veh.ks2; %-- suspension stiffness [N/m]
d1  = Veh.d1;  %-- front axle from G [m]
d2  = Veh.d2;  %-- rear axle from G [m]
mu1 = Veh.mu1; %-- unsprung-mass [kg]
mu2 = Veh.mu2; %-- unsprung-mass [kg]
ku1 = Veh.ku1; %-- tire stiffness [N/m]
ku2 = Veh.ku2; %-- tire stiffness [N/m]

%-- inertia moment
Is = ms*d1*d2;

%% Eq.(22), Mass Matrix
Mv = [ms*d2/(d1+d2) ms*d1/(d1+d2) 0             0             ;
      Is/(d1+d2)    -Is/(d1+d2)   0             0             ;
      0             0             mu1           0             ;
      0             0             0             mu2           ];

%% Eq.(25), Damping Matrix
Cv = [cs1           cs2           -cs1          -cs2          ;
      cs1*d1        -cs2*d2       -cs1*d1       cs2*d2        ;
      -cs1          0             cs1           0             ;
      0             -cs2          0             cs2           ];

%% Eq.(26), Stiffness Matrix
Kv = [ks1           ks2           -ks1          -ks2          ;
      cs1*d1        -ks2*d2       -ks1*d1       ks2*d2        ;
      -ks1          0             ks1+ku1       0             ;
      0             -ks2          0             ks2+ku2       ];

%% natural frequnecy

%-- non-damping natural frequency
A = Mv\Kv;
[V0, D0] = eig(A); %-- eigne value decomposition
L0=diag(D0).^(1/2)*(1i); %-- lambda
f0=diag(D0).^(1/2)/2/pi; %-- non-damping natural frequency [Hz]

%-- natural frequency
L1=L0;
for itr=1:100 %-- Newton-Raphson method
    for kk=1:4
        A = L1(kk)*Mv\Cv + Mv\Kv;
        [V, D] = eig(A); %-- eigne value decomposition
        L1(kk)=D(kk,kk)^(1/2); %-- lambda
    end
end
Veh.freq = real(L1)/2/pi; %-- natural frequency [Hz]

end

