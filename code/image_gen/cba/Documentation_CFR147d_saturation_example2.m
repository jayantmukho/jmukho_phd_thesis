% README: this code generates the plots associated with the "Boeing
% Simulation Tools" Word document, particularly the example specifically 
% designed to cause failure/saturation.
%   preprocess_flag '1' = Boeing-only: raw data files are loaded and necessary data
%       is extracted for use in the plots.  The extracted data is then
%       saved in a separate, processed .mat file for later use.
%   preprocess_flag '0' = Stanford or Boeing: uses the processed .mat file from above

% Author: Jack Quindlen
% Date: 9/19/2020

clear all;
close all;
clc;


%% Preprocess the data 
preprocess_flag = 0;
if preprocess_flag
    Preprocess_CFR147d_saturation_example2;
else
    load('data_CFR147d_saturation_example2.mat');
end


%% Plot trajectories which fail to meet the maneuver requirements (saturation)
% Roll Angle
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot(phi_rad_struct(1).time,phi_rad_struct(1).values*180/pi,'LineWidth',2);
plot(phi_rad_struct(2).time,phi_rad_struct(2).values*180/pi,'LineWidth',2);
plot(phi_rad_struct(3).time,phi_rad_struct(3).values*180/pi,'LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
legend('Normal','R. Engine Out','L. Engine Out','Location','Best');

% Roll Acceleration
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot(pdot_dps2_struct_CPR(1).time,pdot_dps2_struct_CPR(1).values,'LineWidth',2);
plot(pdot_dps2_struct_CPR(2).time,pdot_dps2_struct_CPR(2).values,'LineWidth',2);
plot(pdot_dps2_struct_CPR(3).time,pdot_dps2_struct_CPR(3).values,'LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Normal','R. Engine Out','L. Engine Out','Location','Best');

% Roll command vs saturation limits
figure; 
set(gcf,'Position',[589,400,755,480]);
subplot(2,1,1); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',2);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*-1,'LineWidth',2);
plot(roll_surf_cmd_struct(2).time-2,roll_surf_cmd_struct(2).values*-1,'LineWidth',2);
plot(roll_surf_cmd_struct(3).time-2,roll_surf_cmd_struct(3).values*-1,'LineWidth',2);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',2);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
% legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out');
subplot(2,1,2); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',2);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*+1,'LineWidth',2);
plot(roll_surf_cmd_struct(2).time-2,roll_surf_cmd_struct(2).values*+1,'LineWidth',2);
plot(roll_surf_cmd_struct(3).time-2,roll_surf_cmd_struct(3).values*+1,'LineWidth',2);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',2);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out','Location','Best');

% Yaw command vs saturation limits
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot([0 max(yaw_surf_cmd_struct(1).time)],[30 30],'k--','LineWidth',2);
plot(yaw_surf_cmd_struct(1).time-2,yaw_surf_cmd_struct(1).values,'LineWidth',2);
plot(yaw_surf_cmd_struct(2).time-2,yaw_surf_cmd_struct(2).values,'LineWidth',2);
plot(yaw_surf_cmd_struct(3).time-2,yaw_surf_cmd_struct(3).values,'LineWidth',2);
plot([0 max(yaw_surf_cmd_struct(1).time)],[-30 -30],'k--','LineWidth',2);
xlim([0 max(yaw_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('Rudder (deg)');
legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out','Location','Best');

% Pitch command vs saturation limits
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot([0 max(pitch_surf_cmd_struct(1).time)],[20 20],'k--','LineWidth',2);
plot(pitch_surf_cmd_struct(1).time-2,pitch_surf_cmd_struct(1).values,'LineWidth',2);
plot(pitch_surf_cmd_struct(2).time-2,pitch_surf_cmd_struct(2).values,'LineWidth',2);
plot(pitch_surf_cmd_struct(3).time-2,pitch_surf_cmd_struct(3).values,'LineWidth',2);
plot([0 max(pitch_surf_cmd_struct(1).time)],[-20 -20],'k--','LineWidth',2);
xlim([0 max(pitch_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Time (sec)');
ylabel('Elevator (deg)');
legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out','Location','Best');
