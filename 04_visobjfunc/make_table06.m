load data_2021_09_14.mat;

TABLE6 = zeros(15,12);

d1=[];   for ii=1:5; d1 =[d1;  VBI_est1_000(ii).GX( 1,1)]; end
cs1=[];  for ii=1:5; cs1=[cs1; VBI_est1_000(ii).GX( 1,2)]; end
cs2=[];  for ii=1:5; cs2=[cs2; VBI_est1_000(ii).GX( 1,3)]; end
ks1=[];  for ii=1:5; ks1=[ks1; VBI_est1_000(ii).GX( 1,4)]; end
ks2=[];  for ii=1:5; ks2=[ks2; VBI_est1_000(ii).GX( 1,5)]; end
mu1=[];  for ii=1:5; mu1=[mu1; VBI_est1_000(ii).GX( 1,6)]; end
mu2=[];  for ii=1:5; mu2=[mu2; VBI_est1_000(ii).GX( 1,7)]; end
ku1=[];  for ii=1:5; ku1=[ku1; VBI_est1_000(ii).GX( 1,8)]; end
ku2=[];  for ii=1:5; ku2=[ku2; VBI_est1_000(ii).GX( 1,9)]; end
EI1=[];  for ii=1:5; EI1=[EI1; VBI_est1_000(ii).GX(1,10)]; end
EI8=[];  for ii=1:5; EI8=[EI8; VBI_est1_000(ii).GX(1,16)]; end
rA=[];   for ii=1:5; rA= [rA;  VBI_est1_000(ii).GX(1,25)]; end

TABLE6(1:5,1)=d1'/Veh_3.d1;
TABLE6(1:5,2)=cs1'/Veh_3.cs1;
TABLE6(1:5,3)=cs2'/Veh_3.cs2;
TABLE6(1:5,4)=ks1'/Veh_3.ks1;
TABLE6(1:5,5)=ks2'/Veh_3.ks2;
TABLE6(1:5,6)=mu1'/Veh_3.mu1;
TABLE6(1:5,7)=mu2'/Veh_3.mu2;
TABLE6(1:5,8)=log10(ku1'/Veh_3.ku1);
TABLE6(1:5,9)=log10(ku2'/Veh_3.ku2);
TABLE6(1:5,10)=log10(EI1'/Bri_1.EI_DATA(1,1));
TABLE6(1:5,11)=log10(EI8'/Bri_1.EI_DATA(8,1));
TABLE6(1:5,12)=rA'/Bri_1.rhoA;

d1=[];   for ii=1:5; d1 =[d1;  VBI_est1_015(ii).GX( 1,1)]; end
cs1=[];  for ii=1:5; cs1=[cs1; VBI_est1_015(ii).GX( 1,2)]; end
cs2=[];  for ii=1:5; cs2=[cs2; VBI_est1_015(ii).GX( 1,3)]; end
ks1=[];  for ii=1:5; ks1=[ks1; VBI_est1_015(ii).GX( 1,4)]; end
ks2=[];  for ii=1:5; ks2=[ks2; VBI_est1_015(ii).GX( 1,5)]; end
mu1=[];  for ii=1:5; mu1=[mu1; VBI_est1_015(ii).GX( 1,6)]; end
mu2=[];  for ii=1:5; mu2=[mu2; VBI_est1_015(ii).GX( 1,7)]; end
ku1=[];  for ii=1:5; ku1=[ku1; VBI_est1_015(ii).GX( 1,8)]; end
ku2=[];  for ii=1:5; ku2=[ku2; VBI_est1_015(ii).GX( 1,9)]; end
EI1=[]; for ii=1:5; EI1=[EI1; VBI_est1_015(ii).GX(1,10)]; end
EI8=[]; for ii=1:5; EI8=[EI8; VBI_est1_015(ii).GX(1,16)]; end
rA=[];   for ii=1:5; rA=[rA; VBI_est1_015(ii).GX(1,25)]; end

TABLE6(6:10,1)=d1'/Veh_3.d1;
TABLE6(6:10,2)=cs1'/Veh_3.cs1;
TABLE6(6:10,3)=cs2'/Veh_3.cs2;
TABLE6(6:10,4)=ks1'/Veh_3.ks1;
TABLE6(6:10,5)=ks2'/Veh_3.ks2;
TABLE6(6:10,6)=mu1'/Veh_3.mu1;
TABLE6(6:10,7)=mu2'/Veh_3.mu2;
TABLE6(6:10,8)=log10(ku1'/Veh_3.ku1);
TABLE6(6:10,9)=log10(ku2'/Veh_3.ku2);
TABLE6(6:10,10)=log10(EI1'/Bri_1.EI_DATA(1,1));
TABLE6(6:10,11)=log10(EI8'/Bri_1.EI_DATA(8,1));
TABLE6(6:10,12)=rA'/Bri_1.rhoA;

d1=[];   for ii=1:5; d1 =[d1;  VBI_est1_035(ii).GX( 1,1)]; end
cs1=[];  for ii=1:5; cs1=[cs1; VBI_est1_035(ii).GX( 1,2)]; end
cs2=[];  for ii=1:5; cs2=[cs2; VBI_est1_035(ii).GX( 1,3)]; end
ks1=[];  for ii=1:5; ks1=[ks1; VBI_est1_035(ii).GX( 1,4)]; end
ks2=[];  for ii=1:5; ks2=[ks2; VBI_est1_035(ii).GX( 1,5)]; end
mu1=[];  for ii=1:5; mu1=[mu1; VBI_est1_035(ii).GX( 1,6)]; end
mu2=[];  for ii=1:5; mu2=[mu2; VBI_est1_035(ii).GX( 1,7)]; end
ku1=[];  for ii=1:5; ku1=[ku1; VBI_est1_035(ii).GX( 1,8)]; end
ku2=[];  for ii=1:5; ku2=[ku2; VBI_est1_035(ii).GX( 1,9)]; end
EI1=[]; for ii=1:5; EI1=[EI1; VBI_est1_035(ii).GX(1,10)]; end
EI8=[]; for ii=1:5; EI8=[EI8; VBI_est1_035(ii).GX(1,16)]; end
rA=[];   for ii=1:5; rA=[rA; VBI_est1_035(ii).GX(1,25)]; end

TABLE6(11:15,1)=d1'/Veh_3.d1;
TABLE6(11:15,2)=cs1'/Veh_3.cs1;
TABLE6(11:15,3)=cs2'/Veh_3.cs2;
TABLE6(11:15,4)=ks1'/Veh_3.ks1;
TABLE6(11:15,5)=ks2'/Veh_3.ks2;
TABLE6(11:15,6)=mu1'/Veh_3.mu1;
TABLE6(11:15,7)=mu2'/Veh_3.mu2;
TABLE6(11:15,8)=log10(ku1'/Veh_3.ku1);
TABLE6(11:15,9)=log10(ku2'/Veh_3.ku2);
TABLE6(11:15,10)=log10(EI1'/Bri_1.EI_DATA(1,1));
TABLE6(11:15,11)=log10(EI8'/Bri_1.EI_DATA(8,1));
TABLE6(11:15,12)=rA'/Bri_1.rhoA;

save('000_result_table\table6','TABLE6');