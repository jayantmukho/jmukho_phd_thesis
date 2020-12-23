function K = get_kern_mat(x,y,fit_cov)
% Created by Brian Whitehead and Andrew Wendorff
% Function calculates the correlation using the defined kernel between
% different two set of locations in the domain
% Input:
% x - Vector of locations in the domain
% y - Separate vector of locations in the domain
% fit_cov - Function that evaluates the covariance between two defined 
%           locations

% Output:
% K - Covariance matrix containing all the covariance values between the
% defined locations
nx          = length(x);
ny          = length(y);
K           = zeros(nx,ny);

K    = fit_cov(x,y);
