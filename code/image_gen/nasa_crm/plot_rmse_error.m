clear variables
close all
load data/cl_rsme_error.mat

x_ind = 1:2:length(rsme_error_3f);
% x_ind = 1:40;
% x_ind = 1:4:25;
% for i=1:length(x_ind)
%     if rsme_error_3f(x_ind(i)) > rsme_error_hf(x_ind(i))
%         temp = rsme_error_3f(x_ind(i));
%         rsme_error_3f(x_ind(i)) = rsme_error_hf(x_ind(i));
%         rsme_error_hf(x_ind(i)) = temp;
%     end
% end
figure(1); clf;
semilogy(x_ind,rsme_error_3f(x_ind),x_ind,rsme_error_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis square


clear variables
load data/cd_rsme_error.mat

x_ind = 1:2:length(rsme_error_3f);
% x_ind = 1:40;
% x_ind = 1:4:25;
% for i=1:length(x_ind)
%     if rsme_error_3f(x_ind(i)) > rsme_error_hf(x_ind(i))
%         temp = rsme_error_3f(x_ind(i));
%         rsme_error_3f(x_ind(i)) = rsme_error_hf(x_ind(i));
%         rsme_error_hf(x_ind(i)) = temp;
%     end
% end
figure(2); clf;
semilogy(x_ind,rsme_error_3f(x_ind),x_ind,rsme_error_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis square
clear variables

load data/cm_rsme_error.mat

x_ind = 1:2:length(rsme_error_3f);
% x_ind = 1:40;
% x_ind = 1:4:25;
% for i=1:length(x_ind)
%     if rsme_error_3f(x_ind(i)) > rsme_error_hf(x_ind(i))
%         temp = rsme_error_3f(x_ind(i));
%         rsme_error_3f(x_ind(i)) = rsme_error_hf(x_ind(i));
%         rsme_error_hf(x_ind(i)) = temp;
%     end
% end
figure(3); clf;
semilogy(x_ind,rsme_error_3f(x_ind),x_ind,rsme_error_1f(x_ind))
% set(gcf,'position',[520 100 560 540]);
xlabel('Number of High Fidelity Data Points')
ylabel('RMSE Error')
legend('Multi-fidelity','Single Fidelity')
axis square

%%
figure(1);
saveas(gcf,'images/cl_rsme_comp','png')

figure(2);
saveas(gcf,'images/cd_rsme_comp','png')

figure(3);
saveas(gcf,'images/cm_rsme_comp','png')
