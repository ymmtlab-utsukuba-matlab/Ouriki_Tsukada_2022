function [Q, R] = QRinitial(nL,dat)
%QR_ この関数の概要をここに記述
%   詳細説明をここに記述
Q     = zeros(12,12);
R     = zeros(4,4);

Q(:,:)=diag([6.0 6.0 6.0 6.0 7.5 7.5 7.5 7.5 0.0 0.0 0.0 0.0]*1e-9) + nL*(diag([6.0 6.0 6.0 6.0 7.5 7.5 7.5 7.5 0.0 0.0 0.0 0.0]*1e-6) - diag([6.0 6.0 6.0 6.0 7.5 7.5 7.5 7.5 0.0 0.0 0.0 0.0]*1e-9));
Q(9,9)=var(dat.u(1,:),1,2);
Q(10,10)=var(dat.u(2,:),1,2);
Q(11,11)=var(dat.du(1,:),1,2);
Q(12,12)=var(dat.du(2,:),1,2);
R(:,:)=diag([1.0 1.0 1.0 1.0]*1e-9) + nL*(diag([6.0 6.0 7.5 7.5]*1e-3) - diag([1.0 1.0 1.0 1.0]*1e-9));

end

