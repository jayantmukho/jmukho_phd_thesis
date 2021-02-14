function [] = generate_trajectory_plots(CPR_data_MC,CPR_data_mean,CPA_data_MC,CPA_data_mean)
idx_list = 1:10;

% Roll Angle
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot(CPR_data_mean.phi_rad.time,CPR_data_mean.phi_rad.values*180/pi,'k','LineWidth',3);
for i=1:length(idx_list)
    plot(CPR_data_MC(i).phi_rad.time,CPR_data_MC(i).phi_rad.values*180/pi,'LineWidth',1);
end
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% CPR Pdot
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot(CPR_data_mean.pdot_dps2.time,CPR_data_mean.pdot_dps2.values,'k','LineWidth',3);
for i=1:length(idx_list)
    plot(CPR_data_MC(i).pdot_dps2.time,CPR_data_MC(i).pdot_dps2.values,'LineWidth',1);
end
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% CPR Qdot
figure; hold on; i = length(idx_list)+1;
set(gcf,'Position',[589,456,755,420]);
plot(CPR_data_mean.qdot_dps2.time,CPR_data_mean.qdot_dps2.values,'k','LineWidth',3);
for i=1:length(idx_list)
    plot(CPR_data_MC(i).qdot_dps2.time,CPR_data_MC(i).qdot_dps2.values,'LineWidth',1);
end
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('Pitch Acceleration (deg/sec^2)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% CPR Rdot
figure; hold on; i = length(idx_list)+1;
set(gcf,'Position',[589,456,755,420]);
plot(CPR_data_mean.rdot_dps2.time,CPR_data_mean.rdot_dps2.values,'k','LineWidth',3);
for i=1:length(idx_list)
    plot(CPR_data_MC(i).rdot_dps2.time,CPR_data_MC(i).rdot_dps2.values,'LineWidth',1);
end
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('Yaw Acceleration (deg/sec^2)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% Aileron
figure;
set(gcf,'Position',[589,200,855,580]);
subplot(2,1,1); hold on; i = length(idx_list)+1;
plot(CPA_data_mean.ail_left_deg.time,CPA_data_mean.ail_left_deg.values,'k','LineWidth',3);
for i=1:length(idx_list)
    plot(CPA_data_MC(i).ail_left_deg.time,CPA_data_MC(i).ail_left_deg.values,'LineWidth',1);
end
set(gca,'FontSize',12,'FontWeight','bold');
xlim([0 max(CPA_data_MC(i).ail_left_deg.time)-2]);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
% legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
subplot(2,1,2); hold on; i = length(idx_list)+1;
plot(CPA_data_mean.ail_right_deg.time,CPA_data_mean.ail_right_deg.values,'k','LineWidth',3);
for i=1:length(idx_list)
    plot(CPA_data_MC(i).ail_right_deg.time,CPA_data_MC(i).ail_right_deg.values,'LineWidth',1);
end
set(gca,'FontSize',12,'FontWeight','bold');
xlim([0 max(CPA_data_MC(i).ail_right_deg.time)-2]);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'Position',[0.149128581 0.3221144 0.277145128 0.19871419],'NumColumns',2);

% Rudder
figure; hold on; i = length(idx_list)+1;
set(gcf,'Position',[589,456,755,420]);
plot(CPA_data_mean.rud_deg.time,CPA_data_mean.rud_deg.values,'k','LineWidth',3);
for i=1:length(idx_list)
    plot(CPA_data_MC(i).rud_deg.time,CPA_data_MC(i).rud_deg.values,'LineWidth',1);
end
set(gca,'FontSize',12,'FontWeight','bold');
xlim([0 max(CPA_data_MC(i).rud_deg.time)-2]);
xlabel('Time (sec)');
ylabel('Rudder (deg)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

% Elevator
figure; hold on; i = length(idx_list)+1;
set(gcf,'Position',[589,456,755,420]);
plot(CPA_data_mean.elev_deg.time,CPA_data_mean.elev_deg.values,'k','LineWidth',3);
for i=1:length(idx_list)
    plot(CPA_data_MC(i).elev_deg.time,CPA_data_MC(i).elev_deg.values,'LineWidth',1);
end
set(gca,'FontSize',12,'FontWeight','bold');
xlim([0 max(CPA_data_MC(i).elev_deg.time)-2]);
xlabel('Time (sec)');
ylabel('Elevator (deg)');
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');

end

