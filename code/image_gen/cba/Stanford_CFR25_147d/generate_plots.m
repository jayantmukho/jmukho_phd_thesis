% Author: Jack Quindlen
% Date: 9/28/2020
% 
% Provided to Juan Alonso and Jayant Mukhopadhaya for the Boeing-Stanford
% research project. Not to be used outside of this work without express
% Boeing permission.

clear all;
close all;
clc;

% Flap settings: 
%   Flap 20: Mach 0.25-0.26 -> ~185 KIAS 

% Run settings:
%   Option 1: Both engines operable
%   Option 2: Left engine out; thrust for level flight
%   Option 3: Right engine out; thrust for level flight

% Run cases: set up so that smaller case # = more aggressive roll
%   The following lists the approximate roll rate. The actual roll rate
%   will change based upon a ramp up and down at either end of the roll
%   from +30deg to -30deg. Also keep in mind that each roll maneuver starts
%   with a more gentle roll from 0deg to 30deg at 3 deg/sec to get the
%   aircraft into position before the more aggressive 60 deg roll.
%       Case 15: desired roll rate of 15 deg/sec
%       Case 23: desired roll rate of 12 deg/sec
%       Case 31: desired roll rate of 9 deg/sec
%       Case 39: desired roll rate of 6 deg/sec

% Note on pitch, roll, yaw metrics:
%   Positive values (>0) indicate the aircraft was able to complete the
%   designated maneuver. Larger values indicate the aircraft had no issue
%   completing the maneuver while a smaller value, but still positive,
%   means the aircraft was <just> able to meet the requirement. Thus, can
%   view the metric as also showing margin/robustness. A negative value
%   means the aircraft was not able to meet the requirement, with a
%   more-negative number indicating the aircraft was wildly unable to meet
%   the requirement. A smaller value, just shy of 0 (ex: -0.04) means the
%   aircraft was <almost> able to meet the maneuver requiremments but
%   didn't have enough control authority left to meet it 100%.

%% 
load('WT_results.mat');
load('WT_trajectory_results.mat');
perf_metrics_MC2 = load('WT_results_scale_2x.mat','perf_metrics_MC');
perf_metrics_MC2 = perf_metrics_MC2.perf_metrics_MC;


%% Plot the nominal roll maneuver results
% Case 39
generate_std_plots(perf_metrics_MC(4),perf_metrics_mean(4));
generate_trajectory_plots(CPR_traj_MC(4).normal,CPR_traj_mean(4).normal,CPA_traj_MC(4).normal,CPA_traj_mean(4).normal);
%generate_trajectory_plots(CPR_traj_MC(4).rightout,CPR_traj_mean(4).rightout,CPA_traj_MC(4).rightout,CPA_traj_mean(4).rightout);
%generate_trajectory_plots(CPR_traj_MC(4).leftout,CPR_traj_mean(4).leftout,CPA_traj_MC(4).leftout,CPA_traj_mean(4).leftout);

%% Plot a slightly more aggressive roll maneuver
% Case 31
generate_std_plots(perf_metrics_MC(3),perf_metrics_mean(3));
generate_trajectory_plots(CPR_traj_MC(3).normal,CPR_traj_mean(3).normal,CPA_traj_MC(3).normal,CPA_traj_mean(3).normal);
generate_trajectory_plots(CPR_traj_MC(3).rightout,CPR_traj_mean(3).rightout,CPA_traj_MC(3).rightout,CPA_traj_mean(3).rightout);
generate_trajectory_plots(CPR_traj_MC(3).leftout,CPR_traj_mean(3).leftout,CPA_traj_MC(3).leftout,CPA_traj_mean(3).leftout);

%% Plot a more aggressive roll maneuver
% Case 23
generate_std_plots(perf_metrics_MC(2),perf_metrics_mean(2));
generate_trajectory_plots(CPR_traj_MC(2).normal,CPR_traj_mean(2).normal,CPA_traj_MC(2).normal,CPA_traj_mean(2).normal);
generate_trajectory_plots(CPR_traj_MC(2).rightout,CPR_traj_mean(2).rightout,CPA_traj_MC(2).rightout,CPA_traj_mean(2).rightout);
generate_trajectory_plots(CPR_traj_MC(2).leftout,CPR_traj_mean(2).leftout,CPA_traj_MC(2).leftout,CPA_traj_mean(2).leftout);

%% Plot the most aggressive roll maneuver
% Case 15
generate_std_plots(perf_metrics_MC(1),perf_metrics_mean(1));
generate_trajectory_plots(CPR_traj_MC(1).normal,CPR_traj_mean(1).normal,CPA_traj_MC(1).normal,CPA_traj_mean(1).normal);
generate_trajectory_plots(CPR_traj_MC(1).rightout,CPR_traj_mean(1).rightout,CPA_traj_MC(1).rightout,CPA_traj_mean(1).rightout);
generate_trajectory_plots(CPR_traj_MC(1).leftout,CPR_traj_mean(1).leftout,CPA_traj_MC(1).leftout,CPA_traj_mean(1).leftout);

%% Plot the effects of sample size (up to 1000 samples)
% Case 15
%   Examines the empirical CDF using only 100, 500, 1000 samples
generate_sample_size_plots(perf_metrics_MC(1),perf_metrics_mean(1));

%% Multiplier of 2 on sigma
% Only have data for case 15
%   Compares Monte Carlo results if the GP variance was scaled by a factor
%   of 2x.
generate_multiplier_comparison_plots(perf_metrics_MC(1),perf_metrics_MC2(1),perf_metrics_mean(1));
