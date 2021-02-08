clear variables
close all
run('data/organize_crm_data.m')
load('data/GP_3F_CRM_Data.mat')
WT_Mach85 = filtering_data(WT_Mach85,4);
AVL_Mach85= filtering_data(AVL_Mach85,.5);
mf_type = 'gratiet';
cov_scaling = 0;
axis_range = [-5 15 -1 .5];

%% Organize the data
allAlpha            = [AVL_Mach85.alpha; SU2_Mach85_uq.alpha; WT_Mach85.alpha];
x_samp              = linspace(min(allAlpha),max(allAlpha),400)';
ind_to_keep         = [];
skip                = 6;
AVL_ind             = 1:length(AVL_Mach85.alpha);
WT_ind              = 1:length(WT_Mach85.alpha);

%% Single Fidelity

my_GP           = MF_GP;
my_GP           = my_GP.add_data(AVL_Mach85.alpha(AVL_ind),AVL_Mach85.Cm(AVL_ind),AVL_Mach85.Cm_sig(AVL_ind));
my_GP.x_labs    = 'Alpha [deg]';
my_GP.y_lab     = 'C_m';
my_GP.mf_type   = mf_type;
my_GP.cov_scaling = cov_scaling;

% Fit the GP
my_GP           = my_GP.Process;

% Plotting
figure(1); clf;
c = get(gca,'colororder');
my_GP.plot_GP_1D_slice(x_samp,x_samp)
hold on
my_GP.plot_input_data
xlabel('\alpha')
ylabel('C_m')
plots = get(gca,'children');
legend(plots,'AVL Data','GP Mean','2\sigma','Location','southwest')

axis square
axis(axis_range)
set(gcf,'position',[540 100 560 540]);


%% 2-Fidelity
my_GP           = MF_GP;
my_GP           = my_GP.add_data(AVL_Mach85.alpha(AVL_ind),AVL_Mach85.Cm(AVL_ind),AVL_Mach85.Cm_sig(AVL_ind));
my_GP           = my_GP.add_data(SU2_Mach85_uq.alpha,SU2_Mach85_uq.Cm,SU2_Mach85_uq.Cm_sig);

my_GP.x_labs    = 'Alpha [deg]';
my_GP.y_lab     = 'C_m';
my_GP.mf_type   = mf_type;
my_GP.cov_scaling = cov_scaling;

% Fit the GP
my_GP           = my_GP.Process;

% Plotting
figure(2); clf;
my_GP.plot_GP_1D_slice(x_samp,x_samp)
hold on
my_GP.plot_input_data
xlabel('\alpha')
ylabel('C_m')
plots = get(gca,'children');
legend([plots(2) plots(1) plots(3) plots(4)],'AVL Data','SU2 Data','GP Mean','2\sigma','Location','southwest')

axis square
axis(axis_range)
set(gcf,'position',[520 100 560 540]);


%% 3-Fidelity

my_GP           = MF_GP;
my_GP           = my_GP.add_data(AVL_Mach85.alpha(AVL_ind),AVL_Mach85.Cm(AVL_ind),AVL_Mach85.Cm_sig(AVL_ind));
my_GP           = my_GP.add_data(SU2_Mach85_uq.alpha,SU2_Mach85_uq.Cm,SU2_Mach85_uq.Cm_sig);
my_GP           = my_GP.add_data(WT_Mach85.alpha(WT_ind),WT_Mach85.Cm(WT_ind),WT_Mach85.Cm_sig(WT_ind));
my_GP.x_labs    = 'Alpha [deg]';
my_GP.y_lab     = 'C_m';
my_GP.mf_type   = mf_type;
my_GP.cov_scaling = cov_scaling;

% Fit the GP
my_GP           = my_GP.Process;

% Plotting
figure(3); clf;
my_GP.plot_GP_1D_slice(x_samp,x_samp)
hold on
my_GP.plot_input_data
xlabel('\alpha')
ylabel('C_m')
plots = get(gca,'children');
legend([plots(3) plots(2) plots(1) plots(4) plots(5)],'AVL Data','SU2 Data','WT Data','GP Mean','2\sigma','Location','southwest')
axis square
axis(axis_range)
set(gcf,'position',[500 100 560 540]);

%% Saving Plots
figure(1);
saveas(gcf,'plots/cm_1f','epsc')

figure(2);
saveas(gcf,'plots/cm_2f','epsc')

figure(3);
saveas(gcf,'plots/cm_3f','epsc')
