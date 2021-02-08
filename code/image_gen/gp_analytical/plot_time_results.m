clear variables
close all
set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)


fs = 18;
lw = 2.0;
msz= 8;

plot_options = plotting_options('thesis');
plot_options.width = 5;
plot_options.height = 5;
plot_options.font_size = fs;
plot_options.line_width = lw;
setup_plots(plot_options);

load('time_test_results.mat')

%% Plotting
n_total = n_lf+n_hf;
figure(1); clf;
semilogy(n_total,t_process_grat,n_total,t_process_ken,'LineWidth',2)
% set(gca,'FontSize',12)
legend('Gratiet','Kennedy and O''Hagan','Location','southeast')
xlabel('Number of total data points');
ylabel('Time (sec)');
axis([min(n_total) max(n_total) min(min([t_process_grat t_process_ken])) max(max([t_process_grat t_process_ken]))])
axis square
% set(gcf,'position',[540 100 560 540]);

figure(2); clf;
semilogy(5*n_lf,t_query_grat,5*n_lf,t_query_ken,'LineWidth',2)
% set(gca,'FontSize',12)
legend('Gratiet','Kennedy and O''Hagan','Location','southeast')
xlabel('Number of sample points');
ylabel('Time (sec)');
axis([5*min(n_lf) 5*max(n_lf) min(min([t_query_grat t_query_ken])) max(max([t_query_grat t_query_ken]))])
axis square
% set(gcf,'position',[500 100 560 540]);

%% Saving Plots
figure(1);
saveas(gcf,'images/time_process','png')

figure(2);
saveas(gcf,'images/time_query','png')
