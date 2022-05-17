% -- before PSO
d1=[];  for ii=1:100; d1 =[d1;  VBI_est1_000{ii+1,6}( 1,:,1)']; end
cs1=[]; for ii=1:100; cs1=[cs1; VBI_est1_000{ii+1,6}( 2,:,1)']; end
cs2=[]; for ii=1:100; cs2=[cs2; VBI_est1_000{ii+1,6}( 3,:,1)']; end
ks1=[]; for ii=1:100; ks1=[ks1; VBI_est1_000{ii+1,6}( 4,:,1)']; end
ks2=[]; for ii=1:100; ks2=[ks2; VBI_est1_000{ii+1,6}( 5,:,1)']; end
mu1=[]; for ii=1:100; mu1=[mu1; VBI_est1_000{ii+1,6}( 6,:,1)']; end
mu2=[]; for ii=1:100; mu2=[mu2; VBI_est1_000{ii+1,6}( 7,:,1)']; end
ku1=[]; for ii=1:100; ku1=[ku1; VBI_est1_000{ii+1,6}( 8,:,1)']; end
ku2=[]; for ii=1:100; ku2=[ku2; VBI_est1_000{ii+1,6}( 9,:,1)']; end

ms1=(Veh_1.M-mu1-mu2).*(Veh_1.D-d1)/Veh_1.D;
ms2=(Veh_1.M-mu1-mu2).*(d1)/Veh_1.D;

EI01=[]; for ii=1:100; EI01=[EI01; VBI_est1_000{ii+1,6}(10,:,1)']; end
EI02=[]; for ii=1:100; EI02=[EI02; VBI_est1_000{ii+1,6}(11,:,1)']; end
EI03=[]; for ii=1:100; EI03=[EI03; VBI_est1_000{ii+1,6}(12,:,1)']; end
EI04=[]; for ii=1:100; EI04=[EI04; VBI_est1_000{ii+1,6}(13,:,1)']; end
EI05=[]; for ii=1:100; EI05=[EI05; VBI_est1_000{ii+1,6}(14,:,1)']; end
EI06=[]; for ii=1:100; EI06=[EI06; VBI_est1_000{ii+1,6}(15,:,1)']; end
EI07=[]; for ii=1:100; EI07=[EI07; VBI_est1_000{ii+1,6}(16,:,1)']; end
EI08=[]; for ii=1:100; EI08=[EI08; VBI_est1_000{ii+1,6}(17,:,1)']; end
EI09=[]; for ii=1:100; EI09=[EI09; VBI_est1_000{ii+1,6}(18,:,1)']; end
EI10=[]; for ii=1:100; EI10=[EI10; VBI_est1_000{ii+1,6}(19,:,1)']; end
EI11=[]; for ii=1:100; EI11=[EI11; VBI_est1_000{ii+1,6}(20,:,1)']; end
EI12=[]; for ii=1:100; EI12=[EI12; VBI_est1_000{ii+1,6}(21,:,1)']; end
EI13=[]; for ii=1:100; EI13=[EI13; VBI_est1_000{ii+1,6}(22,:,1)']; end
EI14=[]; for ii=1:100; EI14=[EI14; VBI_est1_000{ii+1,6}(23,:,1)']; end
EI15=[]; for ii=1:100; EI15=[EI15; VBI_est1_000{ii+1,6}(24,:,1)']; end
rA=[]; for ii=1:100; rA=[rA; VBI_est1_000{ii+1,6}(25,:,1)']; end
aC=[]; for ii=1:100; aC=[aC; VBI_est1_000{ii+1,6}(26,:,1)']; end
bC=[]; for ii=1:100; bC=[bC; VBI_est1_000{ii+1,6}(27,:,1)']; end

figure(1)
tiledlayout(5,2);
nexttile;histogram(ms1/(Veh_1.ms*Veh_1.d2/Veh_1.D),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(ms2/(Veh_1.ms*Veh_1.d1/Veh_1.D),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(cs1/(Veh_1.cs1),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(cs2/(Veh_1.cs2),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(ks1/(Veh_1.ks1),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(ks2/(Veh_1.ks2),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(mu1/(Veh_1.mu1),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(mu2/(Veh_1.mu2),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(ku1/(Veh_1.ku1),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(ku2/(Veh_1.ku2),0.8:0.01:1.2,'Normalization','Probability');hold on

figure(2)
tiledlayout(6,3);
nexttile;histogram(EI01/(Bri_1.EI_DATA(1)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI02/(Bri_1.EI_DATA(2)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI03/(Bri_1.EI_DATA(3)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI04/(Bri_1.EI_DATA(4)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI05/(Bri_1.EI_DATA(5)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI06/(Bri_1.EI_DATA(6)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI07/(Bri_1.EI_DATA(7)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI08/(Bri_1.EI_DATA(8)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI09/(Bri_1.EI_DATA(9)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI10/(Bri_1.EI_DATA(10)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI11/(Bri_1.EI_DATA(11)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI12/(Bri_1.EI_DATA(12)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI13/(Bri_1.EI_DATA(13)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI14/(Bri_1.EI_DATA(14)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(EI15/(Bri_1.EI_DATA(15)),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(rA/(Bri_1.rhoA),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(aC/(Bri_1.aC),0.8:0.01:1.2,'Normalization','Probability');hold on
nexttile;histogram(bC/(Bri_1.bC),0.8:0.01:1.2,'Normalization','Probability');hold on


% -- after PSO
d1=[];  for ii=1:100; d1 =[d1;  VBI_est1_000{ii+1,3}( 1,1)]; end
cs1=[]; for ii=1:100; cs1=[cs1; VBI_est1_000{ii+1,3}( 2,1)]; end
cs2=[]; for ii=1:100; cs2=[cs2; VBI_est1_000{ii+1,3}( 3,1)]; end
ks1=[]; for ii=1:100; ks1=[ks1; VBI_est1_000{ii+1,3}( 4,1)]; end
ks2=[]; for ii=1:100; ks2=[ks2; VBI_est1_000{ii+1,3}( 5,1)]; end
mu1=[]; for ii=1:100; mu1=[mu1; VBI_est1_000{ii+1,3}( 6,1)]; end
mu2=[]; for ii=1:100; mu2=[mu2; VBI_est1_000{ii+1,3}( 7,1)]; end
ku1=[]; for ii=1:100; ku1=[ku1; VBI_est1_000{ii+1,3}( 8,1)]; end
ku2=[]; for ii=1:100; ku2=[ku2; VBI_est1_000{ii+1,3}( 9,1)]; end

ms1=(Veh_1.M-mu1-mu2).*(Veh_1.D-d1)/Veh_1.D;
ms2=(Veh_1.M-mu1-mu2).*(d1)/Veh_1.D;

EI01=[]; for ii=1:100; EI01=[EI01; VBI_est1_000{ii+1,3}(10,:)]; end
EI02=[]; for ii=1:100; EI02=[EI02; VBI_est1_000{ii+1,3}(11,:)]; end
EI03=[]; for ii=1:100; EI03=[EI03; VBI_est1_000{ii+1,3}(12,:)]; end
EI04=[]; for ii=1:100; EI04=[EI04; VBI_est1_000{ii+1,3}(13,:)]; end
EI05=[]; for ii=1:100; EI05=[EI05; VBI_est1_000{ii+1,3}(14,:)]; end
EI06=[]; for ii=1:100; EI06=[EI06; VBI_est1_000{ii+1,3}(15,:)]; end
EI07=[]; for ii=1:100; EI07=[EI07; VBI_est1_000{ii+1,3}(16,:)]; end
EI08=[]; for ii=1:100; EI08=[EI08; VBI_est1_000{ii+1,3}(17,:)]; end
EI09=[]; for ii=1:100; EI09=[EI09; VBI_est1_000{ii+1,3}(18,:)]; end
EI10=[]; for ii=1:100; EI10=[EI10; VBI_est1_000{ii+1,3}(19,:)]; end
EI11=[]; for ii=1:100; EI11=[EI11; VBI_est1_000{ii+1,3}(20,:)]; end
EI12=[]; for ii=1:100; EI12=[EI12; VBI_est1_000{ii+1,3}(21,:)]; end
EI13=[]; for ii=1:100; EI13=[EI13; VBI_est1_000{ii+1,3}(22,:)]; end
EI14=[]; for ii=1:100; EI14=[EI14; VBI_est1_000{ii+1,3}(23,:)]; end
EI15=[]; for ii=1:100; EI15=[EI15; VBI_est1_000{ii+1,3}(24,:)]; end
rA=[]; for ii=1:100; rA=[rA; VBI_est1_000{ii+1,3}(25,:)]; end
aC=[]; for ii=1:100; aC=[aC; VBI_est1_000{ii+1,3}(26,:)]; end
bC=[]; for ii=1:100; bC=[bC; VBI_est1_000{ii+1,3}(27,:)]; end

figure(1)
nexttile(1);histogram(ms1/(Veh_1.ms*Veh_1.d2/Veh_1.D),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(2);histogram(ms2/(Veh_1.ms*Veh_1.d1/Veh_1.D),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(3);histogram(cs1/(Veh_1.cs1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(4);histogram(cs2/(Veh_1.cs2),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(5);histogram(ks1/(Veh_1.ks1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(6);histogram(ks2/(Veh_1.ks2),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(7);histogram(mu1/(Veh_1.mu1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(8);histogram(mu2/(Veh_1.mu2),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(9);histogram(ku1/(Veh_1.ku1),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(10);histogram(ku2/(Veh_1.ku2),0.8:0.01:1.2,'Normalization','Probability');hold off

figure(2)
nexttile(1);histogram(EI01/(Bri_1.EI_DATA(1)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(2);histogram(EI02/(Bri_1.EI_DATA(2)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(3);histogram(EI03/(Bri_1.EI_DATA(3)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(4);histogram(EI04/(Bri_1.EI_DATA(4)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(5);histogram(EI05/(Bri_1.EI_DATA(5)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(6);histogram(EI06/(Bri_1.EI_DATA(6)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(7);histogram(EI07/(Bri_1.EI_DATA(7)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(8);histogram(EI08/(Bri_1.EI_DATA(8)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(9);histogram(EI09/(Bri_1.EI_DATA(9)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(10);histogram(EI10/(Bri_1.EI_DATA(10)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(11);histogram(EI11/(Bri_1.EI_DATA(11)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(12);histogram(EI12/(Bri_1.EI_DATA(12)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(13);histogram(EI13/(Bri_1.EI_DATA(13)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(14);histogram(EI14/(Bri_1.EI_DATA(14)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(15);histogram(EI15/(Bri_1.EI_DATA(15)),0.8:0.01:1.2,'Normalization','Probability');ylim([0 0.1]);hold off
nexttile(16);histogram(rA/(Bri_1.rhoA),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(17);histogram(aC/(Bri_1.aC),0.8:0.01:1.2,'Normalization','Probability');hold off
nexttile(18);histogram(bC/(Bri_1.bC),0.8:0.01:1.2,'Normalization','Probability');hold off
