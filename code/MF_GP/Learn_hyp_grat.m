function [hyp_new] = Learn_hyp_grat(x_low, y_low, sigma_low,covfunc,init_guess,hyp,order)
% Created by Andrew Wendorff and Brian Whitehead
% Function conducts the optimization to train the hyper-parameters by
% minimizing the negative of the log likelihood.
% Inputs:
% x_low - Vector of data locations
% y_low - Vector of corresponding outputs 
% sigma_low - Vector of externally provided error term corresponding to 
%             each output
% covfunc - Term containing the covariance kernel to be used
% init_guess - initial guess for hyperparameters
% hyp - hyperparameters for all fidelity levels lower than current one
% order      - polynomial order for regression functions for bias terms 
%              [additive; multiplicative]
% Outputs: 
% hyp_new - Contains both the spatial covaraince (hyp_new.cov) and
%           natural variation parameter (hyp_new.lik).

% Training Hyperparameters with sigma_n^2(x)
f = @(u)f_var_sigma_n_mf(x_low,y_low,sigma_low,u,covfunc,hyp,order); % Defining function for training the hyper-parameters
% Providing initial conditions for the hyper-parameters
dim = size(x_low{end},2);
x0(1:dim) = log(init_guess.ell);
x0(dim+1) = log(init_guess.sig); 
% Running the optimization to train the hyper-parameters
% options = optimset('MaxFunEvals',1000);
[hyp,~] = fminsearch(f,x0);
hyp_new.cov(1:dim) = hyp(1:dim);
hyp_new.cov(dim+1) = hyp(dim+1);
hyp_new.lik = log(sigma_low);
% Output the single fidelity model using the learned hyper-parameters
% [Mu,Q] = get_Mu_Q_MF({x_low},{y_low},x_samp,{hyp_new},{covfunc});
% Var = diag(Q*Q');




