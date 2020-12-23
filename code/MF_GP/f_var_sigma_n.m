function [Log_p] = f_var_sigma_n(x,y,sigma,u,covfunc)
% Created by Andrew Wendorff and Brian Whitehead
% Produces the negative of the log likelihood used to train the model
% hyper-parameters
% Inputs:
% x - Vector of data sample locations
% y - Vector of corresponding outputs
% sigma - Vector of externally provided error term corresponding to 
% each output
% u - Vector containing the hyper-parameters to be optimized
% covfunc - Term containing the covariance kernel to be used
% Outputs:
% Log_p - Negative of the log likelihood

fit_cov     = @(x,z)  feval(covfunc,u, x, z);
K           = diag(sigma.^2) + get_kern_mat(x,x,fit_cov);% nx x nx
L = chol(K,'lower');
alpha = L'\(L\y);
n = length(x);
% Negative of the log likelihood
Log_p = -(-0.5.*y'*alpha - sum(log(diag(L))) - n/2.*log(2*pi));