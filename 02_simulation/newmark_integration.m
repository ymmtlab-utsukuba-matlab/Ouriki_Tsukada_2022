function [ x, dx ] = newmark_integration( ddx, dt, G, B )
% NEWMARK_BETA returns the results of integration based on
%  Newmark Beta method
% 
% coded by Yamamoto Kyosuke, Feb/21, 2021

%% Initialization
x=zeros(size(ddx));
dx=zeros(size(ddx));

%% Integration
for tt=2:length(ddx)
    %-- calculation of velocity and displacement responses
    dx(:,tt) = dx(:,tt-1) + dt*(1-G)*ddx(:,tt-1) + dt*G*ddx(:,tt); %-- Eq.(35)
    x(:,tt) = x(:,tt-1) + dt*dx(:,tt-1) + dt^2*(1/2-B)*ddx(:,tt-1) + dt^2*B*ddx(:,tt); %-- Eq.(36)
end


end

