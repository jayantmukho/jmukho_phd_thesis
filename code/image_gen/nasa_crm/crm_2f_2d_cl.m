clear variables
close all
% run('data/organize_crm_data.m')
load('GP_2F_2D_CRM_Data.mat')
plot_options = plotting_options('thesis');
plot_options.width = 6;
plot_options.height = 7;
plot_options.marker_size = 12;
setup_plots(plot_options);
%% Input data organization
skip_ind = 2;
x_dat_AVL = [AVL_Mach7.alpha(1:skip_ind:end), ones(size(AVL_Mach7.alpha(1:skip_ind:end)))*0.7;
    AVL_Mach75.alpha(1:skip_ind:end), ones(size(AVL_Mach75.alpha(1:skip_ind:end)))*0.75;
    AVL_Mach8.alpha(1:skip_ind:end), ones(size(AVL_Mach8.alpha(1:skip_ind:end)))*0.8;
    AVL_Mach83.alpha(1:skip_ind:end), ones(size(AVL_Mach83.alpha(1:skip_ind:end)))*0.83;
    AVL_Mach85.alpha(1:skip_ind:end), ones(size(AVL_Mach85.alpha(1:skip_ind:end)))*0.85;
    AVL_Mach86.alpha(1:skip_ind:end), ones(size(AVL_Mach86.alpha(1:skip_ind:end)))*0.86;
    AVL_Mach87.alpha(1:skip_ind:end), ones(size(AVL_Mach87.alpha(1:skip_ind:end)))*0.87];

y_dat_AVL = [AVL_Mach7.CL(1:skip_ind:end);
    AVL_Mach75.CL(1:skip_ind:end);
    AVL_Mach8.CL(1:skip_ind:end);
    AVL_Mach83.CL(1:skip_ind:end);
    AVL_Mach85.CL(1:skip_ind:end);
    AVL_Mach86.CL(1:skip_ind:end);
    AVL_Mach87.CL(1:skip_ind:end)];

s_dat_AVL = [AVL_Mach7.CL_sig(1:skip_ind:end);
    AVL_Mach75.CL_sig(1:skip_ind:end);
    AVL_Mach8.CL_sig(1:skip_ind:end);
    AVL_Mach83.CL_sig(1:skip_ind:end);
    AVL_Mach85.CL_sig(1:skip_ind:end);
    AVL_Mach86.CL_sig(1:skip_ind:end);
    AVL_Mach87.CL_sig(1:skip_ind:end)];

skip_ind = 7;

x_dat_WT = [WT_Mach7.alpha(1:skip_ind:end), ones(size(WT_Mach7.alpha(1:skip_ind:end)))*0.7;
    WT_Mach75.alpha(1:skip_ind:end), ones(size(WT_Mach75.alpha(1:skip_ind:end)))*0.75;
    WT_Mach8.alpha(1:skip_ind:end), ones(size(WT_Mach8.alpha(1:skip_ind:end)))*0.8;
    WT_Mach83.alpha(1:skip_ind:end), ones(size(WT_Mach83.alpha(1:skip_ind:end)))*0.83;
    WT_Mach85.alpha(1:skip_ind:end), ones(size(WT_Mach85.alpha(1:skip_ind:end)))*0.85;
    WT_Mach86.alpha(1:skip_ind:end), ones(size(WT_Mach86.alpha(1:skip_ind:end)))*0.86;
    WT_Mach87.alpha(1:skip_ind:end), ones(size(WT_Mach87.alpha(1:skip_ind:end)))*0.87];

y_dat_WT = [WT_Mach7.CL(1:skip_ind:end);
    WT_Mach75.CL(1:skip_ind:end);
    WT_Mach8.CL(1:skip_ind:end);
    WT_Mach83.CL(1:skip_ind:end);
    WT_Mach85.CL(1:skip_ind:end);
    WT_Mach86.CL(1:skip_ind:end);
    WT_Mach87.CL(1:skip_ind:end)];

