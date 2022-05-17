RESULT_TILE = ["082_result" "084_result"];
EXPERIMENT_TILE = ["Experiment2" "Experiment4"];
nL = [0 0.15 0.35];



TABLE5{2,1} = "ms1";
TABLE5{3,1} = "ms2";
TABLE5{4,1} = "mu1";
TABLE5{5,1} = "mu2";
TABLE5{6,1} = "cs1";
TABLE5{7,1} = "cs2";
TABLE5{8,1} = "ks1";
TABLE5{9,1} = "ks2";
TABLE5{10,1} = "ku1";
TABLE5{11,1} = "ku2";
TABLE5{12,1} = "EI1";
TABLE5{13,1} = "EI8";
TABLE5{14,1} = "d1";
TABLE5{15,1} = "rhoA";
TABLE5{1,2} = "Noise-0 Mean";
TABLE5{1,3} = "Noise-0 Std";
TABLE5{1,4} = "Noise-15 Mean";
TABLE5{1,5} = "Noise-15 Std";
TABLE5{1,6} = "Noise-35 Mean";
TABLE5{1,7} = "Noise-35 Std";



ii = 1;
for jj =1:3
    load(['temp\' char(RESULT_TILE(ii)) '\' char(EXPERIMENT_TILE(ii)) '_data_nL_' num2str(nL(jj))  '.mat'])
    d1  =[];for kk=1:100; d1 =[d1; resRnd2(kk).d1]; end
    ms1 =[];for kk=1:100; ms1 =[ms1; Veh_3.ms * (Veh_3.D - resRnd2(kk).d1)/Veh_3.D/(Veh_3.ms/2)]; end
    ms2 =[];for kk=1:100; ms2 =[ms2; Veh_3.ms * resRnd2(kk).d1/Veh_3.D/(Veh_3.ms/2)]; end
    cs1 =[];for kk=1:100; cs1=[cs1;resRnd2(kk).cs1]; end
    cs2 =[];for kk=1:100; cs2=[cs2;resRnd2(kk).cs2]; end
    ks1 =[];for kk=1:100; ks1=[ks1;resRnd2(kk).ks1]; end
    ks2 =[];for kk=1:100; ks2=[ks2;resRnd2(kk).ks2]; end
    mu1 =[];for kk=1:100; mu1=[mu1;resRnd2(kk).mu1]; end
    mu2 =[];for kk=1:100; mu2=[mu2;resRnd2(kk).mu2]; end
    ku1 =[];for kk=1:100; ku1=[ku1;resRnd2(kk).ku1]; end
    ku2 =[];for kk=1:100; ku2=[ku2;resRnd2(kk).ku2]; end
    EI1 =[];for kk=1:100; EI1=[EI1;resRnd2(kk).EI(1,1)]; end
    EI8 =[];for kk=1:100; EI8=[EI8;resRnd2(kk).EI(8,1)]; end
    rA  =[];for kk=1:100; rA =[rA; resRnd2(kk).rhoA]; end

    TABLE5{ 2,6*(ii-1)+2*jj + 1-1}=mean(ms1);TABLE5{ 2,6*(ii-1)+2*jj + 1}=std(ms1);
    TABLE5{ 3,6*(ii-1)+2*jj + 1-1}=mean(ms2);TABLE5{ 3,6*(ii-1)+2*jj + 1}=std(ms2);
    TABLE5{ 4,6*(ii-1)+2*jj + 1-1}=mean(mu1);TABLE5{ 4,6*(ii-1)+2*jj + 1}=std(mu1);
    TABLE5{ 5,6*(ii-1)+2*jj + 1-1}=mean(mu2);TABLE5{ 5,6*(ii-1)+2*jj + 1}=std(mu2);
    TABLE5{ 6,6*(ii-1)+2*jj + 1-1}=mean(cs1);TABLE5{ 6,6*(ii-1)+2*jj + 1}=std(cs1);
    TABLE5{ 7,6*(ii-1)+2*jj + 1-1}=mean(cs2);TABLE5{ 7,6*(ii-1)+2*jj + 1}=std(cs2);
    TABLE5{ 8,6*(ii-1)+2*jj + 1-1}=mean(ks1);TABLE5{ 8,6*(ii-1)+2*jj + 1}=std(ks1);
    TABLE5{ 9,6*(ii-1)+2*jj + 1-1}=mean(ks2);TABLE5{ 9,6*(ii-1)+2*jj + 1}=std(ks2);
    TABLE5{10,6*(ii-1)+2*jj + 1-1}=mean(ku1);TABLE5{10,6*(ii-1)+2*jj + 1}=std(ku1);
    TABLE5{11,6*(ii-1)+2*jj + 1-1}=mean(ku2);TABLE5{11,6*(ii-1)+2*jj + 1}=std(ku2);
    TABLE5{12,6*(ii-1)+2*jj + 1-1}=mean(EI1);TABLE5{12,6*(ii-1)+2*jj + 1}=std(EI1);
    TABLE5{13,6*(ii-1)+2*jj + 1-1}=mean(EI8);TABLE5{13,6*(ii-1)+2*jj + 1}=std(EI8);
    TABLE5{14,6*(ii-1)+2*jj + 1-1}=mean(d1); TABLE5{14,6*(ii-1)+2*jj + 1}=std(d1);
    TABLE5{15,6*(ii-1)+2*jj + 1-1}=mean(rA); TABLE5{15,6*(ii-1)+2*jj + 1}=std(rA);
end

% ii = 2;
% for jj =1:3
%     load(['temp\' char(RESULT_TILE(ii)) '\' char(EXPERIMENT_TILE(ii)) '_data_nL_' num2str(nL(jj))  '.mat'])
%     d1  =[];for kk=1:20; d1 =[d1; resRnd2(kk).d1]; end
%     cs1 =[];for kk=1:20; cs1=[cs1;resRnd2(kk).cs1]; end
%     cs2 =[];for kk=1:20; cs2=[cs2;resRnd2(kk).cs2]; end
%     ks1 =[];for kk=1:20; ks1=[ks1;resRnd2(kk).ks1]; end
%     ks2 =[];for kk=1:20; ks2=[ks2;resRnd2(kk).ks2]; end
%     mu1 =[];for kk=1:20; mu1=[mu1;resRnd2(kk).mu1]; end
%     mu2 =[];for kk=1:20; mu2=[mu2;resRnd2(kk).mu2]; end
%     ku1 =[];for kk=1:20; ku1=[ku1;resRnd2(kk).ku1]; end
%     ku2 =[];for kk=1:20; ku2=[ku2;resRnd2(kk).ku2]; end
%     EI1 =[];for kk=1:20; EI1=[EI1;resRnd2(kk).EI(1,1)]; end
%     EI8 =[];for kk=1:20; EI8=[EI8;resRnd2(kk).EI(8,1)]; end
%     rA  =[];for kk=1:20; rA =[rA; resRnd2(kk).rhoA]; end
%     
%     
%     TABLE5{ 1,6*(ii-1)+2*jj + 1-1}=mean(d1); TABLE5{ 1,6*(ii-1)+2*jj + 1}=std(d1);
%     TABLE5{ 2,6*(ii-1)+2*jj + 1-1}=mean(cs1);TABLE5{ 2,6*(ii-1)+2*jj + 1}=std(cs1);
%     TABLE5{ 3,6*(ii-1)+2*jj + 1-1}=mean(cs2);TABLE5{ 3,6*(ii-1)+2*jj + 1}=std(cs2);
%     TABLE5{ 4,6*(ii-1)+2*jj + 1-1}=mean(ks1);TABLE5{ 4,6*(ii-1)+2*jj + 1}=std(ks1);
%     TABLE5{ 5,6*(ii-1)+2*jj + 1-1}=mean(ks2);TABLE5{ 5,6*(ii-1)+2*jj + 1}=std(ks2);
%     TABLE5{ 6,6*(ii-1)+2*jj + 1-1}=mean(mu1);TABLE5{ 6,6*(ii-1)+2*jj + 1}=std(mu1);
%     TABLE5{ 7,6*(ii-1)+2*jj + 1-1}=mean(mu2);TABLE5{ 7,6*(ii-1)+2*jj + 1}=std(mu2);
%     TABLE5{ 8,6*(ii-1)+2*jj + 1-1}=mean(ku1);TABLE5{ 8,6*(ii-1)+2*jj + 1}=std(ku1);
%     TABLE5{ 9,6*(ii-1)+2*jj + 1-1}=mean(ku2);TABLE5{ 9,6*(ii-1)+2*jj + 1}=std(ku2);
%     TABLE5{10,6*(ii-1)+2*jj + 1-1}=mean(EI1);TABLE5{10,6*(ii-1)+2*jj + 1}=std(EI1);
%     TABLE5{11,6*(ii-1)+2*jj + 1-1}=mean(EI8);TABLE5{11,6*(ii-1)+2*jj + 1}=std(EI8);
%     TABLE5{12,6*(ii-1)+2*jj + 1-1}=mean(rA); TABLE5{12,6*(ii-1)+2*jj + 1}=std(rA);
% end

% save('000_result_table\table5','TABLE5');