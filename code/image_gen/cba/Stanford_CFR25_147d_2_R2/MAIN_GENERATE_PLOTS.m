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

%%%%%%%%%%%%%%%% FULL WT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
full_results_filename = 'fullWT_results_R2.mat';
full_trajectory_filename = 'fullWT_trajectory_results_R2.mat';
[full_metrics_MC,full_metrics_mean,full_traj,full_trim_MC,full_trim_mean,...
    full_ctrl_MC,full_ctrl_mean] = load_MonteCarlo_results(full_results_filename,full_trajectory_filename);

%%%%%%%%%%%%%%%%%%%%%%%%%%% Sparse WT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sparse WT dataset 2 (every 4 deg)
sparseWT_results_filename = 'Sparse2_results_R2.mat';
sparseWT_trajectory_filename = 'Sparse2_trajectory_results_R2.mat';
[sparse2_metrics_MC,sparse2_metrics_mean,sparse2_traj,sparse2_trim_MC,sparse2_trim_mean,...
    sparse2_ctrl_MC,sparse2_ctrl_mean] = load_MonteCarlo_results(sparseWT_results_filename,sparseWT_trajectory_filename);

%%%%%%%%%%%%%%%%%%% 1-fidelity AVL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AVL dataset4
avl_results_filename = 'AVL4_results.mat';
avl_trajectory_filename = 'AVL4_trajectory_results.mat';
[avl4_metrics_MC,avl4_metrics_mean,avl4_traj,avl4_trim_MC,avl4_trim_mean,...
    avl4_ctrl_MC,avl4_ctrl_mean] = load_MonteCarlo_results(avl_results_filename,avl_trajectory_filename);


%%%%%%%%%%%%%%%%%%%%%%% 2-fidelity MF-GP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multi-fidelity 2-layer (AVL + CFD)
mf2_results_filename = 'MF2D_results.mat';
mf2_trajectory_filename = 'MF2D_trajectory_results.mat';
[mf2d_metrics_MC,mf2d_metrics_mean,mf2d_traj,mf2d_trim_MC,mf2d_trim_mean,...
    mf2d_ctrl_MC,mf2d_ctrl_mean] = load_MonteCarlo_results(mf2_results_filename,mf2_trajectory_filename);


%%%%%%%%%%%%%%%%%%%%%%% 3-fidelity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Multi-fidelity 3-layer (AVL + CFD + WT)

% %%%%% USE THIS VERSION IF YOU'RE DOING "FULL" WT DATA %%%%%%
full_mf3_results_filename = 'FullMF3_results_R2.mat';
full_mf3_trajectory_filename = 'FullMF3_trajectory_results_R2.mat';
[full_mf3d_metrics_MC,full_mf3d_metrics_mean,full_mf3d_traj,full_mf3d_trim_MC,full_mf3d_trim_mean,...
    full_mf3d_ctrl_MC,full_mf3d_ctrl_mean] = load_MonteCarlo_results(full_mf3_results_filename,full_mf3_trajectory_filename);

% %%%%% USE THIS VERSION IF YOU'RE DOING "SPARSE/COARSE" WT DATA %%%%%%
sparse_mf3_results_filename = 'SparseMF3_results_R2.mat';
sparse_mf3_trajectory_filename = 'SparseMF3_trajectory_results_R2.mat';
[sparse_mf3d_metrics_MC,sparse_mf3d_metrics_mean,sparse_mf3d_traj,sparse_mf3d_trim_MC,sparse_mf3d_trim_mean,...
    sparse_mf3d_ctrl_MC,sparse_mf3d_ctrl_mean] = load_MonteCarlo_results(sparse_mf3_results_filename,sparse_mf3_trajectory_filename);

% %%%%% USE THIS VERSION IF YOU'RE DOING "Local" WT DATA %%%%%%
local_mf3_results_filename = 'LocalMF3_results.mat';
local_mf3_trajectory_filename = 'LocalMF3_trajectory_results.mat';
[local_mf3d_metrics_MC,local_mf3d_metrics_mean,local_mf3d_traj,local_mf3d_trim_MC,local_mf3d_trim_mean,...
    local_mf3d_ctrl_MC,local_mf3d_ctrl_mean] = load_MonteCarlo_results(local_mf3_results_filename,local_mf3_trajectory_filename);

