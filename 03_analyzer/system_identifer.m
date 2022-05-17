function [xmin, R_ave, X, J] = system_identifer(s,Veh,Bri,Sim,dat,nL,count)
%SYSTEM_IDENTIFER returns the estimated parameters and road profile.
% 
% coded by Yamamoto Kyosuke, Feb/22, 2021
% revised, Mar/14, 2021 (all history values of "X" are preserved) 

%-- parameter setting
t     = Sim.t;
TT    = length(t);

%-- covariance matrix Q, R
% [Q, R] = QRinitial(nL,dat(2,:));

%-- parameters assumption
x0 = assumedParameters(Veh, Bri);

%-- initialization
dim    = max(size(x0)); % dimension of the problem
alpha  = 1;
beta   = 1+2/dim; 
gamma  = 0.75-0.5/dim; 
delta  = 1-1/dim;
scalefactor = min(max(max(abs(x0)),1),10);
D0     = eye(dim);
D0(dim+1,:)=(1-sqrt(dim+1))/dim*ones(1,dim);
tol    = 1e-20;
max_feval = 1e3;
mu     = 1;
mu_    = 1e5;

for i=1:dim+1
    %     X(i,:)=x0+ scalefactor*D0(i,:)';
    X(i,:)=assumedParameters(Veh, Bri);
    FX(i)=calObjFunc_multi(X(i,:),s,Veh,Bri,Sim,dat,nL,count) + barrier(X(i,:),Veh);
end
ct=dim+1;
[FX,I]=sort(FX);
X=X(I,:);

for ii = 1:Sim.step_num
    while max(max(abs(X(2:dim+1,:)-X(1:dim,:)))) >= scalefactor*tol
        if ct>max_feval
            break;
        end
        M=mean(X(1:dim,:));  % Centroid of the dim best vertices
        % FM=mean(FX(1:dim));
        xref=M+alpha*(M - X(dim+1,:));
        Fref=calObjFunc_multi(xref,s,Veh,Bri,Sim,dat,nL,count) + mu * barrier(xref,Veh);
        ct=ct+1;
        if Fref<FX(1)
            % expansion
            xexp=M+beta*(xref - M);
            Fexp=calObjFunc_multi(xexp,s,Veh,Bri,Sim,dat,nL,count) + mu * barrier(xexp,Veh);
            ct=ct+1;
            if Fexp < Fref
                X(dim+1,:)=xexp;
                FX(dim+1)=Fexp;
            else
                X(dim+1,:)=xref;
                FX(dim+1)=Fref;
            end
        else
            if Fref<FX(dim)
                % accept reflection point
                X(dim+1,:)=xref;
                FX(dim+1)=Fref;
            else
                if Fref<FX(dim+1)
                    % Outside contraction
                    xoc=M-gamma*(xref - M);
                    Foc=calObjFunc_multi(xoc,s,Veh,Bri,Sim,dat,nL,count) + mu * barrier(xoc,Veh);
                    ct=ct+1;
                    if Foc<=Fref
                        X(dim+1,:)=xoc;
                        FX(dim+1)=Foc;
                    else
                        % shrink
                        for i=2:dim+1
                            X(i,:)=X(1,:)+ delta*(X(i,:)-X(1,:));
                            FX(i)=calObjFunc_multi(X(i,:),s,Veh,Bri,Sim,dat,nL,count) + mu * barrier(X(i,:),Veh);
                        end
                        ct=ct+dim;
                    end
                else
                    %inside contraction
                    xic=M-gamma*(xref - M);
                    Fic=calObjFunc_multi(xic,s,Veh,Bri,Sim,dat,nL,count) + mu * barrier(xic,Veh);
                    ct=ct+1;
                    if Fic<FX(dim+1)
                        X(dim+1,:)=xic;
                        FX(dim+1)=Fic;
                    else
                        % shrink
                        for i=2:dim+1
                            X(i,:)=X(1,:)+ delta*(X(i,:)-X(1,:));
                            FX(i)=calObjFunc_multi(X(i,:),s,Veh,Bri,Sim,dat,nL,count) + mu * barrier(X(i,:),Veh);
                        end
                        ct=ct+dim;
                    end
                end
            end
        end
        [FX,I]=sort(FX);
        X=X(I,:);
    end
    xmin=X(1,:);
    fmin=FX(1);
    if mu > 1e20
        break;
    else
        mu = mu_*mu;
    end
end

[J,R_ave]=calObjFunc_multi(xmin,s,Veh,Bri,Sim,dat,nL,count);
% [~,Z_hat,~,~,RP]=calObjFunc(xmin,s,Veh,Bri,Sim,Q,R);

end

