clear;
clc;

% load 'data_2021_01_26.mat'

% CORRECT = {Veh_1.d1 Veh_1.cs1 Veh_1.cs2 Veh_1.ks1 Veh_1.ks2 Veh_1.mu1 Veh_1.mu2 Veh_1.ku1 Veh_1.ku2 Bri_1.EI Bri_1.rhoA};
% CORRECT = {Veh_2.d1 Veh_2.cs1 Veh_2.cs2 Veh_2.ks1 Veh_2.ks2 Veh_2.mu1 Veh_2.mu2 Veh_2.ku1 Veh_2.ku2 Bri_1.EI Bri_1.rhoA};
% CORRECT = {Veh_3.d1 Veh_3.cs1 Veh_3.cs2 Veh_3.ks1 Veh_3.ks2 Veh_3.mu1 Veh_3.mu2 Veh_3.ku1 Veh_3.ku2 Bri_1.EI Bri_1.rhoA};
% CORRECT = {Veh_5.d1 Veh_5.cs1 Veh_5.cs2 Veh_5.ks1 Veh_5.ks2 Veh_5.mu1 Veh_5.mu2 Veh_5.ku1 Veh_5.ku2 Bri_1.EI Bri_1.rhoA};
% CORRECT = {Veh_6.d1 Veh_6.cs1 Veh_6.cs2 Veh_6.ks1 Veh_6.ks2 Veh_6.mu1 Veh_6.mu2 Veh_6.ku1 Veh_6.ku2 Bri_1.EI Bri_1.rhoA};
CORRECT = {Veh_7.d1 Veh_7.cs1 Veh_7.cs2 Veh_7.ks1 Veh_7.ks2 Veh_7.mu1 Veh_7.mu2 Veh_7.ku1 Veh_7.ku2 Bri_1.EI Bri_1.rhoA};

EST1_000_1{2,1} = "d1";   EST1_015_1{2,1} = "d1";  EST1_035_1{2,1} = "d1";
EST1_000_1{3,1} = "cs1";  EST1_015_1{3,1} = "cs1"; EST1_035_1{3,1} = "cs1";
EST1_000_1{4,1} = "cs2";  EST1_015_1{4,1} = "cs2"; EST1_035_1{4,1} = "cs2"; 
EST1_000_1{5,1} = "ks1";  EST1_015_1{5,1} = "ks1"; EST1_035_1{5,1} = "ks1";
EST1_000_1{6,1} = "ks2";  EST1_015_1{6,1} = "ks2"; EST1_035_1{6,1} = "ks2";
EST1_000_1{7,1} = "mu1";  EST1_015_1{7,1} = "mu1"; EST1_035_1{7,1} = "mu1"; 
EST1_000_1{8,1} = "mu2";  EST1_015_1{8,1} = "mu2"; EST1_035_1{8,1} = "mu2"; 
EST1_000_1{9,1} = "ku1";  EST1_015_1{9,1} = "ku1"; EST1_035_1{9,1} = "ku1";
EST1_000_1{10,1} = "ku2"; EST1_015_1{10,1} = "ku2"; EST1_035_1{10,1} = "ku2";
EST1_000_1{11,1} = "EI1"; EST1_015_1{11,1} = "EI1"; EST1_035_1{11,1} = "EI1";
EST1_000_1{12,1} = "EI2"; EST1_015_1{12,1} = "EI2"; EST1_035_1{12,1} = "EI2"; 
EST1_000_1{13,1} = "EI3"; EST1_015_1{13,1} = "EI3"; EST1_035_1{13,1} = "EI3";
EST1_000_1{14,1} = "EI4"; EST1_015_1{14,1} = "EI4"; EST1_035_1{14,1} = "EI4";
EST1_000_1{15,1} = "EI5"; EST1_015_1{15,1} = "EI5"; EST1_035_1{15,1} = "EI5";
EST1_000_1{16,1} = "EI6"; EST1_015_1{16,1} = "EI6"; EST1_035_1{16,1} = "EI6";
EST1_000_1{17,1} = "EI7"; EST1_015_1{17,1} = "EI7"; EST1_035_1{17,1} = "EI7";
EST1_000_1{18,1} = "rhoA";EST1_015_1{18,1} = "rhoA";EST1_035_1{18,1} = "rhoA";
EST1_000_1{19,1} = "ms1"; EST1_015_1{19,1} = "ms1"; EST1_035_1{19,1} = "ms1";
EST1_000_1{20,1} = "ms2"; EST1_015_1{20,1} = "ms2"; EST1_035_1{20,1} = "ms2";



