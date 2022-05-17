plot(R(:,1),zeros(length(R),1),'k:'); hold on
plot(R(:,1),0.03+R(:,2),'k-','LineWidth',1.01); 
plot(R(:,1),0.01*(R(:,1)>3&R(:,1)<13.5).*sin(2*pi*((R(:,1)-3)/10.5).^2), 'b-','LineWidth',1.02)
plot(R(:,1),0.03+R(:,2)+0.01*(R(:,1)>3&R(:,1)<13.5).*sin(2*pi*((R(:,1)-3)/10.5).^2), 'r-');
plot([3 13.5],[0 0],'ro'); hold off
set(gcf, 'Color',[1 1 1])
xlim([0 15])
set(gca, 'Visible','off')
