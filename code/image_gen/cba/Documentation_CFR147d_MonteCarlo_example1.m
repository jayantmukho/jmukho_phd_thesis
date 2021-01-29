% README: this code generates the plots associated with the "Boeing
% Simulation Tools" Word document, particularly the example which shows 
% Monte Carlo trajectories of the "most aggressive" manuever (option 1).
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
    Preprocess_CFR147d_MonteCarlo_example1;
end


%% Compare Monte Carlo results for both engines-operable case
load('data_CFR147d_MonteCarlo_example1_normal.mat');
idx_list = 1:10;

% Generate plots
plot_Monte_Carlo_traj;


%% Compare Monte Carlo results for right engine out case
load('data_CFR147d_MonteCarlo_example1_rightout.mat');
idx_list = 1:10;

% Generate plots
plot_Monte_Carlo_traj;


%% Compare Monte Carlo results for left engine out case
load('data_CFR147d_MonteCarlo_example1_leftout.mat');
idx_list = 1:10;

% Generate plots
plot_Monte_Carlo_traj;

