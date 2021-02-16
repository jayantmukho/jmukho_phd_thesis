function [X,Y,sn] = process_wt_data(coeff,varargin)
%PROCESS_WT_DATA Summary of this function goes here
%   Detailed explanation goes here

optargs = {1e-4,0.05};
numvarargs = length(varargin);
if numvarargs > 0
    optargs(1:numvarargs) = varargin;
end
[min_sig,r] = optargs{:};
alpha_low = -5;
alpha_high = 20.5;
beta_low = 0;
defl_low = 0;
inds_alpha = coeff.alphaRange < alpha_high & coeff.alphaRange > alpha_low;

% CTAB
if ~isfield(coeff,'deflRange')
    if ~isfield(coeff,'betaRange')
        X = coeff.alphaRange(inds_alpha);
        Y = coeff.data(inds_alpha);
%         Y = Y + randn(size(Y))*min_sig;
        sn = (max(Y)-min(Y))*r*ones(size(Y));
        sn = max(sn,min_sig);
    else
        X_all = combvec(coeff.alphaRange',coeff.betaRange')';
        Y_all = reshape(coeff.data,[],1);
        inds = (X_all(:,1) > alpha_low | abs(X_all(:,2)) > beta_low) ...
              & X_all(:,1) < alpha_high;
        X = X_all(inds,:);
        Y = Y_all(inds);
%         Y = Y + randn(size(Y))*min_sig;    
        sn = (max(Y)-min(Y))*r*ones(size(Y));
        sn = max(sn,min_sig);
        
    end
% CTRL
else
    if ~isfield(coeff,'betaRange')
        X_all = combvec(coeff.alphaRange',coeff.deflRange')';
        Y_all = reshape(coeff.data,[],1);
        inds = (X_all(:,1) > alpha_low | abs(X_all(:,2)) > defl_low) ...
              & X_all(:,1) < alpha_high;
        
%         inds_defl = find(abs(coeff.deflRange) > defl_low);
        defl = unique(X_all(:,2));
        % Calculate sigma values based on each deflection angle
        sn_all = zeros(length(Y_all),1);
        for j = 1:length(defl)
            Y_curr = Y_all(X_all(:,2) == defl(j));
            sn_curr = (max(Y_curr)-min(Y_curr))*r*ones(size(Y_curr));
            sn_curr = max(sn_curr,min_sig);
            sn_all(X_all(:,2) == defl(j)) = sn_curr;
        end
        X = X_all(inds,:);
        Y = Y_all(inds);
%         Y = Y + randn(size(Y))*min_sig;
        sn = sn_all(inds);

    else
        X_all = combvec(coeff.alphaRange',coeff.betaRange',coeff.deflRange')';
        Y_all = reshape(coeff.data,[],1);
        inds = (X_all(:,1) > alpha_low ...
              | abs(X_all(:,2)) >= beta_low ...
              | abs(X_all(:,3)) >= defl_low) ...
              & X_all(:,1) < alpha_high;
        
        defl = unique(X_all(:,3));
        % Calculate sigma values based on each deflection angle
        sn_all = zeros(length(Y_all),1);
        for j = 1:length(defl)
            Y_curr = Y_all(X_all(:,3) == defl(j));
            sn_curr = (max(Y_curr)-min(Y_curr))*r*ones(size(Y_curr));
            sn_curr = max(sn_curr,min_sig);
            sn_all(X_all(:,3) == defl(j)) = sn_curr;
        end
        X = X_all(inds,:);
        Y = Y_all(inds);
%         Y = Y + randn(size(Y))*min_sig;
        sn = sn_all(inds);

    end
end

end

