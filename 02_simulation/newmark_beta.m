function [ t, x, dx, ddx ] = newmark_beta( m,c,k,f,dt,X,G,B )
% NEWMARK_BETA returns the results of dynamic simulation based on
%  Newmark Beta method
% 
% OUTPUT
% x: the displacement vibration response
% dx: the velocity vibration response
% ddx: the acceleration vibration response
% 
% INPUT
% m: mass matrix R(N,N)
% c: damping matrix R(N,N)
% k: stiffness matrix R(N,N)
% f: external force R(N,T)
% dt: time interval
% X: initial values of x(1), dx(1) and ddx(1) R(N,3)
% G: gamma of newmark beta method (usually 1/2)
% B: beta of newmark beta method (usually 1/6)
% 
% N: degree of freedom
% T: length of data
% 
% coded by Yamamoto Kyosuke, MAY/02, 2018
% updated                    Feb/21, 2021

%% Initialization
%-- memory space
x=zeros(size(f));
dx=zeros(size(f));
ddx=zeros(size(f));

%-- input initial values
x(:,1)=X(:, 1);
dx(:,1)=X(:, 2);
ddx(:,1)=X(:, 3);

%-- time vector
TT=length(f);
t=(0:TT-1)*dt;

%% solving
A = m + dt*G*c + dt^2*B*k; %-- global matrix, Eq.(38)

for tt=2:TT
    %-- solving preparation
    b1 = -c * ( dx(:,tt-1) + (1-G)*dt*ddx(:, tt-1) );%-- substitute for Eq.(39)
    b2 = -k * ( x(:,tt-1) + dt*dx(:,tt-1) + (1/2-B)*dt^2*ddx(:,tt-1) );%-- substitute for Eq.(39)
    b = f(:,tt) + b1 + b2; %-- right hand side, Eq.(39)
    
    %-- calculation of acceleration at t=t+1
    ddx(:,tt) = A\b;%-- Eq.(43)
    
    %-- calculation of velocity and displacement responses
    dx(:,tt) = dx(:,tt-1) + dt*(1-G)*ddx(:,tt-1) + dt*G*ddx(:,tt);%-- Eq.(35)
    x(:,tt) = x(:,tt-1) + dt*dx(:,tt-1) + dt^2*(1/2-B)*ddx(:,tt-1) + dt^2*B*ddx(:,tt);%-- Eq.(36)
    
end


end