s_dat_WT = [WT_Mach7.CL_sig(1:skip_ind:end);
    WT_Mach75.CL_sig(1:skip_ind:end);
    WT_Mach8.CL_sig(1:skip_ind:end);
    WT_Mach83.CL_sig(1:skip_ind:end);
    WT_Mach85.CL_sig(1:skip_ind:end);
    WT_Mach86.CL_sig(1:skip_ind:end);
    WT_Mach87.CL_sig(1:skip_ind:end)];

x_dat_WT_all = [WT_Mach7.alpha, ones(size(WT_Mach7.alpha))*0.7;
    WT_Mach75.alpha, ones(size(WT_Mach75.alpha))*0.75;
    WT_Mach8.alpha, ones(size(WT_Mach8.alpha))*0.8;
    WT_Mach83.alpha, ones(size(WT_Mach83.alpha))*0.83;
    WT_Mach85.alpha, ones(size(WT_Mach85.alpha))*0.85;
    WT_Mach86.alpha, ones(size(WT_Mach86.alpha))*0.86;
    WT_Mach87.alpha, ones(size(WT_Mach87.alpha))*0.87];

y_dat_WT_all = [WT_Mach7.CL;
    WT_Mach75.CL;
    WT_Mach8.CL;
    WT_Mach83.CL;
    WT_Mach85.CL;
    WT_Mach86.CL;
    WT_Mach87.CL];

s_dat_WT_all = [WT_Mach7.CL_sig;
    WT_Mach75.CL_sig;
    WT_Mach8.CL_sig;
    WT_Mach83.CL_sig;
    WT_Mach85.CL_sig;
    WT_Mach86.CL_sig;
    WT_Mach87.CL_sig];

validation_set_ind = find(~ismember(x_dat_WT_all,x_dat_WT,'rows'));

figure(1); clf;
plot3(x_dat_AVL(:,1),x_dat_AVL(:,2),y_dat_AVL,'x')
hold on
plot3(x_dat_WT(:,1),x_dat_WT(:,2),y_dat_WT,'x')
xlabel('$\alpha$');
ylabel('Mach');
zlabel('$C_L$');
legend('AVL Data','WT Data','location','northwest')
% set(gcf,'position',[375 40 650 785])
axis([-5 15 0.7 0.9 -0.5 1.5])
axis square
grid on
%% GP Initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the MF_GP instance and load the data
my_GP           = MF_GP;
my_GP           = my_GP.add_data(x_dat_AVL,y_dat_AVL,s_dat_AVL);
my_GP           = my_GP.add_data(x_dat_WT,y_dat_WT,s_dat_WT);
my_GP.x_labs    = {'$\alpha$','Mach'};
% my_GP.y_lab     = '$C_L$';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fit the hyperparameters
my_GP       = my_GP.Process;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the new grid at which to sample the GP
x_in_1      = [-3:.25:12]';
x_in_2      = [0.7:.01:0.87]';
[X1_S,X2_S] = meshgrid(x_in_1,x_in_2);

% %% Plotting

% Get the basic regression result
[Mu_S, S_S] = my_GP.Query(X1_S,X2_S);

