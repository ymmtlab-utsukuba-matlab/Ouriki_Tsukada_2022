function [ K ] = mk_elem_stif( EI, dL )
%% *ELEMENT STIFFNESS MATRIX* 
% returns "K", an ELEMENT STIFFNESS MATRIX of a simple beam,
% corresponding to the given "EI", fexual rigidity, and "dL", the length
% of local 1D beam element.
% 
%% output
% K: "element stiffness matrix"
% 
%% input
% EI: production of "young modulus" and "inertia moment" 
% dL: "length of finite element beam"
% 
%% information
% This function is coded by Kyosuke Yamamoto, used for the course of 
% "Advanced Reliability Engineering", GSSIE, Univ. of Tsukuba, 2018.
% 
% coded on MAY 2, 2018
% 

%% making K
K = [12        6*dL         -12         6*dL         ;
         6*dL    4*dL^2     -6*dL     2*dL^2    ;
         -12       -6*dL       12           -6*dL       ;
         6*dL    2*dL^2     -6*dL     4*dL^2    ];
K = K*(EI/dL^3);

end