% 
% %%%%% "PARTIAL" 3-FIDELITY DATASETS %%%%%%
% %   ONLY SOME OF THE AERO COEFFICIENT GPs ARE UPDATED WITH WIND TUNNEL AND/
% %   OR WATER TUNNEL DATA
% 
% % Only bare-aiframe coefficients (no control surfaces or dynamic derivatives)
% mf3_results_filename = 'PartialMF3_BA_full_results.mat'; %full (all WT datapoints)
% mf3_trajectory_filename = 'PartialMF3_BA_full_trajectory_results.mat';
% 
% mf3_results_filename = 'PartialMF3_BA_coarse_results.mat'; %coarse (only sparse subset)
% mf3_trajectory_filename = 'PartialMF3_BA_coarse_trajectory_results.mat';
% 
% % Only control surface coefficients (no bare-airframe or dynamic derivatives)
% mf3_results_filename = 'PartialMF3_CTRL_full_results.mat'; %full (all WT datapoints)
% mf3_trajectory_filename = 'PartialMF3_CTRL_full_trajectory_results.mat';
% 
% mf3_results_filename = 'PartialMF3_CTRL_coarse_results.mat'; %coarse (only sparse subset)
% mf3_trajectory_filename = 'PartialMF3_CTRL_coarse_trajectory_results.mat';
% 
% % Bare-airframe and control surface (but no dynamic derivatives)
% mf3_results_filename = 'PartialMF3_BACTRL_full_results.mat'; %full (all WT datapoints)
% mf3_trajectory_filename = 'PartialMF3_BACTRL_full_trajectory_results.mat';
% 
% mf3_results_filename = 'PartialMF3_BACTRL_coarse_results.mat'; %coarse (only sparse subset)
% mf3_trajectory_filename = 'PartialMF3_BACTRL_coarse_trajectory_results.mat';
% 
% % Bare-airframe and dynamic derivatives (but control surfaces)
% mf3_results_filename = 'PartialMF3_BADYN_full_results.mat'; %full (all WT datapoints)
% mf3_trajectory_filename = 'PartialMF3_BADYN_full_trajectory_results.mat';
% 
% mf3_results_filename = 'PartialMF3_BADYN_coarse_results.mat'; %coarse (only sparse subset)
% mf3_trajectory_filename = 'PartialMF3_BADYN_coarse_trajectory_results.mat';
% 
% %%%%% USE THIS VERSION IF YOU'RE DOING "PARTIAL" WT DATA %%%%%%
% %   MIX = sparse/coarse bare-airframe and control surface aero, but "full"
% %   set of water tunnel data for dynamic derivatives
% mf3_results_filename = 'PartialMF3_mix_results.mat'; %coarse (only sparse subset)
% mf3_trajectory_filename = 'PartialMF3_mix_trajectory_results.mat';





%% Plotting options
%   Select run case
run_case = 2; %Run Case 17 (aggressive) [use this instead of case 15 from now on]


%   Select type of figure to generate
%       Recommend types 1, 2, and 5
% plot_type = 1; %plot CDFs and mean 
% plot_type = 2; %plot trajectories
% plot_type = 3; %plot mc section plots
plot_type = 4; %plot single cases
% plot_type = 5; %compare sf and mf
% plot_type = 6; %compare reduced data sims
% plot_type = 7; % Bootstrapping


