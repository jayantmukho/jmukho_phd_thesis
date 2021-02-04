clear all;
close all;
clc;
set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)


fs = 18;
lw = 3;

load('data_CFR147d_initial_example.mat');

%% Plot the nominal trajectories for the original requirement
%   Plot the original requirement of 11 seconds

% Roll Angle
figure('units','inch','position',[0,0,8,5]); clf; hold on;
% set(gcf,'Position',[589,456,755,420]);
plot(phi_rad_struct(1).time,phi_rad_struct(1).values*180/pi,'k','LineWidth',lw);
% set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle $(^\circ)$');
% legend('Target');
grid on; box on;
saveas(gcf,'images/cfr147d_roll_angle.png')

% Roll Acceleration
figure('units','inch','position',[0,0,8,5]); clf; hold on;
% set(gcf,'Position',[589,456,755,420]);
plot(pdot_dps2_struct_CPR(1).time,pdot_dps2_struct_CPR(1).values,'k','LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Acceleration $(^\circ/s^2)$');
% legend('Target');
ylim([-8,8])
grid on; box on;
saveas(gcf,'images/cfr147d_roll_acc.png')

% Aileron Deflection
figure('units','inch','position',[0,0,8,5]); clf;
subplot(2,1,1); hold on;
plot(surf_AIL_deg_struct(1).time-2,surf_AIL_deg_struct(1).values,'k','LineWidth',lw);
xlim([0 max(surf_AIL_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('L. Aileron $(^\circ)$');
ylim([-10,10])
grid on; box on;

subplot(2,1,2); hold on;
plot(surf_AIR_deg_struct(1).time-2,surf_AIR_deg_struct(1).values,'k','LineWidth',lw);
xlim([0 max(surf_AIR_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('R. Aileron $(^\circ)$');
ylim([-10,10])
grid on; box on;
saveas(gcf,'images/cfr147d_ail_defl.png')

%% Plot mean response
load('./Stanford_CFR25_147d/WT_trajectory_results')
figure('units','inch','position',[0,0,8,5]); clf; hold on;
% set(gcf,'Position',[589,456,755,420]);
i=1;
plot(CPR_traj_mean(4).normal.phi_rad.time,CPR_traj_mean(4).normal.phi_rad.values*180/pi,'k','LineWidth',lw);
plot(CPR_traj_MC(4).normal(i).phi_rad.time,CPR_traj_MC(4).normal(i).phi_rad.values*180/pi,'color','#8C1515','LineWidth',lw);

% set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
legend('Target','Actual');
grid on; box on;
load('../Stanford_CFR25_147d/WT_trajectory_results')
saveas(gcf,'images/cfr147d_roll_angle_mean.png')

%% Aggressive manuever plots
close all

load('data_CFR147d_saturation_example.mat');
% Roll Angle
figure('units','inch','position',[0,0,8,5]); clf; hold on;
plot(phi_rad_struct(4).time,phi_rad_struct(4).values*180/pi,'k','LineWidth',lw);
plot(phi_rad_struct(1).time,phi_rad_struct(1).values*180/pi,'LineWidth',lw,'color','#8C1515');
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
legend('Original','New');
grid on; box on;
saveas(gcf,'images/cfr147d_agg_roll_angle.png')

figure('units','inch','position',[0,0,8,5]); clf; hold on;
plot(pdot_dps2_struct_CPR(4).time,pdot_dps2_struct_CPR(4).values,'k','LineWidth',lw);
plot(pdot_dps2_struct_CPR(1).time,pdot_dps2_struct_CPR(1).values,'LineWidth',lw,'color','#8C1515');
xlim([0 max(pdot_dps2_struct_CPR(4).time)]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Original','New');
grid on; box on;
saveas(gcf,'images/cfr147d_agg_roll_acc.png')

% Roll command vs saturation limits
figure('units','inch','position',[0,0,8,8]); clf; hold on;
subplot(2,1,1); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',lw);
plot(surf_AIL_deg_struct(4).time-2,surf_AIL_deg_struct(4).values,'k','LineWidth',lw);
set(gca,'ColorOrderIndex',1);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*-1,'LineWidth',lw);
plot(roll_surf_cmd_struct(2).time-2,roll_surf_cmd_struct(2).values*-1,'LineWidth',lw);
plot(roll_surf_cmd_struct(3).time-2,roll_surf_cmd_struct(3).values*-1,'LineWidth',lw);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',lw);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
grid on; box on;
% legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out');
subplot(2,1,2); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',lw);
plot(surf_AIR_deg_struct(4).time-2,surf_AIR_deg_struct(4).values,'k','LineWidth',lw);
set(gca,'ColorOrderIndex',1);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*+1,'LineWidth',lw);
plot(roll_surf_cmd_struct(2).time-2,roll_surf_cmd_struct(2).values*+1,'LineWidth',lw);
plot(roll_surf_cmd_struct(3).time-2,roll_surf_cmd_struct(3).values*+1,'LineWidth',lw);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',lw);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
% legend('Saturation Limits','Original','Normal','R. Engine Out','L. Engine Out','Location','Best');
grid on; box on;
saveas(gcf,'images/cfr147d_agg_ail_defl.png')
%% Monte Carlo for aggresive maneuver
close all

% Compare Monte Carlo results for both engines-operable case
load('data_CFR147d_MonteCarlo_example1_normal.mat');
idx_list = 1:10;

% Trajectory
figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;
plot(phi_rad_struct(i).time,phi_rad_struct(i).values*180/pi,'k','LineWidth',lw);
for i=1:length(idx_list)
plot(phi_rad_struct(i).time,phi_rad_struct(i).values*180/pi,'LineWidth',1);
end
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
% legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
% set(legend,'NumColumns',2,'Location','Best');
grid on; box on;
saveas(gcf,'images/mc_agg_trajectories.png')

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
grid on; box on;
ylim([-30, 30])
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
% legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
% set(legend,'Position',[0.149128581 0.3221144 0.277145128 0.19871419],'NumColumns',2);
grid on; box on;
ylim([-30, 30])
saveas(gcf,'images/mc_agg_ail_defl.png')