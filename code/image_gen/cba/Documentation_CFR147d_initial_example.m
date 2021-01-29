% README: this code generates the plots associated with the "Boeing
% Simulation Tools" Word document, particularly the initial deterministic
% example.
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
% Preprocess the data 
preprocess_flag = 0;
if preprocess_flag
    Preprocess_CFR147d_initial_example;
else
    load('data_CFR147d_initial_example.mat');
end


%% Plot the nominal trajectories for the original requirement
%   Plot the original requirement of 11 seconds

% Roll Angle
figure('units','inch','position',[0,0,8,5]); clf; hold on;
% set(gcf,'Position',[589,456,755,420]);
plot(phi_rad_struct(1).time,phi_rad_struct(1).values*180/pi,'k','LineWidth',lw);
% set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
legend('Target');
grid on
saveas(gcf,'images/cfr147d_roll_angle.png')

%%
% Roll Acceleration
figure('units','inch','position',[0,0,8,5]); clf; hold on;
% set(gcf,'Position',[589,456,755,420]);
plot(pdot_dps2_struct_CPR(1).time,pdot_dps2_struct_CPR(1).values,'k','LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Target');
ylim([-8,8])
grid on
saveas(gcf,'images/cfr147d_roll_acc.png')

% Roll Acceleration
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(pdot_dps2_struct_CPR(1).time,pdot_dps2_struct_CPR(1).values,'k--','LineWidth',3);
plot(pdot_dps2_struct_CPA(1).time-2,pdot_dps2_struct_CPA(1).values,'LineWidth',lw);
set(gca,'FontSize',fs);
xlim([0 max(pdot_dps2_struct_CPA(1).time)-2]);
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Target','Actual');