%% Generate plots
switch plot_type
    case 1 %CDF and mean               
        % Full wind tunnel dataset
        generate_std_plots(full_metrics_MC(run_case),full_metrics_mean(run_case));
               
        % AVL dataset 4
        generate_std_plots(avl4_metrics_MC(run_case),avl4_metrics_mean(run_case));
        
        % Multi-fidelity (AVL+CFD) dataset
        generate_std_plots(mf2d_metrics_MC(run_case),mf2d_metrics_mean(run_case));
        
        % Sparse WT dataset 2
        generate_std_plots(sparse2_metrics_MC(run_case),sparse2_metrics_mean(run_case));
        
        % Multi-fidelity (AVL+CFD+WT) dataset
        generate_std_plots(full_mf3d_metrics_MC(run_case),full_mf3d_metrics_mean(run_case));
        
    case 2 %Trajectories  
        
        % Full wind tunnel dataset
        generate_trajectory_plots(full_traj.CPR_traj_MC(run_case).normal,...
            full_traj.CPR_traj_mean(run_case).normal,...
            full_traj.CPA_traj_MC(run_case).normal,...
            full_traj.CPA_traj_mean(run_case).normal);
%         generate_trajectory_plots(full_traj.CPR_traj_MC(run_case).rightout,...
%             full_traj.CPR_traj_mean(run_case).rightout,...
%             full_traj.CPA_traj_MC(run_case).rightout,...
%             full_traj.CPA_traj_mean(run_case).rightout);
%         generate_trajectory_plots(full_traj.CPR_traj_MC(run_case).leftout,...
%             full_traj.CPR_traj_mean(run_case).leftout,...
%             full_traj.CPA_traj_MC(run_case).leftout,...
%             full_traj.CPA_traj_mean(run_case).leftout);
        
%         % AVL dataset 4
        generate_trajectory_plots(avl4_traj.CPR_traj_MC(run_case).normal,...
            avl4_traj.CPR_traj_mean(run_case).normal,...
            avl4_traj.CPA_traj_MC(run_case).normal,...
            avl4_traj.CPA_traj_mean(run_case).normal);
%         generate_trajectory_plots(avl4_traj.CPR_traj_MC(run_case).rightout,...
%             avl4_traj.CPR_traj_mean(run_case).rightout,...
%             avl4_traj.CPA_traj_MC(run_case).rightout,...
%             avl4_traj.CPA_traj_mean(run_case).rightout);
%         generate_trajectory_plots(avl4_traj.CPR_traj_MC(run_case).leftout,...
%             avl4_traj.CPR_traj_mean(run_case).leftout,...
%             avl4_traj.CPA_traj_MC(run_case).leftout,...
%             avl4_traj.CPA_traj_mean(run_case).leftout);
%         
%         % Multi-fidelity (AVL+CFD) dataset
        generate_trajectory_plots(mf2d_traj.CPR_traj_MC(run_case).normal,...
            mf2d_traj.CPR_traj_mean(run_case).normal,...
            mf2d_traj.CPA_traj_MC(run_case).normal,...
            mf2d_traj.CPA_traj_mean(run_case).normal);
%         generate_trajectory_plots(mf2d_traj.CPR_traj_MC(run_case).rightout,...
%             mf2d_traj.CPR_traj_mean(run_case).rightout,...
%             mf2d_traj.CPA_traj_MC(run_case).rightout,...
%             mf2d_traj.CPA_traj_mean(run_case).rightout);
%         generate_trajectory_plots(mf2d_traj.CPR_traj_MC(run_case).leftout,...
%             mf2d_traj.CPR_traj_mean(run_case).leftout,...
%             mf2d_traj.CPA_traj_MC(run_case).leftout,...
%             mf2d_traj.CPA_traj_mean(run_case).leftout);
        
        % Sparse WT dataset 2
