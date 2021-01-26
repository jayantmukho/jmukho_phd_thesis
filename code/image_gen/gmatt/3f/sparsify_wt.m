function [ctab,ctrl] = sparsify_wt(ctab,ctrl)

ctab_coeffs = fieldnames(ctab);
ctrl_coeffs = fieldnames(ctrl);

%% Make the dataset sparser
% Indices for Rigid-body coefficients
CTAB_alpha_idx = [1,... %-3.9365
    3,... %0.2628
    5,... %4.4547
    7,... %8.6278
    11,... %12.7072
    15,... %16.7284
    19,... %20.7305
    21,... %24.7979
    23,... %28.8697
    25,... %35.9758
    27,... %46.0606
    29]; %56.0979

CTAB_beta_idx = [1,... %-20.0179
    3,... %-10.01
    4,... %-4.005
    7,... %0
    10,... %4.003
    11,... %10.01
    13]; %20.0211

%Indices for dynamic derivatives
CTAB_deriv_alpha_idx = [1,... %-3.9725
    2,... %0
    4,... %4
    6,... %8
    8,... %12
    10,... %16
    12,... %19.8587
    15,... %25.8358
    18,... %34.7958
    20]; %49.7887

% Indices for control derivatives
CTRL_alpha_idx = [1,... %-3.9365
    3,... %0.2288
    5,... %4.4140
    7,... %8.6157
    10,... %11.6577
    14,... %15.6972
    18]; %19.7162

% % Create new dataset with sparse datapoints
% ctab_new = ctab;
%
% % Sparisfy the lookup tables
% ctab_new.CLTAB.data = ctab_new.CLTAB.data(CTAB_alpha_idx,CTAB_beta_idx);
% ctab_new.CLTAB.alphaRange = ctab_new.CLTAB.alphaRange(CTAB_alpha_idx);

% Sparsify the datapoints
for i=1:length(ctab_coeffs)
    coeff = ctab.(ctab_coeffs{i});
    fields = fieldnames(coeff);
    fprintf('Sparsifying GP for %s... ',ctab_coeffs{i});
    if ~isfield(coeff,'betaRange') %1D function (dynamic derivatives)
        ctab.(ctab_coeffs{i}).data = ctab.(ctab_coeffs{i}).data(CTAB_deriv_alpha_idx);
        ctab.(ctab_coeffs{i}).alphaRange = ctab.(ctab_coeffs{i}).alphaRange(CTAB_deriv_alpha_idx);
    else %2D function
        ctab.(ctab_coeffs{i}).data = ctab.(ctab_coeffs{i}).data(CTAB_alpha_idx,CTAB_beta_idx);
        ctab.(ctab_coeffs{i}).alphaRange = ctab.(ctab_coeffs{i}).alphaRange(CTAB_alpha_idx);
        ctab.(ctab_coeffs{i}).betaRange = ctab.(ctab_coeffs{i}).betaRange(CTAB_beta_idx);
    end
    fprintf(' Done\n');
end
for i=1:length(ctrl_coeffs)
    coeff = ctrl.(ctrl_coeffs{i});
    fields = fieldnames(coeff);
    fprintf('Sparsifying GP for %s...',ctrl_coeffs{i});
    if ~isfield(coeff,'betaRange') %2D function
        ctrl.(ctrl_coeffs{i}).data = ctrl.(ctrl_coeffs{i}).data(CTRL_alpha_idx,:);
        ctrl.(ctrl_coeffs{i}).alphaRange = ctrl.(ctrl_coeffs{i}).alphaRange(CTRL_alpha_idx);
    else %3D function
        ctrl.(ctrl_coeffs{i}).data = ctrl.(ctrl_coeffs{i}).data(CTRL_alpha_idx,:,:);
        ctrl.(ctrl_coeffs{i}).alphaRange = ctrl.(ctrl_coeffs{i}).alphaRange(CTRL_alpha_idx);
    end
    fprintf(' Done\n');
end
end