function [Mu,Q] = get_Mu_Q_MF(x,y,x_samp,hyp,covfunc)
% Created by Brian Whitehead and Andrew Wendorff
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

K               = zeros(nx,nx);   % Initilize the prior
n_vec           = zeros(n_fid,1); % vector of sample lengths
inds_vec        = zeros(n_fid,2); % matrix of sample indices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build the prior covariance and do some other pre-processing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ii = 1:n_fid
    fit_cov     = @(x,z)  feval(covfunc,hyp{ii}.cov, x, z);
    K           = K + get_kern_mat(x_samp,x_samp,fit_cov);% nx x nx
    
    n_vec(ii)   = length(x{ii});  % n_vec(ii) is number of samples of ii-fidelity
    
    % inds_vec(ii,:) provides indices corresponding to the ii-th fidelity
    if ii == 1
        inds_vec(ii,:) = [1,n_vec(ii)];
    else
        prev_end       = inds_vec(ii-1,2);
        inds_vec(ii,:) = prev_end + [1,n_vec(ii)];
    end %if
    
    % If the ii-th fidelity noise is a scalar, make a vector of appropriate
    % length
    if length(hyp{ii}.lik) == 1
        hyp{ii}.lik     = hyp{ii}.lik*ones(n_vec(ii),1);
    end % if
    
end % ii

% Build the aggregate measurement vector
y_meas      = zeros(sum(n_vec),1);
for ii = 1:n_fid
    inds_sel = inds_vec(ii,1):inds_vec(ii,2);
    y_meas(inds_sel) = y{ii}(:);
end % ii

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build K_meas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First the diagonals
K_meas      = zeros(sum(n_vec),sum(n_vec));
for ii = 1:n_fid
    this_x      = x{ii};
    K_inds      = inds_vec(ii,1):inds_vec(ii,2);
    for jj = 1:ii
        fit_cov                 = @(x,z)  feval(covfunc,hyp{jj}.cov, x, z);
        K_meas(K_inds,K_inds)   = K_meas(K_inds,K_inds) + get_kern_mat(this_x,this_x,fit_cov) ; % n x n
    end % jj
    % Noise gets added once
    K_meas(K_inds,K_inds)       = K_meas(K_inds,K_inds) + diag(exp(hyp{ii}.lik).^2); 
end % ii

% Next the measurement cross correlations
for ii = 1:n_fid
    K_inds_1        = inds_vec(ii,1):inds_vec(ii,2);
    for jj = (ii+1):n_fid        
        K_inds_2        = inds_vec(jj,1):inds_vec(jj,2);
        
        K_cross_ii_jj   = zeros(length(K_inds_1),length(K_inds_2));
        for kk = 1:(min(ii,jj))
            fit_cov         = @(x,z)  feval(covfunc,hyp{kk}.cov, x, z);
            K_cross_ii_jj   = K_cross_ii_jj + get_kern_mat(x{ii},x{jj},fit_cov);
        end        
        K_meas(K_inds_1,K_inds_2)  = K_cross_ii_jj;
        K_meas(K_inds_2,K_inds_1)  = K_cross_ii_jj';  % By symmetry of K_meas
    end %jj
end % ii

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build K_cross
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K_cross     = zeros(nx,sum(n_vec));
inds_1      = 1:nx;
for ii = 1:n_fid
    this_x  = x{ii};
    inds_2  = inds_vec(ii,1):inds_vec(ii,2);
    for jj = 1:ii
        fit_cov     = @(x,z)  feval(covfunc,hyp{jj}.cov, x, z);
        K_inc       = get_kern_mat(x_samp,this_x,fit_cov); % nx x n
        K_cross(inds_1,inds_2) = K_cross(inds_1,inds_2) + K_inc;
    end % jj
end % ii       

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the Posterior Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Covariance
K_post      = K - K_cross/K_meas*K_cross';
K_post      = fix_K_eigval(K_post);

% Bias; This would have to be re-written to accommodate general basis
% functions
h           = 1;
H           = repmat(h,sum(n_vec),1);
% b_hat       = inv(H'*inv(K_meas)*H)*H'*inv(K_meas)*y_meas;
b_hat       = (H'*(K_meas\H))\H'*(K_meas\y_meas);


Mu          = b_hat +  (K_cross/K_meas)*(y_meas - H*b_hat);
Q           = chol(K_post,'lower');