function [ MASS ] = mk_global_mass( rhoA_DATA, dL_DATA )
% GLOBAL STIFFNESS MATRIX returns "MASS", an GLOBAL MASS MATRIX
% of a simple beam.
% 
% OUTPUT
% MASS: global mass matrix
% 
% INPUT
% rhoA_DATA: vector having "rhoA" values of all element 
% dL_DATA: vector having "dL" value of all element
% 
% coded by Yamamoto Kyosuke, MAY/02, 2018

%% initialization
ENUM = length(rhoA_DATA);
DOF = 2*(ENUM+1);
MASS=zeros(DOF,DOF);

%% making MASS
for ii=1:ENUM
    M = mk_elem_mass(rhoA_DATA(ii),dL_DATA(ii));
    dof_itr = [2*ii-1 2*ii 2*ii+1 2*(ii+1)];
    MASS(dof_itr, dof_itr) = MASS(dof_itr, dof_itr) + M;
end

end

