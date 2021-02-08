function [dat] = mid_sig(data)

min_data = min(data')';
max_data = max(data')';
mid_data = min_data + (max_data-min_data)./2;
sig_data = (max_data - mid_data)./2;
dat = [mid_data, sig_data];

end