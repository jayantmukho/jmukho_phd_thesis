function [Mu,Q] = Kennedy_scaling(hyp,hyp_tot,x_meas, y, sigma,x_samp,covfunc,mf_type,order)
% Created by Andrew Wendorff and Brian Whitehead based on the work by
% Kennedy and O'Hagan (2000)
% Inputs:
% x_meas  - 1 by number of fidelity levels cell containing the flight 
%           conditions for the number of fidelity levels considered where 
%           each different fidelity level can have a arbitrary number of 
%           data points
%           
% y       - 1 by number of fidelity levels cell containing aerodynamic 
%           coefficients of interest for the number of fidelity levels 
%           considered where each different fidelity level can have an 
%           arbitrary number of data points
%
% sigma   - 1 by number of fidelity levels cell containing the externally 
%           provided error estimate of the aerodynamic coefficient provided
%           by y where the length of vector inside the cell of sigma and y 
%           must match
%
% x_samp  - Sample points of interest (number of data points considered by
%           number of dimensions)
%
% covfunc - covariance function to be utilized over the domain
% Outputs: 
% Mu      - Mean (best estimate) of the multi-fidelity Gaussian Process
%           model at the sample points of interest
% Q       - Cholesky Decompositon of the scaled covariance function at the
%           sample points

n = length(hyp);
nD  = size(x_samp,2); % dimension of the domain

% Creating Zero vectors for the number of samples to be drawn
Var_sum_n = zeros(length(x_samp),1);

% Outputs to Command Window if set equal to 1
msgs_on     = 0;

for i = 1:n;
    if msgs_on
        disp(sprintf('Begin processing Fidelity %d',i))
    end 
    if strcmp(mf_type,'gratiet')
        [Mu_n{i},K]     = get_Mu_K_MF_gratiet({x_meas{i}},{y{i}},x_samp,...
            x_samp,hyp_tot(i),covfunc,order);
        Var_n{i}        = diag(K);
    elseif strcmp(mf_type,'kennedy')
        [Mu_n{i},Q]     = get_Mu_Q_MF({x_meas{i}},{y{i}},x_samp,...
            hyp_tot(i),covfunc);
        Var_n{i}        = diag(Q*Q');
    else
        error('Invalid Multi-Fidelity framework specified');
    end
       
    % Linear interpolation of the sample noise to be added to the variance
    % from the model 
    switch nD
        case 1
            sig_vec_interp  = interp1(x_meas{i},sigma{i},x_samp,'linear',NaN);
            inds_nan            = find(isnan(sig_vec_interp));
            if any(inds_nan)
                % A little complex to handle the case of non-monotonic
                % input
                [max_x,max_ind]     = max(x_meas{i});
                inds_to_update      = find(x_samp>=max_x);
                sig_vec_interp(inds_to_update) = sigma{i}(max_ind);
                
                [min_x,min_ind]     = min(x_meas{i});
                inds_to_update      = find(x_samp<=min_x);
                sig_vec_interp(inds_to_update) = sigma{i}(min_ind);
            end % if
        case 2
            % Use linear interpolation.  No Extrapolation (will return NaN)
            %sig_vec_interp  = scatteredInterpolant(x_meas{i},sigma{i},x_samp,'linear','none');
            F = scatteredInterpolant(x_meas{i}(:,1),x_meas{i}(:,2),sigma{i},'linear','none');
            sig_vec_interp      = F(x_samp);
            inds_nan            = find(isnan(sig_vec_interp));
            if any(inds_nan)
                inds_nearest    = dsearchn(x_meas{i},delaunayn(x_meas{i}),x_samp(inds_nan,:));
                sig_vec_interp(inds_nan)  = sigma{i}(inds_nearest);
            end % if
        case 3
            % Use linear interpolation.  No Extrapolation (will return NaN)
            F = scatteredInterpolant(x_meas{i}(:,1),x_meas{i}(:,2),x_meas{i}(:,3),sigma{i},'linear','none');
            sig_vec_interp  = F(x_samp);
            sig_vec_interp      = F(x_samp);
            inds_nan            = find(isnan(sig_vec_interp));
            if any(inds_nan)
                inds_nearest    = dsearchn(x_meas{i},delaunayn(x_meas{i}),x_samp(inds_nan,:));
                sig_vec_interp(inds_nan)  = sigma{i}(inds_nearest);
            end % if
        otherwise
            warning('Sigma interpolation unavailable for nD>3; Setting to zero')
            sig_vec_interp = 0*Var_n{i};
    end
%     sig_vec_interp  = inpaint_nans(sig_vec_interp,4);

    % Adding independent variance terms together to be used in the final 
    % scaling in order to maintain correlation among representative outputs
    Var_sum_n = 1./(Var_n{i} + (sig_vec_interp.^2)) + Var_sum_n;
    
    % Add covariance terms to create covariance cell needed for the
    % multi-fidelity model
    covfunc2{i} = covfunc;
end

% Methodology to take the learned hyper-parameters and combine additive
% models together to generate the multi-fidelity Gaussian Process mean and
% Cholesky decomposed covariance matrix
if strcmp(mf_type,'gratiet')
    [Mu,K_post]  = get_Mu_K_MF_gratiet(x_meas,y,x_samp,x_samp,hyp,covfunc,order);
    K_post      = fix_K_eigval(K_post);
    Q = chol(K_post,'lower');
elseif strcmp(mf_type,'kennedy')
    [Mu,Q]  = get_Mu_Q_MF(x_meas,y,x_samp,hyp,covfunc);
else
    error('Invalid Multi-Fidelity framework specified');
end
Var     = diag(Q*Q');
% Scaling the Cholesky matrix to account for the different fidelity level
% uncertainty estimates
Q       = diag(sqrt(1./(Var.*Var_sum_n)))*Q;

