clear variables
load data/cl_rsme_error_local.mat

x_ind = 2:2:length(rsme_error_3f);
figure(1); clf;
semilogy(ns(x_ind),rsme_error_3f(x_ind),ns(x_ind),rsme_error_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
axis square
hold on 
point = find(ns == 13);
semilogy(ns(point),rsme_error_3f(point),'ko',ns(point),rsme_error_1f(point),'ko')
legend('Multi-fidelity','Single Fidelity','Plotted points','location','southwest')


clearvars -except point x_ind
load data/cd_rsme_error_local.mat

figure(2); clf;
semilogy(ns(x_ind),rsme_error_3f(x_ind),ns(x_ind),rsme_error_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
axis square
hold on
semilogy(ns(point),rsme_error_3f(point),'ko',ns(point),rsme_error_1f(point),'ko')
legend('Multi-fidelity','Single Fidelity','Plotted points','location','southwest')

clearvars -except point x_ind
load data/cm_rsme_error_local.mat

figure(3); clf;
semilogy(ns(x_ind),rsme_error_3f(x_ind),ns(x_ind),rsme_error_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
axis square
hold on
semilogy(ns(point),rsme_error_3f(point),'ko',ns(point),rsme_error_1f(point),'ko')
legend('Multi-fidelity','Single Fidelity','Plotted points','location','southwest')


%%
figure(1);
saveas(gcf,'images/cl_rsme_local_comp','png')

figure(2);
saveas(gcf,'images/cd_rsme_local_comp','png')

figure(3);
saveas(gcf,'images/cm_rsme_local_comp','png')
