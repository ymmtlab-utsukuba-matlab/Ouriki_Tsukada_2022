function [ STIF ] = mk_global_stif( EI_DATA, dL_DATA )
% GLOBAL STIFFNESS MATRIX returns "STIF", an GLOBAL STIFFNESS MATRIX
% of a simple beam.
% 
% OUTPUT
% STIF: global stiffness matrix
% 
% INPUT
% EI_DATA: vector having "EI" values of all element 
% dL_DATA: vector having "dL" value of all element
% 
% coded by Yamamoto Kyosuke, MAY/02, 2018

%% initialization
ENUM = length(EI_DATA);
DOF = 2*(ENUM+1);
STIF=zeros(DOF,DOF);

%% making STIF
for ii=1:ENUM
    K = mk_elem_stif(EI_DATA(ii),dL_DATA(ii));
    dof_itr = [2*ii-1 2*ii 2*ii+1 2*(ii+1)];
    STIF(dof_itr, dof_itr) = STIF(dof_itr, dof_itr) + K;
end

end