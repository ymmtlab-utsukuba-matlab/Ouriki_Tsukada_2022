load data_2021_09_14.mat;

TABLE7 = zeros(12,6);

d1=[];   for ii=1:20; d1 =[d1;  VBI_est1_000(ii).GX( 1,1)]; end
cs1=[];  for ii=1:20; cs1=[cs1; VBI_est1_000(ii).GX( 1,2)]; end
cs2=[];  for ii=1:20; cs2=[cs2; VBI_est1_000(ii).GX( 1,3)]; end
ks1=[];  for ii=1:20; ks1=[ks1; VBI_est1_000(ii).GX( 1,4)]; end
ks2=[];  for ii=1:20; ks2=[ks2; VBI_est1_000(ii).GX( 1,5)]; end
mu1=[];  for ii=1:20; mu1=[mu1; VBI_est1_000(ii).GX( 1,6)]; end
mu2=[];  for ii=1:20; mu2=[mu2; VBI_est1_000(ii).GX( 1,7)]; end
ku1=[];  for ii=1:20; ku1=[ku1; VBI_est1_000(ii).GX( 1,8)]; end
ku2=[];  for ii=1:20; ku2=[ku2; VBI_est1_000(ii).GX( 1,9)]; end
EI1=[]; for ii=1:20; EI1=[EI1; VBI_est1_000(ii).GX(1,10)]; end
EI8=[]; for ii=1:20; EI8=[EI8; VBI_est1_000(ii).GX(1,16)]; end
rA=[];   for ii=1:20; rA=[rA; VBI_est1_000(ii).GX(1,25)]; end

d1=d1/Veh_3.d1;
cs1=cs1/Veh_3.cs1;
cs2=cs2/Veh_3.cs2;
ks1=ks1/Veh_3.ks1;
ks2=ks2/Veh_3.ks2;
mu1=mu1/Veh_3.mu1;
mu2=mu2/Veh_3.mu2;
ku1=log10(ku1/Veh_3.ku1);
ku2=log10(ku2/Veh_3.ku2);
EI1=log10(EI1/Bri_1.EI_DATA(1,1));
EI8=log10(EI8/Bri_1.EI_DATA(8,1));
rA=rA/Bri_1.rhoA;

jj = 1;
TABLE7( 1,2*jj-1)=mean(d1); TABLE7( 1,2*jj)=std(d1);
TABLE7( 2,2*jj-1)=mean(cs1);TABLE7( 2,2*jj)=std(cs1);
TABLE7( 3,2*jj-1)=mean(cs2);TABLE7( 3,2*jj)=std(cs2);
TABLE7( 4,2*jj-1)=mean(ks1);TABLE7( 4,2*jj)=std(ks1);
TABLE7( 5,2*jj-1)=mean(ks2);TABLE7( 5,2*jj)=std(ks2);
TABLE7( 6,2*jj-1)=mean(mu1);TABLE7( 6,2*jj)=std(mu1);
TABLE7( 7,2*jj-1)=mean(mu2);TABLE7( 7,2*jj)=std(mu2);
TABLE7( 8,2*jj-1)=mean(ku1);TABLE7( 8,2*jj)=std(ku1);
TABLE7( 9,2*jj-1)=mean(ku2);TABLE7( 9,2*jj)=std(ku2);
TABLE7(10,2*jj-1)=mean(EI1);TABLE7(10,2*jj)=std(EI1);
TABLE7(11,2*jj-1)=mean(EI8);TABLE7(11,2*jj)=std(EI8);
TABLE7(12,2*jj-1)=mean(rA); TABLE7(12,2*jj)=std(rA);

d1=[];   for ii=1:20; d1 =[d1;  VBI_est1_015(ii).GX( 1,1)]; end
cs1=[];  for ii=1:20; cs1=[cs1; VBI_est1_015(ii).GX( 1,2)]; end
cs2=[];  for ii=1:20; cs2=[cs2; VBI_est1_015(ii).GX( 1,3)]; end
ks1=[];  for ii=1:20; ks1=[ks1; VBI_est1_015(ii).GX( 1,4)]; end
ks2=[];  for ii=1:20; ks2=[ks2; VBI_est1_015(ii).GX( 1,5)]; end
mu1=[];  for ii=1:20; mu1=[mu1; VBI_est1_015(ii).GX( 1,6)]; end
mu2=[];  for ii=1:20; mu2=[mu2; VBI_est1_015(ii).GX( 1,7)]; end
ku1=[];  for ii=1:20; ku1=[ku1; VBI_est1_015(ii).GX( 1,8)]; end
ku2=[];  for ii=1:20; ku2=[ku2; VBI_est1_015(ii).GX( 1,9)]; end
EI1=[]; for ii=1:20; EI1=[EI1; VBI_est1_015(ii).GX(1,10)]; end
EI8=[]; for ii=1:20; EI8=[EI8; VBI_est1_015(ii).GX(1,16)]; end
rA=[];   for ii=1:20; rA=[rA; VBI_est1_015(ii).GX(1,25)]; end

