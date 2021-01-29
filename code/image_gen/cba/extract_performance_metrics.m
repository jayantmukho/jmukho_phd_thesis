function [pitch_metric,roll_metric,yaw_metric] = extract_performance_metrics(file_str)
%Identify the most aggressive successful run

% Load dataset
[NUM,TXT,RAW] = xlsread(file_str);

% Extract vectors of metrics
pitch_metric = NUM(27,:);
roll_metric = NUM(28,:);
yaw_metric = NUM(29,:);

end

