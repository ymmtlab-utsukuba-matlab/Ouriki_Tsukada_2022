function [B] = barrier(x,Veh)
%BARRIER この関数の概要をここに記述
%   詳細説明をここに記述
g = zeros(19,1);
h = 1e-4;

if Veh.M-x(6)-x(7)>0
    g(1)  = 0;
else
    g(1)  = 100000;
end

if Veh.D-h-x(1)>0
    g(2)  = 0;
else
    g(2)  = 100000;
end

for ii = 1:17
    if x(ii)-h>0
        g(ii+2)  = 0;
    else
        g(ii+2)  = 100000;
    end
end

B     = sum(g);

end

