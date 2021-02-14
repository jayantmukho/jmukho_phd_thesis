function [metrics_MC,metrics_mean,traj,trim_MC,trim_mean,ctrl_MC,ctrl_mean] = load_MonteCarlo_results(monte_carlo_file,trajectory_file)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
metrics_MC = load(monte_carlo_file,'perf_metrics_MC');
metrics_MC = metrics_MC.perf_metrics_MC;

metrics_mean = load(monte_carlo_file,'perf_metrics_mean');
metrics_mean = metrics_mean.perf_metrics_mean;

traj = load(trajectory_file);

trim_MC = load(monte_carlo_file,'trim_cond_MC');
trim_MC = trim_MC.trim_cond_MC;

trim_mean = load(monte_carlo_file,'trim_cond_mean');
trim_mean = trim_mean.trim_cond_mean;

ctrl_MC = load(monte_carlo_file,'ctrl_surf_defl_MC');
ctrl_MC = ctrl_MC.ctrl_surf_defl_MC;

ctrl_mean = load(monte_carlo_file,'ctrl_surf_defl_mean');
ctrl_mean = ctrl_mean.ctrl_surf_defl_mean;
end