%         generate_trajectory_plots(sparse2_traj.CPR_traj_MC(run_case).normal,...
%             sparse2_traj.CPR_traj_mean(run_case).normal,...
%             sparse2_traj.CPA_traj_MC(run_case).normal,...
%             sparse2_traj.CPA_traj_mean(run_case).normal);
%         generate_trajectory_plots(sparse2_traj.CPR_traj_MC(run_case).rightout,...
%             sparse2_traj.CPR_traj_mean(run_case).rightout,...
%             sparse2_traj.CPA_traj_MC(run_case).rightout,...
%             sparse2_traj.CPA_traj_mean(run_case).rightout);
%         generate_trajectory_plots(sparse2_traj.CPR_traj_MC(run_case).leftout,...
%             sparse2_traj.CPR_traj_mean(run_case).leftout,...
%             sparse2_traj.CPA_traj_MC(run_case).leftout,...
%             sparse2_traj.CPA_traj_mean(run_case).leftout);
        
        % Multi-fidelity (AVL+CFD+WT) dataset
        generate_trajectory_plots(full_mf3d_traj.CPR_traj_MC(run_case).normal,...
            full_mf3d_traj.CPR_traj_mean(run_case).normal,...
            full_mf3d_traj.CPA_traj_MC(run_case).normal,...
            full_mf3d_traj.CPA_traj_mean(run_case).normal);
%         generate_trajectory_plots(mf3d_traj.CPR_traj_MC(run_case).rightout,...
%             mf3d_traj.CPR_traj_mean(run_case).rightout,...
%             mf3d_traj.CPA_traj_MC(run_case).rightout,...
%             mf3d_traj.CPA_traj_mean(run_case).rightout);
%         generate_trajectory_plots(mf3d_traj.CPR_traj_MC(run_case).leftout,...
%             mf3d_traj.CPR_traj_mean(run_case).leftout,...
%             mf3d_traj.CPA_traj_MC(run_case).leftout,...
%             mf3d_traj.CPA_traj_mean(run_case).leftout);
        
    case 3 %Sample size
        
        % Full wind tunnel dataset
        generate_sample_size_plots(full_metrics_MC(run_case),full_metrics_mean(run_case));
        
        % AVL dataset 4
%         generate_sample_size_plots(avl4_metrics_MC(run_case),avl4_metrics_mean(run_case));
        
        % Multi-fidelity (AVL+CFD) dataset
%         generate_sample_size_plots(mf2d_metrics_MC(run_case),mf2d_metrics_mean(run_case));
        
        % Sparse WT dataset 2
%         generate_sample_size_plots(sparse2_metrics_MC(run_case),sparse2_metrics_mean(run_case));
        
        % Multi-fidelity (AVL+CFD+WT) dataset
%         generate_sample_size_plots(mf3d_metrics_MC(run_case),mf3d_metrics_mean(run_case));
        
    case 4 %Compare multipliers
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
        plot_options.axes_line_width = 2.0;
        setup_plots(plot_options);
        disp('AVL')
        reo_perf_metric_plots_single(avl4_metrics_MC(run_case),avl4_metrics_mean(run_case),avl4_ctrl_MC(run_case),avl4_ctrl_mean(run_case))
        metric_names = {'pitch','roll','yaw'};
        for i = 1:3
            mn = metric_names{i};
            figure(i)
            legend('AVL','location','northwest')
            saveas(gcf,['images/reo_',mn,'_1f_avl.png']);
        end
        disp('AVL+SU2')
        reo_perf_metric_plots_single(mf2d_metrics_MC(run_case),mf2d_metrics_mean(run_case),mf2d_ctrl_MC(run_case),mf2d_ctrl_mean(run_case))
        for i = 1:3
            mn = metric_names{i};
            figure(i)
            legend('AVL','AVL+SU2','location','northwest')
            saveas(gcf,['images/reo_',mn,'_2f.png']);
        end
        disp('AVL+SU2+WT')
        reo_perf_metric_plots_single(full_mf3d_metrics_MC(run_case),full_mf3d_metrics_mean(run_case),full_mf3d_ctrl_MC(run_case),full_mf3d_ctrl_mean(run_case))
        for i = 1:3
            mn = metric_names{i};
            figure(i)
            b = gca; legend(b,'off');
            legend('AVL','AVL+SU2','AVL+SU2+WT','location','northwest');
            saveas(gcf,['images/reo_',mn,'_3f.png']);
        end
        
        disp('WT')
        reo_perf_metric_plots_single(full_metrics_MC(run_case),full_metrics_mean(run_case),full_ctrl_MC(run_case),full_ctrl_mean(run_case))
        for i = 1:3
            mn = metric_names{i};
            figure(i)
            b = gca; legend(b,'off');
            h = get(gca,'children');
            set(h(1),'color','k')
            legend('AVL','AVL+SU2','AVL+SU2+WT','WT','location','northwest');
            saveas(gcf,['images/reo_',mn,'_1f_wt.png']);
        end
