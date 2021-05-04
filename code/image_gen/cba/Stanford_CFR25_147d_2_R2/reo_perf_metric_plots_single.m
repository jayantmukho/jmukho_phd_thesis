function [] = reo_perf_metric_plots_single(perf_metrics_MC, perf_metrics_mean, perf_ctrl_MC, perf_ctrl_mean)
%% Pitch metric
% Recompute metrics using only max elevator deflection
%   Saturation limits: delta_elv = [-20,20] deg
elv_lim = 20;
perf_metrics_MC.normal.pitch    = ((perf_ctrl_MC.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC.rightout.pitch  = ((perf_ctrl_MC.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_MC.leftout.pitch   = ((perf_ctrl_MC.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean.normal.pitch  = ((perf_ctrl_mean.normal.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean.rightout.pitch  = ((perf_ctrl_mean.rightout.elev_deg.max)-elv_lim)/(elv_lim*-2);
perf_metrics_mean.leftout.pitch  = ((perf_ctrl_mean.leftout.elev_deg.max)-elv_lim)/(elv_lim*-2);

[f1,x1] = ecdf(perf_metrics_MC.normal.pitch);
[f2,x2] = ecdf(perf_metrics_MC.rightout.pitch);
[f3,x3] = ecdf(perf_metrics_MC.leftout.pitch);

% Right out
figure(1); hold on;
ci = get(gca,'ColorOrderIndex');
plot(x2,f2);
set(gca,'ColorOrderIndex',ci);
% plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'--');
plot([0,0],[0 1],'-.','color','#8C1515','HandleVisibility','off');
set(gca,'FontWeight','bold');
xlabel('Pitch Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
% legend('WT','AVL','AVL+SU2','AVL+SU2+WT','FontWeight','bold','Location','southeast');
grid on; box on;
% saveas(gcf,'images/reo_pitch_sf_vs_mf.png');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);
[~,ind_fail] = min(abs(x2));
fr = f2(ind_fail);
min_metric = min(x2);
fprintf('  Pitch metric:\n    Failure Rate= %.2f\n    Min metric= %.2f\n',fr*100,min_metric)

%% Roll metric
% Recompute metrics with a smaller deflection limit range
%   Original saturation limits: delta_ail = [-25,25] deg
%   New saturation limits: delta_ail = [-15,15] deg
old_ail_lim = 25;
new_ail_lim = 15;
perf_metrics_MC.normal.roll2    = (perf_metrics_MC.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC.rightout.roll2  = (perf_metrics_MC.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC.leftout.roll2   = (perf_metrics_MC.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.normal.roll2  = (perf_metrics_mean.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.rightout.roll2  = (perf_metrics_mean.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.leftout.roll2  = (perf_metrics_mean.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;

[f1,x1] = ecdf(perf_metrics_MC.normal.roll2);
[f2,x2] = ecdf(perf_metrics_MC.rightout.roll2);
[f3,x3] = ecdf(perf_metrics_MC.leftout.roll2);

% Right out
figure(2); hold on;
plot(x2,f2);
set(gca,'ColorOrderIndex',ci);
% plot([perf_metrics_mean.rightout.roll2,perf_metrics_mean.rightout.roll2],[0 1],'--');
plot([0,0],[0 1],'-.','color','#8C1515','HandleVisibility','off');

set(gca,'FontWeight','bold');
xlabel('Roll Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
% legend('WT','AVL','AVL+SU2','AVL+SU2+WT','FontWeight','bold','Location','northwest');
grid on; box on;
% saveas(gcf,'images/reo_roll_sf_vs_mf.png');

%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);
[~,ind_fail] = min(abs(x2));
fr = f2(ind_fail);
min_metric = min(x2);
sr_100_defl = new_ail_lim;
if min_metric < 0
    sr_100_defl = new_ail_lim * (1 - min_metric);
end
[~,ind_95] = min(abs(f2-0.05));
metric_95 = x2(ind_95);
sr_95_defl = new_ail_lim;
if metric_95 < 0
    sr_95_defl = new_ail_lim * (1 - metric_95);
end
fprintf('  Roll metric:\n    Failure Rate= %.2f\n    Min metric= %.2f\n    100%% design= %.2f degrees\n',fr*100,min_metric,sr_100_defl)
fprintf('    95%% design = %.2f degrees\n',sr_95_defl);
%% Yaw metric
% Recompute metrics with a smaller deflection limit range
%   Original saturation limits: delta_rud = [-30,30] deg
%   New saturation limits: delta_rud = [-20,20] deg
old_rud_lim = 30;
new_rud_lim = 20;
perf_metrics_MC.normal.yaw2    = (perf_metrics_MC.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC.rightout.yaw2  = (perf_metrics_MC.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC.leftout.yaw2   = (perf_metrics_MC.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.normal.yaw2  = (perf_metrics_mean.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.rightout.yaw2  = (perf_metrics_mean.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.leftout.yaw2  = (perf_metrics_mean.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
[f1,x1] = ecdf(perf_metrics_MC.normal.yaw2);
[f2,x2] = ecdf(perf_metrics_MC.rightout.yaw2);
[f3,x3] = ecdf(perf_metrics_MC.leftout.yaw2);

% Right out
figure(3); hold on;
plot(x2,f2);
set(gca,'ColorOrderIndex',ci);
% plot([perf_metrics_mean.rightout.yaw2,perf_metrics_mean.rightout.yaw2],[0 1],'--');
plot([0,0],[0 1],'-.','color','#8C1515','HandleVisibility','off');

set(gca,'FontWeight','bold');
xlabel('Yaw Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
% legend('WT','AVL','AVL+SU2','AVL+SU2+WT','FontWeight','bold','Location','northwest');
grid on; box on;
[~,ind_fail] = min(abs(x2));
fr = f2(ind_fail);
min_metric = min(x2);
fprintf('  Yaw metric:\n    Failure Rate= %.2f\n    Min metric= %.2f\n',fr*100,min_metric)
% saveas(gcf,'images/reo_yaw_sf_vs_mf.png');

%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

%% Print metric stats
% fprintf('Metric Stats ')
% metric_stats(perf_metrics_MC.rightout);
% fprintf('Failure Rate= %.2f\n',fr*100)


end

