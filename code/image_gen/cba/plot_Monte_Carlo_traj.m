% Roll Angle
figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;
plot(phi_rad_struct(i).time,phi_rad_struct(i).values*180/pi,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(phi_rad_struct(i).time,phi_rad_struct(i).values*180/pi,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% CPR Pdot
figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;
plot(pdot_dps2_struct_CPR(i).time,pdot_dps2_struct_CPR(i).values,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(pdot_dps2_struct_CPR(i).time,pdot_dps2_struct_CPR(i).values,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% CPR Qdot
figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;
plot(qdot_dps2_struct_CPR(i).time,qdot_dps2_struct_CPR(i).values,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(qdot_dps2_struct_CPR(i).time,qdot_dps2_struct_CPR(i).values,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Pitch Acceleration (deg/sec^2)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% CPR Rdot
figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;
plot(rdot_dps2_struct_CPR(i).time,rdot_dps2_struct_CPR(i).values,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(rdot_dps2_struct_CPR(i).time,rdot_dps2_struct_CPR(i).values,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Yaw Acceleration (deg/sec^2)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% Aileron
figure('units','inch','position',[0,0,8,8]); clf; 
subplot(2,1,1); hold on; i = length(idx_list)+1;
plot(surf_AIL_deg_struct(i).time-2,surf_AIL_deg_struct(i).values,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(surf_AIL_deg_struct(i).time-2,surf_AIL_deg_struct(i).values,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlim([0 max(surf_AIL_deg_struct(i).time)-2]);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
% legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
subplot(2,1,2); hold on; i = length(idx_list)+1;
plot(surf_AIR_deg_struct(i).time-2,surf_AIR_deg_struct(i).values,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(surf_AIR_deg_struct(i).time-2,surf_AIR_deg_struct(i).values,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlim([0 max(surf_AIR_deg_struct(i).time)-2]);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'Position',[0.149128581 0.3221144 0.277145128 0.19871419],'NumColumns',2);

% Rudder
figure('units','inch','position',[0,0,8,8]); clf; hold on; i = length(idx_list)+1;
set(gcf,'Position',[589,456,755,420]);
plot(surf_RUD_deg_struct(i).time-2,surf_RUD_deg_struct(i).values,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(surf_RUD_deg_struct(i).time-2,surf_RUD_deg_struct(i).values,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlim([0 max(surf_RUD_deg_struct(i).time)-2]);
xlabel('Time (sec)');
ylabel('Rudder (deg)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% Elevator
figure('units','inch','position',[0,0,8,8]); clf; hold on; i = length(idx_list)+1;
set(gcf,'Position',[589,456,755,420]);
plot(surf_ELV_deg_struct(i).time-2,surf_ELV_deg_struct(i).values,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(surf_ELV_deg_struct(i).time-2,surf_ELV_deg_struct(i).values,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlim([0 max(surf_ELV_deg_struct(i).time)-2]);
xlabel('Time (sec)');
ylabel('Elevator (deg)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');
