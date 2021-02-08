clear variables
load errors/cl_rsme_error.mat
plot_options = plotting_options('thesis');
plot_options.width = 5;
plot_options.height = 5;
setup_plots(plot_options);

x_ind = 2:2:length(rsme_mf)/2;

figure(4); clf;
semilogy(ns(x_ind),rsme_mf(x_ind),ns(x_ind),rsme_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis([0 200 .008 .03])
axis square


clear variables
load errors/cd_rsme_error.mat

x_ind = 1:2:length(rsme_mf)/2;

figure(5); clf;
semilogy(ns(x_ind),rsme_mf(x_ind),ns(x_ind),rsme_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis square

clear variables
load errors/cm_rsme_error.mat

x_ind = 2:2:length(rsme_mf)/2;

figure(6); clf;
semilogy(ns(x_ind),rsme_mf(x_ind),ns(x_ind),rsme_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis([0 200 .008 .02])
axis square
%%
figure(4);
saveas(gcf,'images/cl_2d_rsme_comp','png')

figure(5);
saveas(gcf,'images/cd_2d_rsme_comp','png')

figure(6);
saveas(gcf,'images/cm_2d_rsme_comp','png')
