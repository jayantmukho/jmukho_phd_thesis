function [Mu,Q] = get_Mu_Q_MF_gratiet(x,y,x_samp,hyp,covfunc)
% Created by Brian Whitehead and Jayant Mukhopadhaya
% Function that combines the different trained additive models into the
% unscaled multi-fidelity representation
% Inputs: 
% x - 1 by number of fidelity levels cell containing the flight 
%     conditions for the number of fidelity levels considered where 
%     each different fidelity level can have a arbitrary number of 
%     data points
% y - 1 by number of fidelity levels cell containing aerodynamic 
%     coefficients of interest for the number of fidelity levels 
%     considered where each different fidelity level can have an 
%     arbitrary number of data points
% x_samp  - Sample points of interest (number of data points considered by
%           number of dimensions)
% hyp - Cell array containing each fidelity level of interest where each
%       cell contains the learned hyper-parameters in addition to the error
%       term provided for each data location
% covfunc - Cell array with all the different fidelity levels corresponding
%           covariance kernel functions
%
% Outputs: 
% Mu      - Mean (best estimate) of the multi-fidelity Gaussian Process
%           model at the sample points of interest
% Q       - Cholesky Decompositon of the scaled covariance function at the
%           sample points

% x,y,hyp,covfunc are cell arrays of the same length

n_fid           = length(x);  % num elements in a cell array

nx              = length(x_samp);
Mu_prev_samp    = zeros(nx,1);
Mu_prev_meas    = zeros(length(x{1}),1);
Cov_prev_samp   = zeros(nx,nx);

for ii = 1:n_fid
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Create kernel matrices and perform predictions
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fit_cov     = @(x,z)  feval(covfunc,hyp{ii}.cov, x, z);
    K           = get_kern_mat(x_samp,x_samp,fit_cov);% nx x nx
    K_cross     = get_kern_mat(x_samp,x{ii},fit_cov);
    K_meas      = get_kern_mat(x{ii},x{ii},fit_cov) + diag(exp(hyp{ii}.lik).^2);
    
    K_post      = Cov_prev_samp + K - K_cross/K_meas*K_cross';
    K_post      = fix_K_eigval(K_post);
    
    % h           = 1;
    % H           = repmat(h,length(x{ii}),1);
    H           = ones(length(x{ii}),1);
    H_star      = ones(nx,1);
    b_hat       = (H'*(K_meas\H))\H'*(K_meas\y{ii});
    
    
    Mu          = Mu_prev_samp + H_star.*b_hat +  ...
        (K_cross)/(K_meas)*(y{ii} - Mu_prev_meas - H*b_hat);
    Q           = chol(K_post,'lower');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % If more fidelity levels to go, make a predictions at next level's
    % meaured points
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ii < n_fid
        [Mu_prev_meas, ~]    = get_Mu_Q_MF_gratiet({x{1:ii}},{y{1:ii}},x{ii+1},...
                                {hyp{1:ii}},covfunc);      
        Mu_prev_samp    = Mu;
        Cov_prev_samp   = K_post;
    end % if
    
end % ii