for ii = 1:6
    EST1_000_1{1,1+ii} = [num2str(ii) '回目'];
    EST1_015_1{1,1+ii} = [num2str(ii) '回目'];
    EST1_035_1{1,1+ii} = [num2str(ii) '回目'];
   
  
    for jj = 1:17
        if jj < 8
            EST1_000_1{jj+1,ii+1} = VBI_est7_000(ii).GX(1,jj)/CORRECT{jj};
            EST1_015_1{jj+1,ii+1} = VBI_est7_015(ii).GX(1,jj)/CORRECT{jj};
            EST1_035_1{jj+1,ii+1} = VBI_est7_035(ii).GX(1,jj)/CORRECT{jj};

        elseif (7 < jj)&&(jj < 10)
            EST1_000_1{jj+1,ii+1} = VBI_est7_000(ii).GX(1,jj)/CORRECT{jj};
            EST1_015_1{jj+1,ii+1} = VBI_est7_015(ii).GX(1,jj)/CORRECT{jj};
            EST1_035_1{jj+1,ii+1} = VBI_est7_035(ii).GX(1,jj)/CORRECT{jj};
            
        elseif (9 < jj)&&(jj < 17)
            EST1_000_1{jj+1,ii+1} = VBI_est7_000(ii).GX(1,jj)/CORRECT{10};
            EST1_015_1{jj+1,ii+1} = VBI_est7_015(ii).GX(1,jj)/CORRECT{10};
            EST1_035_1{jj+1,ii+1} = VBI_est7_035(ii).GX(1,jj)/CORRECT{10};
 
        elseif jj == 17
            EST1_000_1{jj+1,ii+1} = VBI_est7_000(ii).GX(1,jj)/CORRECT{11};
            EST1_015_1{jj+1,ii+1} = VBI_est7_015(ii).GX(1,jj)/CORRECT{11};
            EST1_035_1{jj+1,ii+1} = VBI_est7_035(ii).GX(1,jj)/CORRECT{11};
 
        end
    end
end

CORRECT_ms1 = Veh_7.ms*(Veh_7.D -Veh_7.d1)/Veh_7.D;
CORRECT_ms2 = Veh_7.ms*Veh_7.d1/Veh_7.D;

for ii = 1:6
    EST1_000_1{19,ii+1} = Veh_7.ms * (Veh_7.D - VBI_est7_000(ii).GX(1,1))/Veh_7.D/CORRECT_ms1;
    EST1_000_1{20,ii+1} = Veh_7.ms * VBI_est7_000(ii).GX(1,1)/Veh_7.D/CORRECT_ms2;
    EST1_015_1{19,ii+1} = Veh_7.ms * (Veh_7.D - VBI_est7_015(ii).GX(1,1))/Veh_7.D/CORRECT_ms1;
    EST1_015_1{20,ii+1} = Veh_7.ms * VBI_est7_015(ii).GX(1,1)/Veh_7.D/CORRECT_ms2;
    EST1_035_1{19,ii+1} = Veh_7.ms * (Veh_7.D - VBI_est7_035(ii).GX(1,1))/Veh_7.D/CORRECT_ms1;
    EST1_035_1{20,ii+1} = Veh_7.ms * VBI_est7_035(ii).GX(1,1)/Veh_7.D/CORRECT_ms2;
  
end

SUM2{2,1} = "d1";
SUM2{3,1} = "cs1";
SUM2{4,1} = "cs2";
SUM2{5,1} = "ks1";
SUM2{6,1} = "ks2";
SUM2{7,1} = "mu1";
SUM2{8,1} = "mu2";
SUM2{9,1} = "ku1";
SUM2{10,1} = "ku2";
SUM2{11,1} = "EI01";
SUM2{12,1} = "EI02";
SUM2{13,1} = "EI03";
SUM2{14,1} = "EI04";
SUM2{15,1} = "EI05";
SUM2{16,1} = "EI06";
SUM2{17,1} = "EI07";
SUM2{18,1} = "rhoA";
SUM2{19,1} = "ms1";
SUM2{20,1} = "ms2";
SUM2{1,2} = "Noise-000 Mean";
SUM2{1,3} = "Noise-015 Mean";
SUM2{1,4} = "Noise-035 Mean";


for jj = 1:19
    SUM2{jj+1,2} = mean(cell2mat(EST1_000_1(jj+1,2:end)));
    SUM2{jj+1,3} = mean(cell2mat(EST1_015_1(jj+1,2:end)));
    SUM2{jj+1,4} = mean(cell2mat(EST1_035_1(jj+1,2:end)));
end

DATA_I10t.NOISE000  = EST1_000_1;
DATA_I10t.NOISE015  = EST1_015_1;
DATA_I10t.NOISE035  = EST1_035_1;
DATA_I10t.SUMMARY = SUM2;

save('DATA_I10t.mat','DATA_I10t')