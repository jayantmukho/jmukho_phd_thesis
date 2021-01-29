function [case_num] = identify_most_aggressive(file_str)
%Identify the most aggressive successful run

% Load dataset
[NUM,TXT,RAW] = xlsread(file_str);

% Extract vectors of metrics
pitch_metric = NUM(27,:);
roll_metric = NUM(28,:);
yaw_metric = NUM(29,:);

% Find the indices > 0 for each metric
pitch_idx = min(find(pitch_metric>0));
roll_idx = min(find(roll_metric>0));
yaw_idx = min(find(yaw_metric>0));

% Min idx of all three
case_num = max([pitch_idx,roll_idx,yaw_idx]);

end