%         % Only have data for case 15
%         %   Compares Monte Carlo results if the GP variance was scaled by a factor
%         %   of 2x.
%         generate_multiplier_comparison_plots(perf_metrics_MC(1),perf_metrics_MC2(1),perf_metrics_mean(1));
        
    case 5 %CDF and mean
        % %%%%% USE THIS VERSION IF YOU'RE DOING "FULL" WT DATA %%%%%%
%         % Full wind tunnel dataset vs AVL vs Multi-fidelity (AVL+CFD) dataset
%         generate_comparison_plots_all(full_metrics_MC(run_case),avl4_metrics_MC(run_case),mf2d_metrics_MC(run_case),full_metrics_mean(run_case),avl4_metrics_mean(run_case),mf2d_metrics_mean(run_case));
        
%         % Full wind tunnel dataset vs Sparse WT dataset 2 vs Multi-fidelity (AVL+CFD) dataset
%         generate_comparison_plots_all(full_metrics_MC(run_case),sparse2_metrics_MC(run_case),mf2d_metrics_MC(run_case),full_metrics_mean(run_case),sparse2_metrics_mean(run_case),mf2d_metrics_mean(run_case));

        % Full wind tunnel dataset vs AVL vs Multi-fidelity (AVL+CFD) dataset
%         generate_ctrl_plots_all(full_ctrl_MC(run_case),     avl4_ctrl_MC(run_case),     mf2d_ctrl_MC(run_case),     mf3d_ctrl_MC(run_case),     sparse2_ctrl_MC(run_case),...
%                                 full_ctrl_mean(run_case),   avl4_ctrl_mean(run_case),   mf2d_ctrl_mean(run_case),   mf3d_ctrl_mean(run_case),   sparse2_ctrl_mean(run_case));
      % Full wind tunnel dataset vs AVL vs Multi-fidelity (AVL+CFD) dataset with reduced deflection limits
        reo_perf_metric_plots_sf_vs_mf(full_metrics_MC(run_case),     avl4_metrics_MC(run_case),   mf2d_metrics_MC(run_case),   full_mf3d_metrics_MC(run_case),   sparse2_metrics_MC(run_case),...
                                         full_metrics_mean(run_case),   avl4_metrics_mean(run_case), mf2d_metrics_mean(run_case), full_mf3d_metrics_mean(run_case), sparse2_metrics_mean(run_case),...
                                         full_ctrl_MC(run_case),        avl4_ctrl_MC(run_case),      mf2d_ctrl_MC(run_case),      full_mf3d_ctrl_MC(run_case),      sparse2_ctrl_MC(run_case),...
                                         full_ctrl_mean(run_case),      avl4_ctrl_mean(run_case),    mf2d_ctrl_mean(run_case),    full_mf3d_ctrl_mean(run_case),    sparse2_ctrl_mean(run_case));
        generate_trim_comparison_plots_sf_vs_mf(full_trim_MC(run_case),avl4_trim_MC(run_case),mf2d_trim_MC(run_case),full_mf3d_trim_MC(run_case),sparse2_trim_MC(run_case),...
                                                full_trim_mean(run_case),avl4_trim_mean(run_case),mf2d_trim_mean(run_case),full_mf3d_trim_mean(run_case),sparse2_trim_mean(run_case));