% figure(2);clf
% subplot(1,2,1)
% % Plot the regression solution +/- 2 sigma
% surf(X1_S,X2_S,Mu_S,'facealpha',0.5);
% xlabel(my_GP.x_labs{1});
% ylabel(my_GP.x_labs{2});
% zlabel(my_GP.y_lab);
% hold all
% surf(X1_S,X2_S,Mu_S +2*S_S,'facealpha',.2);
% surf(X1_S,X2_S,Mu_S -2*S_S,'facealpha',.2);
% 
% subplot(1,2,2)
% % Plot the regression solution and some samples
% surf(X1_S,X2_S,Mu_S);
% xlabel(my_GP.x_labs{1});
% ylabel(my_GP.x_labs{2});
% zlabel(my_GP.y_lab);
% hold all
% for ii = 1:5
%     surf(X1_S,X2_S,my_GP.Sample(X1_S,X2_S),'facealpha',.2);
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Demo of examining an arbitrary slice through the GP
% figure(3);clf
% 
% subplot(1,2,1)
% % Plot the regression solution +/- 2 sigma
% surf(X1_S,X2_S,Mu_S);
% xlabel(my_GP.x_labs{1});
% ylabel(my_GP.x_labs{2});
% zlabel(my_GP.y_lab);
% hold all
% surf(X1_S,X2_S,Mu_S+2*S_S,'facealpha',.2);
% surf(X1_S,X2_S,Mu_S-2*S_S,'facealpha',.2);
% 
% % Define and plot the slice
% n_slice         = 20;
% x1_slice        = linspace(-2,10,n_slice);
% x2_slice        = linspace(.87,.7,n_slice);
% x_slice         = [x1_slice(:),x2_slice(:)];
% [Mu,S]          = my_GP.Query(x_slice);
% V               = [Mu+2*S, Mu, Mu-2*S];
% h = surf(x1_slice'*ones(1,3),x2_slice'*ones(1,3),V,'facecolor','r');
% 
% subplot(1,2,2)
% % Plot and sample the GP along the slice
% my_GP.plot_GP_1D_slice(x_slice)
% hold all
% for ii = 1:10;
%     y_samp     = my_GP.Sample(x_slice);
%     plot(1:size(x_slice,1),y_samp);
% end
% 
% 
% %% Plot slices along the input dimensions
% 
% x0      = [6,0.77];
% figure(4);clf
% subplot(1,3,1)
% surf(X1_S,X2_S,Mu_S);
% xlabel(my_GP.x_labs{1});
% ylabel(my_GP.x_labs{2});
% zlabel(my_GP.y_lab);
% hold all
% surf(X1_S,X2_S,Mu_S+2*S_S,'facealpha',.2);
% surf(X1_S,X2_S,Mu_S-2*S_S,'facealpha',.2);
% 
% % Define and plot the slices
% x1_slice        = x_in_1;
% x2_slice        = x0(2)*ones(length(x_in_1),1);
% x_slice         = [x1_slice(:),x2_slice(:)];
% [Mu,S]          = my_GP.Query(x_slice);
% V               = [Mu+2*S,Mu,Mu-2*S];
% h = surf(x1_slice(:)*ones(1,3),x2_slice(:)*ones(1,3),V,'facecolor','r');
% 
% x1_slice        = x0(1)*ones(length(x_in_2),1);
% x2_slice        = x_in_2;
% x_slice         = [x1_slice(:),x2_slice(:)];
% [Mu,S]          = my_GP.Query(x_slice);
% V               = [Mu+2*S, Mu, Mu-2*S];
% h = surf(x1_slice(:)*ones(1,3),x2_slice(:)*ones(1,3),V,'facecolor','r');
% 
% subplot(1,3,2)
% 
% x_samp  = [x_in_1,x0(2)*ones(length(x_in_1),1)];
% my_GP.plot_GP_1D_slice(x_samp)
% 
% hold all
% for ii = 1:10;
% %     my_GP.sample_seed = ii;
%     y_samp     = my_GP.Sample(x_samp);
%     plot(1:size(x_samp,1),y_samp);
% end
% 
% subplot(1,3,3)
% dim_plot    = 2;
% % x_samp    = [X1(:),X2(:)];
% 
% x_samp  = [x0(1)*ones(length(x_in_2),1),x_in_2];
% my_GP.plot_GP_1D_slice(x_samp)
% hold all
% 
% my_GP.sample_seed = 1;
% for ii = 1:10;
%     my_GP.sample_seed = ii;
%     y_samp     = my_GP.Sample(x_samp);
%     plot(1:size(x_samp,1),y_samp);
% end
%%
figure(5); clf;

% Plot the regression solution +/- 2 sigma
m=surf(X1_S,X2_S,Mu_S);
xlabel(my_GP.x_labs{1});
ylabel(my_GP.x_labs{2});
zlabel('$C_L$');
hold all
axis([-5 15 0.7 0.9 -0.5 1.5])
axis square
% set(gcf,'position',[375 40 650 785])
ps=surf(X1_S,X2_S,Mu_S+2*S_S,'facealpha',.2);
ns=surf(X1_S,X2_S,Mu_S-2*S_S,'facealpha',.2);


