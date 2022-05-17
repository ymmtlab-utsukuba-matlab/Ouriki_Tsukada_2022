kk=kk+1;
if kk==1
    X=VBI_est1_000{2,6};
    J=VBI_est1_000{2,5};
end
plot(X(6,:,kk)/469,X(7,:,kk)/751,'k.');
hold on;
LJ=min(J(1:kk,:),[],1);
GJ=min(J(1:kk,:),[],'all');
[Gkk,Gii]=find(GJ==J(1:kk,:),1,'last');

for ii=1:size(J,2)
    L_ii(kk,ii)=find(LJ(ii)==J(1:kk,ii),1,'last');
    plot(X(6,ii,find(LJ(ii)==J(1:kk,ii),1,'last'))/469,X(7,ii,find(LJ(ii)==J(1:kk,ii),1,'last'))/751,'bo')
end
plot(X(6,Gii,Gkk)/469,X(7,Gii,Gkk)/751,'ro');
hold off

xlim([0 3])
ylim([0 3])