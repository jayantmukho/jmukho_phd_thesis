clear all;
close all;
clc;
set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)


fs = 18;
lw = 3.0;

load('data_CFR147d_initial_example.mat');
plot_options = plotting_options('thesis');
plot_options.width = 8;
plot_options.height = 5;
plot_options.font_size = fs;
plot_options.line_width = lw;
setup_plots(plot_options);

%% Aggressive manuever plots
close all

load('data_CFR147d_saturation_example.mat');
% Roll Angle
figure(1); clf; hold on;
plot(phi_rad_struct(4).time,phi_rad_struct(4).values*180/pi,'k','LineWidth',lw);
set(gca,'ColorOrderIndex',1);
plot(phi_rad_struct(1).time,phi_rad_struct(1).values*180/pi,'LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
legend('Original','New');
grid on; box on;
saveas(gcf,'images/cfr147d_agg_roll_angle.png')

figure(2); clf; hold on;
plot(pdot_dps2_struct_CPR(4).time,pdot_dps2_struct_CPR(4).values,'k','LineWidth',lw);
set(gca,'ColorOrderIndex',1);
plot(pdot_dps2_struct_CPR(1).time,pdot_dps2_struct_CPR(1).values,'LineWidth',lw);
xlim([0 max(pdot_dps2_struct_CPR(4).time)]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
legend('Original','New');
grid on; box on;
saveas(gcf,'images/cfr147d_agg_roll_acc.png')

% Roll command vs saturation limits
figure(3); clf; hold on;
subplot(2,1,1); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',lw);
plot(surf_AIL_deg_struct(4).time-2,surf_AIL_deg_struct(4).values,'k','LineWidth',lw);
set(gca,'ColorOrderIndex',1);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*-1,'LineWidth',lw);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',lw);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
ylim([-40 40])
grid on; box on;
% legend('Saturation Limits','Normal','R. Engine Out','L. Engine Out');
subplot(2,1,2); hold on;
plot([0 max(roll_surf_cmd_struct(1).time)],[25 25],'k--','LineWidth',lw);
plot(surf_AIR_deg_struct(4).time-2,surf_AIR_deg_struct(4).values,'k','LineWidth',lw);
set(gca,'ColorOrderIndex',1);
plot(roll_surf_cmd_struct(1).time-2,roll_surf_cmd_struct(1).values*+1,'LineWidth',lw);
plot([0 max(roll_surf_cmd_struct(1).time)],[-25 -25],'k--','LineWidth',lw);
xlim([0 max(roll_surf_cmd_struct(1).time)-2]);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
ylim([-40 40])
% legend('Saturation Limits','Original','Normal','R. Engine Out','L. Engine Out','Location','Best');
grid on; box on;
saveas(gcf,'images/cfr147d_agg_ail_defl.png')