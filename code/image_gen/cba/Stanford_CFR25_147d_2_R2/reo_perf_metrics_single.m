function [] = reo_perf_metrics_single(perf_metrics_MC, perf_metrics_mean, perf_ctrl_MC, perf_ctrl_mean)
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


% Compute failure rates and design decisions
[~,ind_fail] = min(abs(x2));    % find index for when metric = 0
fr = f2(ind_fail);              % get failure rate from CDF value at 0 metric
min_metric = min(x2);           % minimum metric
sr_100_defl = elv_lim;
if min_metric < 0
    % if minimum metric is < 0, calculate deflection angle that would
    % result in 100% success rate.
    sr_100_defl = elv_lim * (1 - min_metric); 
end
[~,ind_95] = min(abs(f2-0.05)); % find index for when CDF = 0.05 (95% success rate)
metric_95 = x2(ind_95);         % get the metric value corresponding to 95% success rate
sr_95_defl = elv_lim;
if metric_95 < 0
    % if 95% success rate metric is < 0, calculate deflection angle that 
    % results in that success rate.
    sr_95_defl = elv_lim * (1 - metric_95);
end

% Print results
fprintf('  Pitch metric:\n    Failure Rate= %.2f\n    Min metric= %.2f\n    100%% design= %.2f degrees\n',fr*100,min_metric,sr_100_defl)
fprintf('    95%% design = %.2f degrees\n',sr_95_defl);

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

% Compute failure rates and design decisions
[~,ind_fail] = min(abs(x2));    % find index for when metric = 0
fr = f2(ind_fail);              % get failure rate from CDF value at 0 metric
min_metric = min(x2);           % minimum metric
sr_100_defl = new_ail_lim;
if min_metric < 0
    % if minimum metric is < 0, calculate deflection angle that would
    % result in 100% success rate.
    sr_100_defl = new_ail_lim * (1 - min_metric); 
end
[~,ind_95] = min(abs(f2-0.05)); % find index for when CDF = 0.05 (95% success rate)
metric_95 = x2(ind_95);         % get the metric value corresponding to 95% success rate
sr_95_defl = new_ail_lim;
if metric_95 < 0
    % if 95% success rate metric is < 0, calculate deflection angle that 
    % results in that success rate.
    sr_95_defl = new_ail_lim * (1 - metric_95);
end

% Print results
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


% Compute failure rates and design decisions
[~,ind_fail] = min(abs(x2));    % find index for when metric = 0
fr = f2(ind_fail);              % get failure rate from CDF value at 0 metric
min_metric = min(x2);           % minimum metric
sr_100_defl = new_rud_lim;
if min_metric < 0
    % if minimum metric is < 0, calculate deflection angle that would
    % result in 100% success rate.
    sr_100_defl = new_rud_lim * (1 - min_metric); 
end
[~,ind_95] = min(abs(f2-0.05)); % find index for when CDF = 0.05 (95% success rate)
metric_95 = x2(ind_95);         % get the metric value corresponding to 95% success rate
sr_95_defl = new_rud_lim;
if metric_95 < 0
    % if 95% success rate metric is < 0, calculate deflection angle that 
    % results in that success rate.
    sr_95_defl = new_rud_lim * (1 - metric_95);
end

% Print results
fprintf('  Yaw metric:\n    Failure Rate= %.2f\n    Min metric= %.2f\n    100%% design= %.2f degrees\n',fr*100,min_metric,sr_100_defl)
fprintf('    95%% design = %.2f degrees\n',sr_95_defl);


end

