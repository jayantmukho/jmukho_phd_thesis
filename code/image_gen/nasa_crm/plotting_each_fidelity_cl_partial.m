clear variables
close all
run('data/organize_crm_data.m')
load('data/GP_3F_CRM_Data.mat')
WT_Mach85 = filtering_data(WT_Mach85,.5);
AVL_Mach85= filtering_data(AVL_Mach85,.5);
mf_type = 'gratiet';
cov_scaling = 0;
expand_hf   = 'yes';
axis_range = [-5 15 -.4 1.2];

%% Organize the data
allAlpha            = [AVL_Mach85.alpha; SU2_Mach85_uq.alpha; WT_Mach85.alpha];
x_samp              = linspace(min(allAlpha),max(allAlpha),400)';
ind_to_keep         = [];
skip                = 6;
AVL_ind             = 1:length(AVL_Mach85.alpha);
WT_ind              = find(WT_Mach85.alpha > 5);
WT_ind_inv          = find(WT_Mach85.alpha < 5);

%% 3F

my_GP           = MF_GP;
my_GP           = my_GP.add_data(AVL_Mach85.alpha(AVL_ind),AVL_Mach85.CL(AVL_ind),AVL_Mach85.CL_sig(AVL_ind));
my_GP           = my_GP.add_data(SU2_Mach85_uq.alpha,SU2_Mach85_uq.CL,SU2_Mach85_uq.CL_sig);
my_GP           = my_GP.add_data(WT_Mach85.alpha(WT_ind),WT_Mach85.CL(WT_ind),WT_Mach85.CL_sig(WT_ind));
my_GP.x_labs    = 'Alpha [deg]';
my_GP.y_lab     = '$C_L$';
my_GP.mf_type   = mf_type;
my_GP.cov_scaling = cov_scaling;
% my_GP.ci_algo   = 1;

my_GP.expand_hf = expand_hf;

% Fit the GP
my_GP           = my_GP.Process;

figure(1); clf;
% subplot(1,3,3)
my_GP.plot_GP_1D_slice(x_samp,x_samp)
hold on
my_GP.plot_input_data
errorbar(WT_Mach85.alpha(WT_ind_inv),WT_Mach85.CL(WT_ind_inv),2*WT_Mach85.CL_sig(WT_ind_inv),...
    'k*','LineWidth',2,'MarkerSize',10);
xlabel('$\alpha$')
ylabel('$C_L$')
plots = get(gca,'children');
legend([plots(4) plots(3) plots(2) plots(5) plots(6) plots(1)],'AVL Data','SU2 Data','WT Data','GP Mean','$2\sigma$','Unused WT Data','Location','southeast')

axis square
axis(axis_range)
% set(gcf,'position',[500 100 560 540]);

%% Only HF
my_GP           = MF_GP;
% my_GP           = my_GP.add_data(AVL_Mach85.alpha(AVL_ind),AVL_Mach85.CL(AVL_ind),AVL_Mach85.CL_sig(AVL_ind));
% my_GP           = my_GP.add_data(SU2_Mach85_uq.alpha,SU2_Mach85_uq.CL,SU2_Mach85_uq.CL_sig);
my_GP           = my_GP.add_data(WT_Mach85.alpha(WT_ind),WT_Mach85.CL(WT_ind),WT_Mach85.CL_sig(WT_ind));
my_GP.x_labs    = 'Alpha [deg]';
my_GP.y_lab     = '$C_L$';
my_GP.mf_type   = mf_type;
my_GP.cov_scaling = cov_scaling;
% my_GP.ci_algo   = 1;

% my_GP.expand_hf = 'yes';

% Fit the GP
my_GP           = my_GP.Process;

figure(2); clf;
my_GP.plot_GP_1D_slice(x_samp,x_samp)
hold on
colorOrder = get(gca,'colororder');

errorbar(WT_Mach85.alpha(WT_ind),WT_Mach85.CL(WT_ind),2*WT_Mach85.CL_sig(WT_ind),...
    'x','LineWidth',2,'MarkerSize',10,'color',colorOrder(4,:));

errorbar(WT_Mach85.alpha(WT_ind_inv),WT_Mach85.CL(WT_ind_inv),2*WT_Mach85.CL_sig(WT_ind_inv),...
    'k*','LineWidth',2,'MarkerSize',10);
xlabel('$\alpha$')
ylabel('$C_L$')

plots = get(gca,'children');
legend([plots(2) plots(3) plots(4) plots(1)],'WT Data','GP Mean','$2\sigma$','Unused WT Data','Location','southeast')
axis square
axis(axis_range)
% set(gcf,'position',[480 100 560 540]);

%% All HF
WT_ind              = 1:length(WT_Mach85.alpha);
my_GP           = MF_GP;
my_GP           = my_GP.add_data(WT_Mach85.alpha(WT_ind),WT_Mach85.CL(WT_ind),WT_Mach85.CL_sig(WT_ind));
my_GP.x_labs    = 'Alpha [deg]';
my_GP.y_lab     = '$C_L$';
my_GP.mf_type   = mf_type;
my_GP.cov_scaling = cov_scaling;
% my_GP.ci_algo   = 1;

% my_GP.expand_hf = 'yes';

% Fit the GP
% my_GP           = my_GP.Process;

figure(3); clf;
% subplot(1,3,3)
% my_GP.plot_input_data('x')
WT_ind              = find(WT_Mach85.alpha <= 5);
errorbar(WT_Mach85.alpha(WT_ind),WT_Mach85.CL(WT_ind),2*WT_Mach85.CL_sig(WT_ind),...
    'kx','LineWidth',2,'MarkerSize',10);
hold on
% my_GP.plot_input_data('x')
WT_ind              = find(WT_Mach85.alpha > 5);
errorbar(WT_Mach85.alpha(WT_ind),WT_Mach85.CL(WT_ind),2*WT_Mach85.CL_sig(WT_ind),...
    'x','LineWidth',2,'MarkerSize',10,'color',colorOrder(4,:));
% errorbar(WT_Mach85.alpha(WT_cv),WT_Mach85.CL(WT_cv),2*WT_Mach85.CL_sig(WT_cv),'x','LineWidth',2);
% my_GP.plot_GP_1D_slice(x_samp,x_samp)
xlabel('$\alpha$')
ylabel('$C_L$')
legend('Unused WT Data','Used WT Data','Location','southeast')
axis square
axis(axis_range)
% set(gcf,'position',[460 100 560 540]);

%% Saving Plots

figure(1);
saveas(gcf,'images/cl_3f_partial','png')

figure(2);
saveas(gcf,'images/cl_hf_partial','png')

figure(3);
saveas(gcf,'images/cl_hf_all','png')
