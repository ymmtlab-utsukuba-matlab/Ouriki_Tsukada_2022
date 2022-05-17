function [ M ] = mk_elem_mass( rhoA, dL )
%% *ELEMENT MASS MATRIX* 
% returns "M", an ELEMENT MASS MATRIX of a simple beam,
% corresponding to the given "rhoA", mass per unit length and area of
% cross-section, and "dL", the length of local 1D beam element.
% 
%% output
% M: "element mass matrix"
% 
%% input
% rhoA: production of "mass per unit length" and "area of cross section" 
% dL: "length of finite element beam"
% 
%% information
% This function is coded by Kyosuke Yamamoto, used for the course of 
% "Advanced Reliability Engineering", GSSIE, Univ. of Tsukuba, 2018.
% 
% coded on MAY 2, 2018
% 

%% making M
M = [156           -22*dL      54           13*dL     ;
          -22*dL      4*dL^2     -13*dL   -3*dL^2  ;
          54             -13*dL      156        22*dL     ;
          13*dL       -3*dL        22*dL    4*dL      ];
M = M*(rhoA*dL/420);

end

