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

set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)

fs = 18;
lw = 3;

%% Preprocess the data 
preprocess_flag = 0;
if preprocess_flag
    Preprocess_CFR147d_saturation_example;
else
    load('data_CFR147d_saturation_example.mat');
end


%% Plot trajectories which fail to meet the maneuver requirements (saturation)


% Roll Angle
figure('units','inch','position',[0,0,8,5]); clf; hold on;
plot(phi_rad_struct(4).time,phi_rad_struct(4).values*180/pi,'k','LineWidth',lw);
plot(phi_rad_struct(1).time,phi_rad_struct(1).values*180/pi,'LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
legend('Original','New');
grid on
saveas(gcf,'images/cfr147d_agg_roll_angle.png')

%%
% Roll Acceleration
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot(pdot_dps2_struct_CPR(4).time,pdot_dps2_struct_CPR(4).values,'k','LineWidth',lw);
plot(pdot_dps2_struct_CPR(1).time,pdot_dps2_struct_CPR(1).values,'LineWidth',lw);
xlim([0 max(pdot_dps2_struct_CPR(4).time)]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Original','New');

% % Roll Acceleration
% figure; hold on;
% set(gcf,'Position',[589,456,755,420]);
% plot(pdot_dps2_struct_CPA(1).time-2,pdot_dps2_struct_CPA(1).values,'LineWidth',lw);
% plot(pdot_dps2_struct_CPA(2).time-2,pdot_dps2_struct_CPA(2).values,'LineWidth',lw);
% plot(pdot_dps2_struct_CPA(3).time-2,pdot_dps2_struct_CPA(3).values,'LineWidth',lw);
% xlim([0 max(pdot_dps2_struct_CPA(1).time)-2]);
% set(gca,'FontSize',fs);
% xlabel('Time (sec)');
% ylabel('Roll Acceleration (deg/sec^2)');
% legend('Normal','R. Engine Out','L. Engine Out');

% % Yaw Acceleration
% figure; hold on;
% set(gcf,'Position',[589,456,755,420]);
% plot(rdot_dps2_struct_CPA(1).time-2,rdot_dps2_struct_CPA(1).values,'LineWidth',lw);
% plot(rdot_dps2_struct_CPA(2).time-2,rdot_dps2_struct_CPA(2).values,'LineWidth',lw);
% plot(rdot_dps2_struct_CPA(3).time-2,rdot_dps2_struct_CPA(3).values,'LineWidth',lw);
% xlim([0 max(rdot_dps2_struct_CPA(1).time)-2]);
% set(gca,'FontSize',fs);
% xlabel('Time (sec)');
% ylabel('Yaw Acceleration (deg/sec^2)');
% legend('Normal','R. Engine Out','L. Engine Out');

% % Pitch Acceleration
% figure; hold on;
% set(gcf,'Position',[589,456,755,420]);
% plot(qdot_dps2_struct_CPA(1).time-2,qdot_dps2_struct_CPA(1).values,'LineWidth',lw);
% plot(qdot_dps2_struct_CPA(2).time-2,qdot_dps2_struct_CPA(2).values,'LineWidth',lw);
% plot(qdot_dps2_struct_CPA(3).time-2,qdot_dps2_struct_CPA(3).values,'LineWidth',lw);
% xlim([0 max(rdot_dps2_struct_CPA(1).time)-2]);
% set(gca,'FontSize',fs);
% xlabel('Time (sec)');
% ylabel('Pitch Acceleration (deg/sec^2)');
% legend('Normal','R. Engine Out','L. Engine Out');


% Roll command vs saturation limits
figure; 
set(gcf,'Position',[589,400,755,480]);
subplot(2,1,1); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',lw);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*-1,'LineWidth',lw);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',lw);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
% legend('Saturation Limits','Required');
subplot(2,1,2); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',lw);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*+1,'LineWidth',lw);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',lw);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
legend('Saturation Limits','Required','Location','Best');

