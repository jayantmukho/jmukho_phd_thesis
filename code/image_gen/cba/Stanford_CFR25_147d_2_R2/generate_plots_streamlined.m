% Author: Jack Quindlen
% Date: 12/28/2020
% 
% Provided to Juan Alonso and Jayant Mukhopadhaya for the Boeing-Stanford
% research project. Not to be used outside of this work without express
% Boeing permission.

clear all;
close all;
clc;

% Flap settings: 
%   Flap 0: Mach 0.32 -> ~200 KIAS 

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
%       Case 17: desired roll rate of 14.25 deg/sec
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


%% Load results

% Redo of the "full" WT dataset (non-sparse)
full_metrics_MC = load('fullWT_results.mat','perf_metrics_MC');
full_metrics_MC = full_metrics_MC.perf_metrics_MC;
full_metrics_mean = load('fullWT_results.mat','perf_metrics_mean');
full_metrics_mean = full_metrics_mean.perf_metrics_mean;
full_traj = load('fullWT_trajectory_results.mat');
full_trim_MC = load('fullWT_results.mat','trim_cond_MC');
full_trim_MC = full_trim_MC.trim_cond_MC;
full_trim_mean = load('fullWT_results.mat','trim_cond_mean');
full_trim_mean = full_trim_mean.trim_cond_mean;
full_ctrl_MC = load('fullWT_results.mat','ctrl_surf_defl_MC');
full_ctrl_MC = full_ctrl_MC.ctrl_surf_defl_MC;
full_ctrl_mean = load('fullWT_results.mat','ctrl_surf_defl_mean');
full_ctrl_mean = full_ctrl_mean.ctrl_surf_defl_mean;

% AVL dataset4
avl4_metrics_MC = load('AVL4_results.mat','perf_metrics_MC');
avl4_metrics_MC = avl4_metrics_MC.perf_metrics_MC;
avl4_metrics_mean = load('AVL4_results.mat','perf_metrics_mean');
avl4_metrics_mean = avl4_metrics_mean.perf_metrics_mean;
avl4_traj = load('AVL4_trajectory_results.mat');
avl4_trim_MC = load('AVL4_results.mat','trim_cond_MC');
avl4_trim_MC = avl4_trim_MC.trim_cond_MC;
avl4_trim_mean = load('AVL4_results.mat','trim_cond_mean');
avl4_trim_mean = avl4_trim_mean.trim_cond_mean;
avl4_ctrl_MC = load('AVL4_results.mat','ctrl_surf_defl_MC');
avl4_ctrl_MC = avl4_ctrl_MC.ctrl_surf_defl_MC;
avl4_ctrl_mean = load('AVL4_results.mat','ctrl_surf_defl_mean');
avl4_ctrl_mean = avl4_ctrl_mean.ctrl_surf_defl_mean;

% Multi-fidelity 2-layer (AVL + CFD)
mf2d_metrics_MC = load('MF2D_results.mat','perf_metrics_MC');
mf2d_metrics_MC = mf2d_metrics_MC.perf_metrics_MC;
mf2d_metrics_mean = load('MF2D_results.mat','perf_metrics_mean');
mf2d_metrics_mean = mf2d_metrics_mean.perf_metrics_mean;
mf2d_traj = load('MF2D_trajectory_results.mat');
mf2d_trim_MC = load('MF2D_results.mat','trim_cond_MC');
mf2d_trim_MC = mf2d_trim_MC.trim_cond_MC;
mf2d_trim_mean = load('MF2D_results.mat','trim_cond_mean');
mf2d_trim_mean = mf2d_trim_mean.trim_cond_mean;
mf2d_ctrl_MC = load('MF2D_results.mat','ctrl_surf_defl_MC');
mf2d_ctrl_MC = mf2d_ctrl_MC.ctrl_surf_defl_MC;
mf2d_ctrl_mean = load('MF2D_results.mat','ctrl_surf_defl_mean');
mf2d_ctrl_mean = mf2d_ctrl_mean.ctrl_surf_defl_mean;


%% Plotting options
%   Select run case
% run_case = 1; %Run Case 15 (most aggressive)
run_case = 2; %Run Case 17 (aggressive) [use this instead of case 15 from now on]


%   Select type of figure to generate
%       Recommend types 1, 2, and 5
plot_type = 1; %plot CDFs and mean 
plot_type = 2; %plot trajectories
% plot_type = 3; %plot sample size
% plot_type = 4; %compare multipliers
plot_type = 5; %compare distributions
% plot_type = 6; %compare trim AoA


