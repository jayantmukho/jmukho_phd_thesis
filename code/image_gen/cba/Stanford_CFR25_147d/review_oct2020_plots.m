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

%% Plot target trajectory results
load('WT_results.mat');
load('WT_trajectory_results.mat');
figs = generate_mean_trajectory_plots(CPR_traj_MC(4).normal,CPR_traj_mean(4).normal,CPA_traj_MC(4).normal,CPA_traj_mean(4).normal);
for i = 1:length(figs)
    figure(figs{i})
    subplot_list = get(figs{i},'children');
    if length(subplot_list)>1
        for j = 1:length(subplot_list)
            subplot(subplot_list(j))
            
            
            grid on
            box on
        end
        continue
    end
    grid on
    box on
end
% Make some alterations
figure(figs{2})
ylim([-10,10])
figure(figs{5})
set(gcf,'Position',[0,0,8,5])
subplot(2,1,1)
ylim([-10,10])
subplot(2,1,2)
ylim([-10,10])

% save figs
saveas(figs{1},'images/case39_target_roll_traj.png')
saveas(figs{2},'images/case39_target_roll_acc.png')
saveas(figs{5},'images/case39_target_ail_defl.png')
figure(figs{1})
plot(CPR_traj_MC(4).normal(1).phi_rad.time,CPR_traj_MC(4).normal(1).phi_rad.values*180/pi,'color','#8C1515','LineWidth',lw);
legend('Target','Simulated')
saveas(figs{1},'images/case39_target+mean_roll_traj.png')


%% Plot the nominal roll maneuver results
% Case 39
close all
figs = generate_std_plots(perf_metrics_MC(4),perf_metrics_mean(4));
saveas(figs{1},'images/case39_pitch_metric.png')
saveas(figs{2},'images/case39_roll_metric.png')
saveas(figs{3},'images/case39_yaw_metric.png')

figs = generate_trajectory_plots(CPR_traj_MC(4).normal,CPR_traj_mean(4).normal,CPA_traj_MC(4).normal,CPA_traj_mean(4).normal);
for i = 1:length(figs)
    figure(figs{i})
    subplot_list = get(figs{i},'children');
    if length(subplot_list)>1
        for j = 1:length(subplot_list)
            subplot(subplot_list(j))
            grid on
            box on
        end
        continue
    end
    grid on
    box on
end
figure(figs{1})
legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
set(legend,'NumColumns',2,'Location','Best');
figure(figs{2})
ylim([-10,10])
figure(figs{5})
set(gcf,'Position',[0,0,8,5])
subplot(2,1,1)
ylim([-10,10])
subplot(2,1,2)
ylim([-10,10])

saveas(figs{1},'images/case39_roll_traj.png')
saveas(figs{2},'images/case39_roll_acc.png')
saveas(figs{5},'images/case39_ail_defl.png')

%% Case 15
close all

figs = generate_std_plots(perf_metrics_MC(1),perf_metrics_mean(1));
saveas(figs{1},'images/case15_pitch_metric.png')
saveas(figs{2},'images/case15_roll_metric.png')
saveas(figs{3},'images/case15_yaw_metric.png')

figs = generate_trajectory_plots(CPR_traj_MC(1).normal,CPR_traj_mean(1).normal,CPA_traj_MC(1).normal,CPA_traj_mean(1).normal);
for i = 1:length(figs)
    figure(figs{i})
    subplot_list = get(figs{i},'children');
    if length(subplot_list)>1
        for j = 1:length(subplot_list)
            subplot(subplot_list(j))
            grid on
            box on
        end
        continue
    end
    grid on
    box on
end

saveas(figs{1},'images/case15_roll_traj.png')
saveas(figs{2},'images/case15_roll_acc.png')
saveas(figs{5},'images/case15_ail_defl.png')

%%
clear all;
close all;
clc;

load('WT_case15_results.mat');
perf_metrics_MC2 = load('WT_case15_results_scale_2x.mat','perf_metrics_MC');
perf_metrics_MC2 = perf_metrics_MC2.perf_metrics_MC;

fs = 18;
lw = 3;
set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)

%%

figure('units','inch','position',[0,0,8,5]); clf; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.roll-0.02);
plot(x1,f1,'LineWidth',lw,'Color','#8C1515');
xlabel('Roll Metric');
ylabel('Cumulative Probability');
xlim([-0.1, 0.3]);
axis square
grid on
saveas(gcf,'images/cdf_example.png')

figure('units','inch','position',[0,0,8,5]); clf; hold on;
histogram(perf_metrics_MC.normal.roll-0.02,10,'FaceColor','#8C1515','FaceAlpha',1.0)
ylim([0,250])
xlabel('Roll Metric');
ylabel('Number of occurances');
xlim([-0.1,0.3])
axis square
grid on
saveas(gcf,'images/histogram_example.png')

figure('units','inch','position',[0,0,8,5]); clf; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.roll);
[f2,x2] = ecdf(perf_metrics_MC2.normal.roll);
plot(x1,f1,'LineWidth',lw,'Color','k');
plot(x2,f2,'LineWidth',lw,'Color','#8C1515','LineStyle','--');
xlabel('Roll Metric');
ylabel('Cumulative Probability');
xlim([-0.1, 0.4]);
axis square
grid on
legend('Normal','Extra Variance','Location','southeast')
saveas(gcf,'images/extra_variance_cdf_example.png')
%%
figure('units','inch','position',[0,0,8,5]); clf; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.roll);
[f2,x2] = ecdf(perf_metrics_MC.rightout.roll);
[f3,x3] = ecdf(perf_metrics_MC.leftout.roll);

plot(x1,f1,'LineWidth',2);
plot(x2,f2,'LineWidth',2);
plot(x3,f3,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--','LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Roll Metric');
ylabel('Cumulative Probability');
legend('Normal','R. Engine Out','L. Engine Out','Location','southeast');
grid on
saveas(gcf,'images/cdf+mean_example.png')

figure('units','inch','position',[0,0,8,5]); clf; hold on;
plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--','LineWidth',lw);
xlabel('Roll Metric');
ylabel('Cumulative Probability');
legend('Normal','R. Engine Out','L. Engine Out','Location','southeast');
grid on
xlim([-0.1 0.5])
saveas(gcf,'images/mean_example.png')
