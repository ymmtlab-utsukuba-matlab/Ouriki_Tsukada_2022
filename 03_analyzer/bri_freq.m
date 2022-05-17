function Bri = bri_freq(Bri)
%BRI_FREQ 

MASS0_B = Bri.MASS0;
DAMP0_B = Bri.DAMP0;
STIF0_B = Bri.STIF0;

%% natural frequnecy

%-- non-damping natural frequency
A = MASS0_B\STIF0_B;
[~, D0] = eig(A); %-- eigne value decomposition
L0=diag(D0).^(1/2)*(1i); %-- lambda
% f0=diag(D0).^(1/2)/2/pi; %-- non-damping natural frequency [Hz]

%-- natural frequency
L1=L0;
for itr=1:100 %-- Newton-Raphson method
    for kk=1:30
        A = L1(kk)*MASS0_B\DAMP0_B + MASS0_B\STIF0_B;
        [~, D] = eig(A); %-- eigne value decomposition
        L1(kk)=D(kk,kk)^(1/2); %-- lambda
    end
end
Bri.freq=real(L1)/2/pi; %-- natural frequency [Hz]


end

