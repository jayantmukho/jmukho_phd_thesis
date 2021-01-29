% README: this code generates the plots associated with the "Boeing
% Simulation Tools" Word document, particularly the example which shows 
% Monte Carlo trajectories of "standardized" maneuver (option 2).
%   preprocess_flag '1' = Boeing-only: raw data files are loaded and necessary data
%       is extracted for use in the plots.  The extracted data is then
%       saved in a separate, processed .mat file for later use.
%   preprocess_flag '0' = Stanford or Boeing: uses the processed .mat file from above

% Author: Jack Quindlen
% Date: 9/20/2020

clear all;
close all;
clc;


%% Preprocess the data 
preprocess_flag = 0;
if preprocess_flag
    Preprocess_CFR147d_MonteCarlo_example2;
end


%% Compare Monte Carlo results for both engines-operable case
load('data_CFR147d_MonteCarlo_example2_normal.mat');
idx_list = 1:10;

% % Generate plots
% plot_Monte_Carlo_metrics;
pitch_metric_matrix_temp = pitch_metric_matrix;
roll_metric_matrix_temp = roll_metric_matrix;
yaw_metric_matrix_temp = yaw_metric_matrix;


%% Compare Monte Carlo results for right engine out case
load('data_CFR147d_MonteCarlo_example2_rightout.mat');
idx_list = 1:10;

% % Generate plots
% plot_Monte_Carlo_metrics;
pitch_metric_matrix_temp(2,:) = pitch_metric_matrix;
roll_metric_matrix_temp(2,:) = roll_metric_matrix;
yaw_metric_matrix_temp(2,:) = yaw_metric_matrix;


%% Compare Monte Carlo results for left engine out case
load('data_CFR147d_MonteCarlo_example2_leftout.mat');
idx_list = 1:10;

% % Generate plots
% plot_Monte_Carlo_metrics;
pitch_metric_matrix_temp(3,:) = pitch_metric_matrix;
roll_metric_matrix_temp(3,:) = roll_metric_matrix;
yaw_metric_matrix_temp(3,:) = yaw_metric_matrix;

pitch_metric_matrix_temp = pitch_metric_matrix_temp';
roll_metric_matrix_temp = roll_metric_matrix_temp';
yaw_metric_matrix_temp = yaw_metric_matrix_temp';


%% Generate plots
X = categorical({'Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10','Nominal'});
X = reordercats(X,{'Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10','Nominal'});

figure; 
set(gcf,'Position',[589,456,837,420]);
bar(X,pitch_metric_matrix_temp);
set(gca,'FontSize',12,'FontWeight','bold');
ylabel('Pitch Metric');
legend('Normal','R. Engine Out','L. Engine Out','Location','SouthEast');

figure; 
set(gcf,'Position',[589,456,837,420]);
bar(X,roll_metric_matrix_temp);
set(gca,'FontSize',12,'FontWeight','bold');
ylabel('Roll Metric');
legend('Normal','R. Engine Out','L. Engine Out');

figure; 
set(gcf,'Position',[589,456,837,420]);
bar(X,yaw_metric_matrix_temp);
set(gca,'FontSize',12,'FontWeight','bold');
ylabel('Yaw Metric');
legend1 = legend('Normal','R. Engine Out','L. Engine Out');
set(legend1,...
    'Position',[0.296524504276096 0.764446121228949 0.174580628728006 0.141208693692131]);