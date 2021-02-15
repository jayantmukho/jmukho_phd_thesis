function [] = reo_perf_metric_plots_sf_vs_mf(perf_metrics_MC,   perf_metrics_MC2,   perf_metrics_MC3,   perf_metrics_MC4,   perf_metrics_MC5,...
                                               perf_metrics_mean, perf_metrics_mean2, perf_metrics_mean3, perf_metrics_mean4, perf_metrics_mean5,...
                                               perf_ctrl_MC,      perf_ctrl_MC2,      perf_ctrl_MC3,      perf_ctrl_MC4,      perf_ctrl_MC5,...
                                               perf_ctrl_mean,    perf_ctrl_mean2,    perf_ctrl_mean3,    perf_ctrl_mean4,    perf_ctrl_mean5)
close all
set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)


fs = 18;
lw = 3.0;

plot_options = plotting_options('thesis');
plot_options.width = 8;
plot_options.height = 5;
plot_options.font_size = fs;
plot_options.line_width = lw;
setup_plots(plot_options);
%% Pitch metric
% Recompute metrics using only max elevator deflection
%   Saturation limits: delta_elv = [-20,20] deg
elv_lim = 20;
perf_metrics_MC.normal.pitch    = ((perf_ctrl_MC.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC.rightout.pitch  = ((perf_ctrl_MC.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC.leftout.pitch   = ((perf_ctrl_MC.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC2.normal.pitch   = ((perf_ctrl_MC2.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC2.rightout.pitch = ((perf_ctrl_MC2.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC2.leftout.pitch  = ((perf_ctrl_MC2.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC3.normal.pitch   = ((perf_ctrl_MC3.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC3.rightout.pitch = ((perf_ctrl_MC3.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC3.leftout.pitch  = ((perf_ctrl_MC3.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC4.normal.pitch   = ((perf_ctrl_MC4.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC4.rightout.pitch = ((perf_ctrl_MC4.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC4.leftout.pitch  = ((perf_ctrl_MC4.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC5.normal.pitch   = ((perf_ctrl_MC5.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC5.rightout.pitch = ((perf_ctrl_MC5.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC5.leftout.pitch  = ((perf_ctrl_MC5.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean.normal.pitch  = ((perf_ctrl_mean.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean2.normal.pitch = ((perf_ctrl_mean2.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean3.normal.pitch = ((perf_ctrl_mean3.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean4.normal.pitch = ((perf_ctrl_mean4.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean5.normal.pitch = ((perf_ctrl_mean5.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean.rightout.pitch  = ((perf_ctrl_mean.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean2.rightout.pitch = ((perf_ctrl_mean2.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean3.rightout.pitch = ((perf_ctrl_mean3.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean4.rightout.pitch = ((perf_ctrl_mean4.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean5.rightout.pitch = ((perf_ctrl_mean5.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean.leftout.pitch  = ((perf_ctrl_mean.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean2.leftout.pitch = ((perf_ctrl_mean2.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean3.leftout.pitch = ((perf_ctrl_mean3.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean4.leftout.pitch = ((perf_ctrl_mean4.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean5.leftout.pitch = ((perf_ctrl_mean5.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);


[f1,x1] = ecdf(perf_metrics_MC.normal.pitch);
[f2,x2] = ecdf(perf_metrics_MC.rightout.pitch);
[f3,x3] = ecdf(perf_metrics_MC.leftout.pitch);
[f4,x4] = ecdf(perf_metrics_MC2.normal.pitch);
[f5,x5] = ecdf(perf_metrics_MC2.rightout.pitch);
[f6,x6] = ecdf(perf_metrics_MC2.leftout.pitch);
[f7,x7] = ecdf(perf_metrics_MC3.normal.pitch);
[f8,x8] = ecdf(perf_metrics_MC3.rightout.pitch);
[f9,x9] = ecdf(perf_metrics_MC3.leftout.pitch);
[f10,x10] = ecdf(perf_metrics_MC4.normal.pitch);
[f11,x11] = ecdf(perf_metrics_MC4.rightout.pitch);
[f12,x12] = ecdf(perf_metrics_MC4.leftout.pitch);
[f13,x13] = ecdf(perf_metrics_MC5.normal.pitch);
[f14,x14] = ecdf(perf_metrics_MC5.rightout.pitch);
[f15,x15] = ecdf(perf_metrics_MC5.leftout.pitch);

% Right out
figure; hold on;
plot(x2,f2,'k');
set(gca,'ColorOrderIndex',1);
plot(x5,f5);
plot(x8,f8);
plot(x11,f11);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'k--');
plot([perf_metrics_mean2.rightout.pitch,perf_metrics_mean2.rightout.pitch],[0 1],'--');
plot([perf_metrics_mean3.rightout.pitch,perf_metrics_mean3.rightout.pitch],[0 1],'--');
plot([perf_metrics_mean4.rightout.pitch,perf_metrics_mean4.rightout.pitch],[0 1],'--');
set(gca,'FontWeight','bold');
xlabel('Pitch Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
% legend('WT','AVL','AVL+SU2','AVL+SU2+WT','FontWeight','bold','Location','southeast');
grid on; box on;
saveas(gcf,'images/reo_pitch_sf_vs_mf.png');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


%% Roll metric
% Recompute metrics with a smaller deflection limit range
%   Original saturation limits: delta_ail = [-25,25] deg
%   New saturation limits: delta_ail = [-15,15] deg
old_ail_lim = 25;
new_ail_lim = 15;
perf_metrics_MC.normal.roll2    = (perf_metrics_MC.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC.rightout.roll2  = (perf_metrics_MC.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC.leftout.roll2   = (perf_metrics_MC.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC2.normal.roll2   = (perf_metrics_MC2.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC2.rightout.roll2 = (perf_metrics_MC2.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC2.leftout.roll2  = (perf_metrics_MC2.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC3.normal.roll2   = (perf_metrics_MC3.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC3.rightout.roll2 = (perf_metrics_MC3.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC3.leftout.roll2  = (perf_metrics_MC3.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC4.normal.roll2   = (perf_metrics_MC4.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC4.rightout.roll2 = (perf_metrics_MC4.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC4.leftout.roll2  = (perf_metrics_MC4.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC5.normal.roll2   = (perf_metrics_MC5.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC5.rightout.roll2 = (perf_metrics_MC5.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC5.leftout.roll2  = (perf_metrics_MC5.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.normal.roll2  = (perf_metrics_mean.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean2.normal.roll2 = (perf_metrics_mean2.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean3.normal.roll2 = (perf_metrics_mean3.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean4.normal.roll2 = (perf_metrics_mean4.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean5.normal.roll2 = (perf_metrics_mean5.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.rightout.roll2  = (perf_metrics_mean.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean2.rightout.roll2 = (perf_metrics_mean2.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean3.rightout.roll2 = (perf_metrics_mean3.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean4.rightout.roll2 = (perf_metrics_mean4.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean5.rightout.roll2 = (perf_metrics_mean5.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.leftout.roll2  = (perf_metrics_mean.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean2.leftout.roll2 = (perf_metrics_mean2.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean3.leftout.roll2 = (perf_metrics_mean3.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean4.leftout.roll2 = (perf_metrics_mean4.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean5.leftout.roll2 = (perf_metrics_mean5.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;

[f1,x1] = ecdf(perf_metrics_MC.normal.roll2);
[f2,x2] = ecdf(perf_metrics_MC.rightout.roll2);
[f3,x3] = ecdf(perf_metrics_MC.leftout.roll2);
[f4,x4] = ecdf(perf_metrics_MC2.normal.roll2);
[f5,x5] = ecdf(perf_metrics_MC2.rightout.roll2);
[f6,x6] = ecdf(perf_metrics_MC2.leftout.roll2);
[f7,x7] = ecdf(perf_metrics_MC3.normal.roll2);
[f8,x8] = ecdf(perf_metrics_MC3.rightout.roll2);
[f9,x9] = ecdf(perf_metrics_MC3.leftout.roll2);
[f10,x10] = ecdf(perf_metrics_MC4.normal.roll2);
[f11,x11] = ecdf(perf_metrics_MC4.rightout.roll2);
[f12,x12] = ecdf(perf_metrics_MC4.leftout.roll2);
[f13,x13] = ecdf(perf_metrics_MC5.normal.roll2);
[f14,x14] = ecdf(perf_metrics_MC5.rightout.roll2);
[f15,x15] = ecdf(perf_metrics_MC5.leftout.roll2);

% Right out
figure; hold on;
plot(x2,f2,'k');
set(gca,'ColorOrderIndex',1);
plot(x5,f5);
plot(x8,f8);
plot(x11,f11);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.rightout.roll2,perf_metrics_mean.rightout.roll2],[0 1],'k--');
plot([perf_metrics_mean2.rightout.roll2,perf_metrics_mean2.rightout.roll2],[0 1],'--');
plot([perf_metrics_mean3.rightout.roll2,perf_metrics_mean3.rightout.roll2],[0 1],'--');
plot([perf_metrics_mean4.rightout.roll2,perf_metrics_mean4.rightout.roll2],[0 1],'--');
set(gca,'FontWeight','bold');
xlabel('Roll Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
% legend('WT','AVL','AVL+SU2','AVL+SU2+WT','FontWeight','bold','Location','northwest');
grid on; box on;
saveas(gcf,'images/reo_roll_sf_vs_mf.png');

%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


%% Yaw metric
% Recompute metrics with a smaller deflection limit range
%   Original saturation limits: delta_rud = [-30,30] deg
%   New saturation limits: delta_rud = [-20,20] deg
old_rud_lim = 30;
new_rud_lim = 20;
perf_metrics_MC.normal.yaw2    = (perf_metrics_MC.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC.rightout.yaw2  = (perf_metrics_MC.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC.leftout.yaw2   = (perf_metrics_MC.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC2.normal.yaw2   = (perf_metrics_MC2.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC2.rightout.yaw2 = (perf_metrics_MC2.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC2.leftout.yaw2  = (perf_metrics_MC2.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC3.normal.yaw2   = (perf_metrics_MC3.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC3.rightout.yaw2 = (perf_metrics_MC3.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC3.leftout.yaw2  = (perf_metrics_MC3.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC4.normal.yaw2   = (perf_metrics_MC4.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC4.rightout.yaw2 = (perf_metrics_MC4.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC4.leftout.yaw2  = (perf_metrics_MC4.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC5.normal.yaw2   = (perf_metrics_MC5.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC5.rightout.yaw2 = (perf_metrics_MC5.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC5.leftout.yaw2  = (perf_metrics_MC5.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.normal.yaw2  = (perf_metrics_mean.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean2.normal.yaw2 = (perf_metrics_mean2.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean3.normal.yaw2 = (perf_metrics_mean3.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean4.normal.yaw2 = (perf_metrics_mean4.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean5.normal.yaw2 = (perf_metrics_mean5.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.rightout.yaw2  = (perf_metrics_mean.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean2.rightout.yaw2 = (perf_metrics_mean2.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean3.rightout.yaw2 = (perf_metrics_mean3.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean4.rightout.yaw2 = (perf_metrics_mean4.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean5.rightout.yaw2 = (perf_metrics_mean5.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.leftout.yaw2  = (perf_metrics_mean.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean2.leftout.yaw2 = (perf_metrics_mean2.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean3.leftout.yaw2 = (perf_metrics_mean3.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean4.leftout.yaw2 = (perf_metrics_mean4.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean5.leftout.yaw2 = (perf_metrics_mean5.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;

[f1,x1] = ecdf(perf_metrics_MC.normal.yaw2);
[f2,x2] = ecdf(perf_metrics_MC.rightout.yaw2);
[f3,x3] = ecdf(perf_metrics_MC.leftout.yaw2);
[f4,x4] = ecdf(perf_metrics_MC2.normal.yaw2);
[f5,x5] = ecdf(perf_metrics_MC2.rightout.yaw2);
[f6,x6] = ecdf(perf_metrics_MC2.leftout.yaw2);
[f7,x7] = ecdf(perf_metrics_MC3.normal.yaw2);
[f8,x8] = ecdf(perf_metrics_MC3.rightout.yaw2);
[f9,x9] = ecdf(perf_metrics_MC3.leftout.yaw2);
[f10,x10] = ecdf(perf_metrics_MC4.normal.yaw2);
[f11,x11] = ecdf(perf_metrics_MC4.rightout.yaw2);
[f12,x12] = ecdf(perf_metrics_MC4.leftout.yaw2);
[f13,x13] = ecdf(perf_metrics_MC5.normal.yaw2);
[f14,x14] = ecdf(perf_metrics_MC5.rightout.yaw2);
[f15,x15] = ecdf(perf_metrics_MC5.leftout.yaw2);


% Right out
figure; hold on;
plot(x2,f2,'k');
set(gca,'ColorOrderIndex',1);
plot(x5,f5);
plot(x8,f8);
plot(x11,f11);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.rightout.yaw2,perf_metrics_mean.rightout.yaw2],[0 1],'k--');
plot([perf_metrics_mean2.rightout.yaw2,perf_metrics_mean2.rightout.yaw2],[0 1],'--');
plot([perf_metrics_mean3.rightout.yaw2,perf_metrics_mean3.rightout.yaw2],[0 1],'--');
plot([perf_metrics_mean4.rightout.yaw2,perf_metrics_mean4.rightout.yaw2],[0 1],'--');
set(gca,'FontWeight','bold');
xlabel('Yaw Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('WT','AVL','AVL+SU2','AVL+SU2+WT','FontWeight','bold','Location','northwest');
grid on; box on;
saveas(gcf,'images/reo_yaw_sf_vs_mf.png');

%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


end