% Define and plot the slic
n_slice         = 20;
x1_slice        = linspace(-2,10,n_slice);
x2_slice        = linspace(.87,.7,n_slice);
x_slice         = [x1_slice(:),x2_slice(:)];
[Mu,S]          = my_GP.Query(x_slice);
V               = [Mu+2*S, Mu, Mu-2*S];
h = surf(x1_slice'*ones(1,3),x2_slice'*ones(1,3),V,'facecolor','r');
legend([h],'Slice Location','location','northwest')

figure(7); clf;
m=surf(X1_S,X2_S,Mu_S);
xlabel(my_GP.x_labs{1});
ylabel(my_GP.x_labs{2});
zlabel('$C_L$');
hold all
axis([5 12 0.7 0.8 0.5 1.1])
axis square
% set(gcf,'position',[375 40 650 785])
ps=surf(X1_S,X2_S,Mu_S+2*S_S,'facealpha',.2)%,'edgecolor','flat');
ns=surf(X1_S,X2_S,Mu_S-2*S_S,'facealpha',.2)%,'edgecolor','flat');

% Define and plot the slic
n_slice         = 20;
x1_slice        = linspace(-2,10,n_slice);
x2_slice        = linspace(.87,.7,n_slice);
x_slice         = [x1_slice(:),x2_slice(:)];
[Mu,S]          = my_GP.Query(x_slice);
V               = [Mu+2*S, Mu, Mu-2*S];
h = surf(x1_slice'*ones(1,3),x2_slice'*ones(1,3),V,'facecolor','r');
h = surf(x1_slice'*ones(1,3),x2_slice'*ones(1,3),V,'facecolor','r');
legend([h],'Slice Location','location','northwest')
% legend()

figure(6); clf; % Plot and sample the GP along the slice
my_GP.plot_GP_1D_slice(x_slice)
axis square
% set(gcf,'position',[375 40 650 785])
xlabel('$\alpha$, Mach')
ylabel('$C_L$')
legend(get(gca,'children'),'GP Mean','$2\sigma$','Location','northwest')
ax1 = gca;
ax2 = axes('Position',[0.5 0.27 0.35 0.29]);
box on
inds = size(x_slice,1)-5:size(x_slice,1);
my_GP.plot_GP_1D_slice(x_slice(inds,:))
hold on
axis([1,7,0.75,0.9])
for ii = 1:4;
    my_GP.sample_seed = ii+15;
    y_samp     = my_GP.Sample(x_slice);
    hold(ax1,'on')
    plot(ax1,1:size(x_slice,1),y_samp,'HandleVisibility','off');
    hold(ax2,'on')
    plot(ax2,1:size(inds,2),y_samp(inds),'HandleVisibility','off')
end
hold(ax1,'on')
xlabel('$\alpha$, Mach')
ylabel('$C_L$')
set(ax2,'FontSize',14)
axis square

% figure(9)
% my_GP.plot_GP_2D_surf(x_in_1,x_in_2)
%% RSME comparison
x_dat_valid     = x_dat_WT_all(validation_set_ind,:);
y_dat_valid     = y_dat_WT_all(validation_set_ind);
[Mu,~]          = my_GP.Query(x_dat_valid);
rsme_mf         = sqrt(sum((Mu-y_dat_valid).^2)/length(Mu));

my_GP_1f        = MF_GP;
my_GP_1f        = my_GP_1f.add_data(x_dat_WT,y_dat_WT,s_dat_WT);
my_GP_1f        = my_GP_1f.Process;
[Mu,~]          = my_GP_1f.Query(x_dat_valid);
rsme_1f         = sqrt(sum((Mu-y_dat_valid).^2)/length(Mu));

fprintf('RSME with 1 Fidelity: %1.4f \nRSME with Multi-fidelity: %1.4f\n',rsme_1f,rsme_mf);

%% Saving Plots
figure(1);
saveas(gcf,'images/cl_2d_2f_points','png')

figure(5);
saveas(gcf,'images/cl_2d_2f_surf','png')

figure(7)
saveas(gcf,'images/cl_2d_2f_surf_zoom','png')

figure(6);
saveas(gcf,'images/cl_2d_2f_sample','png')
