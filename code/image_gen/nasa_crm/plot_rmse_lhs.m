clear variables
load errors/cl_rsme_error_lhs.mat

skip_ind = 3;

x_ind = 2:skip_ind:length(rsme_mf);

figure(1); clf;
semilogy(ns(x_ind),rsme_mf(x_ind),ns(x_ind),rsme_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis([0 200 .008 .05])
axis square


clear variables
skip_ind = 2;
load errors/cd_rsme_error_lhs.mat

x_ind = 1:skip_ind:length(rsme_mf);

figure(2); clf;
semilogy(ns(x_ind),rsme_1f(x_ind),ns(x_ind),rsme_mf(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis([0 200 .001 .02])
axis square

clear variables
skip_ind = 2;
load errors/cm_rsme_error_lhs.mat

x_ind = 2:skip_ind:length(rsme_mf);

figure(3); clf;
semilogy(ns(x_ind),rsme_mf(x_ind),ns(x_ind),rsme_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis([0 200 .008 .05])
axis square
%%
figure(1);
saveas(gcf,'images/cl_2d_rsme_lhs_comp','png')

figure(2);
saveas(gcf,'images/cd_2d_rsme_lhs_comp','png')

figure(3);
saveas(gcf,'images/cm_2d_rsme_lhs_comp','png')