d1=d1/Veh_3.d1;
cs1=cs1/Veh_3.cs1;
cs2=cs2/Veh_3.cs2;
ks1=ks1/Veh_3.ks1;
ks2=ks2/Veh_3.ks2;
mu1=mu1/Veh_3.mu1;
mu2=mu2/Veh_3.mu2;
ku1=log10(ku1/Veh_3.ku1);
ku2=log10(ku2/Veh_3.ku2);
EI1=log10(EI1/Bri_1.EI_DATA(1,1));
EI8=log10(EI8/Bri_1.EI_DATA(8,1));
rA=rA/Bri_1.rhoA;

jj = 2;
TABLE7( 1,2*jj-1)=mean(d1); TABLE7( 1,2*jj)=std(d1);
TABLE7( 2,2*jj-1)=mean(cs1);TABLE7( 2,2*jj)=std(cs1);
TABLE7( 3,2*jj-1)=mean(cs2);TABLE7( 3,2*jj)=std(cs2);
TABLE7( 4,2*jj-1)=mean(ks1);TABLE7( 4,2*jj)=std(ks1);
TABLE7( 5,2*jj-1)=mean(ks2);TABLE7( 5,2*jj)=std(ks2);
TABLE7( 6,2*jj-1)=mean(mu1);TABLE7( 6,2*jj)=std(mu1);
TABLE7( 7,2*jj-1)=mean(mu2);TABLE7( 7,2*jj)=std(mu2);
TABLE7( 8,2*jj-1)=mean(ku1);TABLE7( 8,2*jj)=std(ku1);
TABLE7( 9,2*jj-1)=mean(ku2);TABLE7( 9,2*jj)=std(ku2);
TABLE7(10,2*jj-1)=mean(EI1);TABLE7(10,2*jj)=std(EI1);
TABLE7(11,2*jj-1)=mean(EI8);TABLE7(11,2*jj)=std(EI8);
TABLE7(12,2*jj-1)=mean(rA); TABLE7(12,2*jj)=std(rA);

d1=[];   for ii=1:20; d1 =[d1;  VBI_est1_035(ii).GX( 1,1)]; end
cs1=[];  for ii=1:20; cs1=[cs1; VBI_est1_035(ii).GX( 1,2)]; end
cs2=[];  for ii=1:20; cs2=[cs2; VBI_est1_035(ii).GX( 1,3)]; end
ks1=[];  for ii=1:20; ks1=[ks1; VBI_est1_035(ii).GX( 1,4)]; end
ks2=[];  for ii=1:20; ks2=[ks2; VBI_est1_035(ii).GX( 1,5)]; end
mu1=[];  for ii=1:20; mu1=[mu1; VBI_est1_035(ii).GX( 1,6)]; end
mu2=[];  for ii=1:20; mu2=[mu2; VBI_est1_035(ii).GX( 1,7)]; end
ku1=[];  for ii=1:20; ku1=[ku1; VBI_est1_035(ii).GX( 1,8)]; end
ku2=[];  for ii=1:20; ku2=[ku2; VBI_est1_035(ii).GX( 1,9)]; end
EI1=[]; for ii=1:20; EI1=[EI1; VBI_est1_035(ii).GX(1,10)]; end
EI8=[]; for ii=1:20; EI8=[EI8; VBI_est1_035(ii).GX(1,16)]; end
rA=[];   for ii=1:20; rA=[rA; VBI_est1_035(ii).GX(1,25)]; end

d1=d1/Veh_3.d1;
cs1=cs1/Veh_3.cs1;
cs2=cs2/Veh_3.cs2;
ks1=ks1/Veh_3.ks1;
ks2=ks2/Veh_3.ks2;
mu1=mu1/Veh_3.mu1;
mu2=mu2/Veh_3.mu2;
ku1=log10(ku1/Veh_3.ku1);
ku2=log10(ku2/Veh_3.ku2);
EI1=log10(EI1/Bri_1.EI_DATA(1,1));
EI8=log10(EI8/Bri_1.EI_DATA(8,1));
rA=rA/Bri_1.rhoA;

jj = 3;
TABLE7( 1,2*jj-1)=mean(d1); TABLE7( 1,2*jj)=std(d1);
TABLE7( 2,2*jj-1)=mean(cs1);TABLE7( 2,2*jj)=std(cs1);
TABLE7( 3,2*jj-1)=mean(cs2);TABLE7( 3,2*jj)=std(cs2);
TABLE7( 4,2*jj-1)=mean(ks1);TABLE7( 4,2*jj)=std(ks1);
TABLE7( 5,2*jj-1)=mean(ks2);TABLE7( 5,2*jj)=std(ks2);
TABLE7( 6,2*jj-1)=mean(mu1);TABLE7( 6,2*jj)=std(mu1);
TABLE7( 7,2*jj-1)=mean(mu2);TABLE7( 7,2*jj)=std(mu2);
TABLE7( 8,2*jj-1)=mean(ku1);TABLE7( 8,2*jj)=std(ku1);
TABLE7( 9,2*jj-1)=mean(ku2);TABLE7( 9,2*jj)=std(ku2);
TABLE7(10,2*jj-1)=mean(EI1);TABLE7(10,2*jj)=std(EI1);
TABLE7(11,2*jj-1)=mean(EI8);TABLE7(11,2*jj)=std(EI8);
TABLE7(12,2*jj-1)=mean(rA); TABLE7(12,2*jj)=std(rA);

save('000_result_table\table7','TABLE7');