%         % Sparse wind tunnel dataset 2 vs AVL vs Multi-fidelity (AVL+CFD) dataset with reduced deflection limits
%         regenerate_perf_metric_plots_all(sparse2_metrics_MC(run_case),avl4_metrics_MC(run_case),mf2d_metrics_MC(run_case),mf3d_metrics_MC(run_case),sparse2_metrics_mean(run_case),avl4_metrics_mean(run_case),mf2d_metrics_mean(run_case),mf3d_metrics_mean(run_case));
        
    case 6 % compare reduced data sims
        reo_perf_metric_plots_reduced_data(full_mf3d_metrics_MC(run_case),     sparse2_metrics_MC(run_case),   full_mf3d_metrics_MC(run_case),   sparse_mf3d_metrics_MC(run_case),   local_mf3d_metrics_MC(run_case),...
                                         full_mf3d_metrics_mean(run_case),   sparse2_metrics_mean(run_case), full_mf3d_metrics_mean(run_case), sparse_mf3d_metrics_mean(run_case), local_mf3d_metrics_mean(run_case),...
                                         full_mf3d_ctrl_MC(run_case),        sparse2_ctrl_MC(run_case),      full_mf3d_ctrl_MC(run_case),      sparse_mf3d_ctrl_MC(run_case),      local_mf3d_ctrl_MC(run_case),...
                                         full_mf3d_ctrl_mean(run_case),      sparse2_ctrl_mean(run_case),    full_mf3d_ctrl_mean(run_case),    sparse_mf3d_ctrl_mean(run_case),    local_mf3d_ctrl_mean(run_case));
        generate_trim_comparison_plots_reduced_data(full_mf3d_trim_MC(run_case),sparse2_trim_MC(run_case),full_mf3d_trim_MC(run_case),sparse_mf3d_trim_MC(run_case),local_mf3d_trim_MC(run_case),...
                                                full_mf3d_trim_mean(run_case),sparse2_trim_mean(run_case),full_mf3d_trim_mean(run_case),sparse_mf3d_trim_mean(run_case),local_mf3d_trim_mean(run_case));
        % Full wind tunnel dataset vs AVL dataset 4 vs Multi-fidelity (AVL+CFD) dataset
%         generate_trim_comparison_plots_sf_vs_mf(full_trim_MC(run_case),avl4_trim_MC(run_case),mf2d_trim_MC(run_case),full_mf3d_trim_MC(run_case),sparse2_trim_MC(run_case),full_trim_mean(run_case),avl4_trim_mean(run_case),mf2d_trim_mean(run_case),full_mf3d_trim_mean(run_case),sparse2_trim_mean(run_case));
        
%         % Sparse wind tunnel dataset 2 vs AVL dataset 4 vs Multi-fidelity (AVL+CFD) dataset
%         generate_trim_comparison_plots_all(sparse2_trim_MC(run_case),avl4_trim_MC(run_case),mf2d_trim_MC(run_case),mf3d_trim_MC(run_case),sparse2_trim_mean(run_case),avl4_trim_mean(run_case),mf2d_trim_mean(run_case),mf3d_trim_mean(run_case));
        
%         % Full wind tunnel dataset vs AVL dataset 4 vs Multi-fidelity (AVL+CFD) dataset
%         generate_trim_comparison_plots_all(full_trim_MC(run_case),avl4_trim_MC(run_case),sparse2_trim_MC(run_case),full_trim_mean(run_case),avl4_trim_mean(run_case),sparse2_trim_mean(run_case));
    case 7
        bootstrap_perf_metric_plots(full_metrics_MC(run_case),     avl4_metrics_MC(run_case),   mf2d_metrics_MC(run_case),   full_mf3d_metrics_MC(run_case),   sparse2_metrics_MC(run_case),...
                                         full_metrics_mean(run_case),   avl4_metrics_mean(run_case), mf2d_metrics_mean(run_case), full_mf3d_metrics_mean(run_case), sparse2_metrics_mean(run_case),...
                                         full_ctrl_MC(run_case),        avl4_ctrl_MC(run_case),      mf2d_ctrl_MC(run_case),      full_mf3d_ctrl_MC(run_case),      sparse2_ctrl_MC(run_case),...
                                         full_ctrl_mean(run_case),      avl4_ctrl_mean(run_case),    mf2d_ctrl_mean(run_case),    full_mf3d_ctrl_mean(run_case),    sparse2_ctrl_mean(run_case));
end
   