%% Generate plots
switch plot_type
    case 1 %CDF and mean               
        % Full wind tunnel dataset
        generate_std_plots(full_metrics_MC(run_case),full_metrics_mean(run_case));
               
        % AVL dataset 4
        generate_std_plots(avl4_metrics_MC(run_case),avl4_metrics_mean(run_case));
        
        % Multi-fidelity (AVL+CFD) dataset
        generate_std_plots(mf2d_metrics_MC(run_case),mf2d_metrics_mean(run_case));
        
    case 2 %Trajectories  
        
        % Full wind tunnel dataset
        generate_trajectory_plots(full_traj.CPR_traj_MC(run_case).normal,...
            full_traj.CPR_traj_mean(run_case).normal,...
            full_traj.CPA_traj_MC(run_case).normal,...
            full_traj.CPA_traj_mean(run_case).normal);
        generate_trajectory_plots(full_traj.CPR_traj_MC(run_case).rightout,...
            full_traj.CPR_traj_mean(run_case).rightout,...
            full_traj.CPA_traj_MC(run_case).rightout,...
            full_traj.CPA_traj_mean(run_case).rightout);
        generate_trajectory_plots(full_traj.CPR_traj_MC(run_case).leftout,...
            full_traj.CPR_traj_mean(run_case).leftout,...
            full_traj.CPA_traj_MC(run_case).leftout,...
            full_traj.CPA_traj_mean(run_case).leftout);
        
        % AVL dataset 4
        generate_trajectory_plots(avl4_traj.CPR_traj_MC(run_case).normal,...
            avl4_traj.CPR_traj_mean(run_case).normal,...
            avl4_traj.CPA_traj_MC(run_case).normal,...
            avl4_traj.CPA_traj_mean(run_case).normal);
        generate_trajectory_plots(avl4_traj.CPR_traj_MC(run_case).rightout,...
            avl4_traj.CPR_traj_mean(run_case).rightout,...
            avl4_traj.CPA_traj_MC(run_case).rightout,...
            avl4_traj.CPA_traj_mean(run_case).rightout);
        generate_trajectory_plots(avl4_traj.CPR_traj_MC(run_case).leftout,...
            avl4_traj.CPR_traj_mean(run_case).leftout,...
            avl4_traj.CPA_traj_MC(run_case).leftout,...
            avl4_traj.CPA_traj_mean(run_case).leftout);
        
        % Multi-fidelity (AVL+CFD) dataset
        generate_trajectory_plots(mf2d_traj.CPR_traj_MC(run_case).normal,...
            mf2d_traj.CPR_traj_mean(run_case).normal,...
            mf2d_traj.CPA_traj_MC(run_case).normal,...
            mf2d_traj.CPA_traj_mean(run_case).normal);
        generate_trajectory_plots(mf2d_traj.CPR_traj_MC(run_case).rightout,...
            mf2d_traj.CPR_traj_mean(run_case).rightout,...
            mf2d_traj.CPA_traj_MC(run_case).rightout,...
            mf2d_traj.CPA_traj_mean(run_case).rightout);
        generate_trajectory_plots(mf2d_traj.CPR_traj_MC(run_case).leftout,...
            mf2d_traj.CPR_traj_mean(run_case).leftout,...
            mf2d_traj.CPA_traj_MC(run_case).leftout,...
            mf2d_traj.CPA_traj_mean(run_case).leftout);
        
    case 3 %Sample size
        
        % Full wind tunnel dataset
        generate_sample_size_plots(full_metrics_MC(run_case),full_metrics_mean(run_case));

        % AVL dataset 4
        generate_sample_size_plots(avl4_metrics_MC(run_case),avl4_metrics_mean(run_case));
        
        % Multi-fidelity (AVL+CFD) dataset
        generate_sample_size_plots(mf2d_metrics_MC(run_case),mf2d_metrics_mean(run_case));
        
    case 4 %Compare multipliers
%         % Only have data for case 15
%         %   Compares Monte Carlo results if the GP variance was scaled by a factor
%         %   of 2x.
%         generate_multiplier_comparison_plots(perf_metrics_MC(1),perf_metrics_MC2(1),perf_metrics_mean(1));
        
    case 5 %CDF and mean

        % Full wind tunnel dataset vs AVL vs Multi-fidelity (AVL+CFD) dataset
%         generate_comparison_plots_MF2D_all(full_metrics_MC(run_case),avl4_metrics_MC(run_case),mf2d_metrics_MC(run_case),full_metrics_mean(run_case),avl4_metrics_mean(run_case),mf2d_metrics_mean(run_case));

        % Full wind tunnel dataset vs AVL vs Multi-fidelity (AVL+CFD) dataset
%         generate_ctrl_plots_MF2D_all(full_ctrl_MC(run_case),avl4_ctrl_MC(run_case),mf2d_ctrl_MC(run_case),full_ctrl_mean(run_case),avl4_ctrl_mean(run_case),mf2d_ctrl_mean(run_case));
        
        % Full wind tunnel dataset vs AVL vs Multi-fidelity (AVL+CFD)
        % dataset with reduced deflection limits
        regenerate_perf_metric_plots_all(full_metrics_MC(run_case),avl4_metrics_MC(run_case),mf2d_metrics_MC(run_case),full_metrics_mean(run_case),avl4_metrics_mean(run_case),mf2d_metrics_mean(run_case));
        
    case 6 %CDF and mean       
        
        % Full wind tunnel dataset vs AVL dataset 4 vs Multi-fidelity (AVL+CFD) dataset
        generate_trim_comparison_plots_MF2D(full_trim_MC(run_case),avl4_trim_MC(run_case),mf2d_trim_MC(run_case),full_trim_mean(run_case),avl4_trim_mean(run_case),mf2d_trim_mean(run_case));
        
end
   
