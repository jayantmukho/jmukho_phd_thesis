function [H] = basis_functions(x_samp,order)
% Created by Jayant Mukhopadhaya
% Function returns the basis matrix H where the i-th column represents the 
% i-th order Hermite polynomial evaluated at x_samp locations
% Inputs:
% x_samp - sample locations to evaluate the basis functions
% order  - order of polynomial to use
% 
% Outputs:
% H      - a size(x_samp,1) x order matrix

H = zeros(length(x_samp),order);
polyHermite = {@(x) ones(length(x),1);
    @(x) (x) ;
    @(x) (x.^2 -1);
    @(x) (x.^3 - 3.*x);
    @(x) (x.^4 - 6.*x.^2 + 3);
    @(x) (x.^5 - 10.*x.^3 + 15.*x)};

for i = 1:order+1
    H(:,i) = sum(polyHermite{i}(x_samp),2);
end

end