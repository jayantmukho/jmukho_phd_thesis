function [hyp,hyp_tot] = get_hyp_params_gratiet(x_meas, y, sigma, covfunc, init_guess,order)
% Created by Jayant Mukhopadhaya and Brian Whitehead based on the work by
% Gratiet (2013)
% Inputs:
% x_meas     - 1 by number of fidelity levels cell containing the flight
%              conditions for the number of fidelity levels considered 
%              where each different fidelity level can have a arbitrary 
%              number of data points.
%
% y          - 1 by number of fidelity levels cell containing aerodynamic
%              coefficients of interest for the number of fidelity levels
%              considered where each different fidelity level can have an
%              arbitrary number of data points
%
% sigma      - 1 by number of fidelity levels cell containing the 
%              externally provided error estimate of the aerodynamic 
%              coefficient provided by y where the length of vector inside 
%              the cell of sigma and y must match
%
% covfunc    - covariance function to be utilized over the domain
%
% init_guess - initial guess for hyperparameters
% 
% order      - polynomial order for regression functions for bias terms 
%              [additive; multiplicative]
% Outputs:
% hyp     - 1 by number of fidelity level cell containing hyperparameters
% for the identified GP models

n = length(x_meas);
hyp = {};

% Outputs to Command Window if set equal to 1
msgs_on     = 0;

for i = 1:n;
    if msgs_on
        disp(sprintf('Begin processing Fidelity %d',i))
    end
    
    % Learning the hyper-parameters of each fidelity level 
    [hyp{i}] = Learn_hyp_grat(x_meas(1:i),y(1:i),sigma{i},covfunc,init_guess,hyp,order);
    hyp_tot{i} = hyp{i};
    
    if msgs_on
        hyp_tot{i}
    end
end