% Yaw command vs saturation limits
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot([0 max(yaw_surf_cmd_struct(1).time)],[30 30],'k--','LineWidth',lw);
plot(yaw_surf_cmd_struct(1).time-2,yaw_surf_cmd_struct(1).values,'LineWidth',lw);
plot([0 max(yaw_surf_cmd_struct(1).time)],[-30 -30],'k--','LineWidth',lw);
xlim([0 max(yaw_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Rudder (deg)');
legend('Saturation Limits','Required','Location','Best');

% Pitch command vs saturation limits
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot([0 max(pitch_surf_cmd_struct(1).time)],[20 20],'k--','LineWidth',lw);
plot(pitch_surf_cmd_struct(1).time-2,pitch_surf_cmd_struct(1).values,'LineWidth',lw);
plot([0 max(pitch_surf_cmd_struct(1).time)],[-20 -20],'k--','LineWidth',lw);
xlim([0 max(pitch_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Elevator (deg)');
legend('Saturation Limits','Required','Location','Best');

% % Aileron Deflection
% figure; 
% subplot(2,1,1); hold on;
% plot(surf_AIL_deg_struct(1).time-2,surf_AIL_deg_struct(1).values);
% plot(surf_AIL_deg_struct(2).time-2,surf_AIL_deg_struct(2).values);
% plot(surf_AIL_deg_struct(3).time-2,surf_AIL_deg_struct(3).values);
% plot([0 max(roll_surf_cmd(1).time)],[25 25],'k--');
% plot([0 max(roll_surf_cmd(1).time)],[-25 -25],'k--');
% xlim([0 max(surf_AIL_deg_struct(1).time)-2]);
% xlabel('Time (sec)');
% ylabel('L. Aileron (deg)');
% legend('Normal','R. Engine Out','L. Engine Out');
% subplot(2,1,2); hold on;
% plot(surf_AIR_deg_struct(1).time-2,surf_AIR_deg_struct(1).values);
% plot(surf_AIR_deg_struct(2).time-2,surf_AIR_deg_struct(2).values);
% plot(surf_AIR_deg_struct(3).time-2,surf_AIR_deg_struct(3).values);
% plot([0 max(roll_surf_cmd(1).time)],[25 25],'k--');
% plot([0 max(roll_surf_cmd(1).time)],[-25 -25],'k--');
% xlim([0 max(surf_AIR_deg_struct(1).time)-2]);
% xlabel('Time (sec)');
% ylabel('R. Aileron (deg)');
% legend('Normal','R. Engine Out','L. Engine Out');
% 
% % Rudder Deflection
% figure; hold on;
% plot(surf_RUD_deg_struct(1).time-2,surf_RUD_deg_struct(1).values);
% plot(surf_RUD_deg_struct(2).time-2,surf_RUD_deg_struct(2).values);
% plot(surf_RUD_deg_struct(3).time-2,surf_RUD_deg_struct(3).values);
% plot([0 max(roll_surf_cmd(1).time)],[30 30],'k--');
% plot([0 max(roll_surf_cmd(1).time)],[-30 -30],'k--');
% xlim([0 max(surf_RUD_deg_struct(1).time)-2]);
% xlabel('Time (sec)');
% ylabel('Rudder (deg)');
% legend('Normal','R. Engine Out','L. Engine Out');
% 
% % Elevator Deflection
% figure; hold on;
% plot(surf_ELV_deg_struct(1).time-2,surf_ELV_deg_struct(1).values);
% plot(surf_ELV_deg_struct(2).time-2,surf_ELV_deg_struct(2).values);
% plot(surf_ELV_deg_struct(3).time-2,surf_ELV_deg_struct(3).values);
% xlim([0 max(surf_ELV_deg_struct(1).time)-2]);
% xlabel('Time (sec)');
% ylabel('Elevator (deg)');
% legend('Normal','R. Engine Out','L. Engine Out');

% Roll command vs saturation limits
figure; 
set(gcf,'Position',[589,400,755,480]);
subplot(2,1,1); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',lw);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*-1,'LineWidth',lw);
plot(roll_surf_cmd_struct(2).time-2,roll_surf_cmd_struct(2).values*-1,'LineWidth',lw);
plot(roll_surf_cmd_struct(3).time-2,roll_surf_cmd_struct(3).values*-1,'LineWidth',lw);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',lw);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
% legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out');
subplot(2,1,2); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',lw);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*+1,'LineWidth',lw);
plot(roll_surf_cmd_struct(2).time-2,roll_surf_cmd_struct(2).values*+1,'LineWidth',lw);
plot(roll_surf_cmd_struct(3).time-2,roll_surf_cmd_struct(3).values*+1,'LineWidth',lw);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',lw);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out','Location','Best');

% Yaw command vs saturation limits
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot([0 max(yaw_surf_cmd_struct(1).time)],[30 30],'k--','LineWidth',lw);
plot(yaw_surf_cmd_struct(1).time-2,yaw_surf_cmd_struct(1).values,'LineWidth',lw);
plot(yaw_surf_cmd_struct(2).time-2,yaw_surf_cmd_struct(2).values,'LineWidth',lw);
plot(yaw_surf_cmd_struct(3).time-2,yaw_surf_cmd_struct(3).values,'LineWidth',lw);
plot([0 max(yaw_surf_cmd_struct(1).time)],[-30 -30],'k--','LineWidth',lw);
xlim([0 max(yaw_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Rudder (deg)');
legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out','Location','Best');

% Pitch command vs saturation limits
figure; hold on;
set(gcf,'Position',[589,456,755,420]);
plot([0 max(pitch_surf_cmd_struct(1).time)],[20 20],'k--','LineWidth',lw);
plot(pitch_surf_cmd_struct(1).time-2,pitch_surf_cmd_struct(1).values,'LineWidth',lw);
plot(pitch_surf_cmd_struct(2).time-2,pitch_surf_cmd_struct(2).values,'LineWidth',lw);
plot(pitch_surf_cmd_struct(3).time-2,pitch_surf_cmd_struct(3).values,'LineWidth',lw);
plot([0 max(pitch_surf_cmd_struct(1).time)],[-20 -20],'k--','LineWidth',lw);
xlim([0 max(pitch_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Elevator (deg)');
legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out','Location','Best');