% Aileron Deflection
figure('units','inch','position',[0,0,8,5]); clf;
subplot(2,1,1); hold on;
plot(surf_AIL_deg_struct(1).time-2,surf_AIL_deg_struct(1).values,'k','LineWidth',lw);
xlim([0 max(surf_AIL_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
grid on
subplot(2,1,2); hold on;
plot(surf_AIR_deg_struct(1).time-2,surf_AIR_deg_struct(1).values,'k','LineWidth',lw);
xlim([0 max(surf_AIR_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
grid on
saveas(gcf,'images/cfr147d_ail_defl.png')

%%
% Yaw Acceleration
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(rdot_dps2_struct_CPA(1).time-2,rdot_dps2_struct_CPA(1).values,'LineWidth',lw);
xlim([0 max(rdot_dps2_struct_CPA(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Yaw Acceleration (deg/sec^2)');

% Rudder Deflection
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(surf_RUD_deg_struct(1).time-2,surf_RUD_deg_struct(1).values,'LineWidth',lw);
xlim([0 max(surf_RUD_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Rudder (deg)');

% Pitch Acceleration
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(qdot_dps2_struct_CPA(1).time-2,qdot_dps2_struct_CPA(1).values,'LineWidth',lw);
xlim([0 max(qdot_dps2_struct_CPA(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Pitch Acceleration (deg/sec^2)');

% Elevator Deflection
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(surf_ELV_deg_struct(1).time-2,surf_ELV_deg_struct(1).values,'LineWidth',lw);
xlim([0 max(surf_ELV_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Elevator (deg)');


%% Now look at engine-out analyses

% Roll Acceleration
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(pdot_dps2_struct_CPA(1).time-2,pdot_dps2_struct_CPA(1).values,'LineWidth',lw);
plot(pdot_dps2_struct_CPA(2).time-2,pdot_dps2_struct_CPA(2).values,'LineWidth',lw);
plot(pdot_dps2_struct_CPA(3).time-2,pdot_dps2_struct_CPA(3).values,'LineWidth',lw);
xlim([0 max(pdot_dps2_struct_CPA(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Normal','R. Engine Out','L. Engine Out','Location','SouthEast');

% % Yaw Acceleration
% figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% % set(gcf,'Position',[589,456,755,420]); 
% plot(rdot_dps2_struct_CPR(1).time,rdot_dps2_struct_CPR(1).values,'LineWidth',lw);
% plot(rdot_dps2_struct_CPR(2).time,rdot_dps2_struct_CPR(2).values,'LineWidth',lw);
% plot(rdot_dps2_struct_CPR(3).time,rdot_dps2_struct_CPR(3).values,'LineWidth',lw);
% xlim([0 max(rdot_dps2_struct_CPA(1).time)]);
% set(gca,'FontSize',fs);
% xlabel('Time (sec)');
% ylabel('Yaw Acceleration (deg/sec^2)');
% legend('Normal','R. Engine Out','L. Engine Out','Location','Best');

% Yaw Acceleration
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(rdot_dps2_struct_CPA(1).time-2,rdot_dps2_struct_CPA(1).values,'LineWidth',lw);
plot(rdot_dps2_struct_CPA(2).time-2,rdot_dps2_struct_CPA(2).values,'LineWidth',lw);
plot(rdot_dps2_struct_CPA(3).time-2,rdot_dps2_struct_CPA(3).values,'LineWidth',lw);
xlim([0 max(rdot_dps2_struct_CPA(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Yaw Acceleration (deg/sec^2)');
legend('Normal','R. Engine Out','L. Engine Out','Location','Best');

% Pitch Acceleration
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(qdot_dps2_struct_CPA(1).time-2,qdot_dps2_struct_CPA(1).values,'LineWidth',lw);
plot(qdot_dps2_struct_CPA(2).time-2,qdot_dps2_struct_CPA(2).values,'LineWidth',lw);
plot(qdot_dps2_struct_CPA(3).time-2,qdot_dps2_struct_CPA(3).values,'LineWidth',lw);
xlim([0 max(rdot_dps2_struct_CPA(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Pitch Acceleration (deg/sec^2)');
legend('Normal','R. Engine Out','L. Engine Out','Location','Best');

% Aileron Deflection
figure;
set(gcf,'Position',[589,456,755,480]);
subplot(2,1,1); hold on;
plot(surf_AIL_deg_struct(1).time-2,surf_AIL_deg_struct(1).values,'LineWidth',lw);
plot(surf_AIL_deg_struct(2).time-2,surf_AIL_deg_struct(2).values,'LineWidth',lw);
plot(surf_AIL_deg_struct(3).time-2,surf_AIL_deg_struct(3).values,'LineWidth',lw);
xlim([0 max(surf_AIL_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
% legend('Normal','R. Engine Out','L. Engine Out','Location','Best');
subplot(2,1,2); hold on;
plot(surf_AIR_deg_struct(1).time-2,surf_AIR_deg_struct(1).values,'LineWidth',lw);
plot(surf_AIR_deg_struct(2).time-2,surf_AIR_deg_struct(2).values,'LineWidth',lw);
plot(surf_AIR_deg_struct(3).time-2,surf_AIR_deg_struct(3).values,'LineWidth',lw);
xlim([0 max(surf_AIR_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
legend('Normal','R. Engine Out','L. Engine Out','Location','Best');

% Rudder Deflection
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(surf_RUD_deg_struct(1).time-2,surf_RUD_deg_struct(1).values,'LineWidth',lw);
plot(surf_RUD_deg_struct(2).time-2,surf_RUD_deg_struct(2).values,'LineWidth',lw);
plot(surf_RUD_deg_struct(3).time-2,surf_RUD_deg_struct(3).values,'LineWidth',lw);
xlim([0 max(surf_RUD_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Rudder (deg)');
legend('Normal','R. Engine Out','L. Engine Out','Location','Best');

% Elevator Deflection
figure('units','inch','position',[0,0,8,5]); clf; hold on; 
% set(gcf,'Position',[589,456,755,420]); 
plot(surf_ELV_deg_struct(1).time-2,surf_ELV_deg_struct(1).values,'LineWidth',lw);
plot(surf_ELV_deg_struct(2).time-2,surf_ELV_deg_struct(2).values,'LineWidth',lw);
plot(surf_ELV_deg_struct(3).time-2,surf_ELV_deg_struct(3).values,'LineWidth',lw);
xlim([0 max(surf_ELV_deg_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Elevator (deg)');
legend('Normal','R. Engine Out','L. Engine Out','Location','Best');

