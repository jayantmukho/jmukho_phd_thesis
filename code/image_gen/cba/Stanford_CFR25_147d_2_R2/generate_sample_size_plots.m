function [] = generate_sample_size_plots(perf_metrics_MC,perf_metrics_mean)
set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)


fs = 18;
lw = 3.0;

plot_options = plotting_options('thesis');
plot_options.width = 5;
plot_options.height = 5;
plot_options.font_size = fs;
plot_options.line_width = lw;
setup_plots(plot_options);

batches = [100,500,1000];
figs = {};
%% 100 samples
for i = 1:length(batches)
    batch = batches(i);
    figure; hold on;
    [f1,x1] = ecdf(perf_metrics_MC.normal.pitch(1:batch));
    [f2,x2] = ecdf(perf_metrics_MC.rightout.pitch(1:batch));
    [f3,x3] = ecdf(perf_metrics_MC.leftout.pitch(1:batch));
    plot(x1,f1);
    plot(x2,f2);
    plot(x3,f3)
    set(gca,'ColorOrderIndex',1)
    plot([perf_metrics_mean.normal.pitch,perf_metrics_mean.normal.pitch],[0 1],'--');
    plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'--');
    plot([perf_metrics_mean.leftout.pitch,perf_metrics_mean.leftout.pitch],[0 1],'--');
    xlabel('Pitch Metric');
    ylabel('Cumulative Probability');
    legend('Normal','R. Engine Out','L. Engine Out','location','northwest');
    xlim([-0.1, 0.8]);
    grid on; box on;
    fn = sprintf('images/orig_pitch_metric_%i.png',batch);
    saveas(gcf,fn)
    
    figure; hold on;
    [f1,x1] = ecdf(perf_metrics_MC.normal.roll(1:batch));
    [f2,x2] = ecdf(perf_metrics_MC.rightout.roll(1:batch));
    [f3,x3] = ecdf(perf_metrics_MC.leftout.roll(1:batch));
    plot(x1,f1);
    plot(x2,f2);
    plot(x3,f3)
    set(gca,'ColorOrderIndex',1)
    plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--');
    plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--');
    plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--');
    xlabel('Roll Metric');
    ylabel('Cumulative Probability');
%     legend('Normal','R. Engine Out','L. Engine Out','location','northwest');
    xlim([-0.1, 0.8]);
    grid on; box on;
    fn = sprintf('images/orig_roll_metric_%i.png',batch);
    saveas(gcf,fn)
    
    figure; hold on;
    [f1,x1] = ecdf(perf_metrics_MC.normal.yaw(1:batch));
    [f2,x2] = ecdf(perf_metrics_MC.rightout.yaw(1:batch));
    [f3,x3] = ecdf(perf_metrics_MC.leftout.yaw(1:batch));
    plot(x1,f1);
    plot(x2,f2);
    plot(x3,f3)
    set(gca,'ColorOrderIndex',1)
    plot([perf_metrics_mean.normal.yaw,perf_metrics_mean.normal.yaw],[0 1],'--');
    plot([perf_metrics_mean.rightout.yaw,perf_metrics_mean.rightout.yaw],[0 1],'--');
    plot([perf_metrics_mean.leftout.yaw,perf_metrics_mean.leftout.yaw],[0 1],'--');
    xlabel('Yaw Metric');
    ylabel('Cumulative Probability');
%     legend('Normal','R. Engine Out','L. Engine Out','location','northwest');
    xlim([-0.1, 0.8]);
    grid on; box on;
    fn = sprintf('images/orig_yaw_metric_%i.png',batch);
    saveas(gcf,fn)
end

batches = 2.^linspace(1,9,9);%[100,500,1000];
batches = [batches, 1000];
var1 = zeros(size(batches));
var2 = var1;
var3 = var1;
mean1 = var1;
mean2 = var1;
mean3 = var1;
for i = 1:length(batches)
    batch = batches(i);
    [f1,x1] = ecdf(perf_metrics_MC.normal.roll(1:batch));
    [f2,x2] = ecdf(perf_metrics_MC.rightout.roll(1:batch));
    [f3,x3] = ecdf(perf_metrics_MC.leftout.roll(1:batch));
    
    [~,ind_mean] = min(abs(f1-0.5));
    mean1(i) = x1(ind_mean);
    var1(i) = var(perf_metrics_MC.normal.roll(1:batch));
    
    [~,ind_mean] = min(abs(f2-0.5));
    mean2(i) = x2(ind_mean);
    var2(i) = var(perf_metrics_MC.rightout.roll(1:batch));
    
    [~,ind_mean] = min(abs(f3-0.5));
    mean3(i) = x3(ind_mean);
    var3(i) = var(perf_metrics_MC.leftout.roll(1:batch));
end

figure;
semilogx(batches,var1)
hold all;
semilogx(batches,var2)
semilogx(batches,var3)
xlabel('Number of Samples');
ylabel('Variance of Roll Metric');
legend('Normal','R. Engine Out','L. Engine Out','location','northwest');
grid on; box on;
set_figure_size(gcf,8,5);
saveas(gcf,'images/mc_var_convergence.png');

figure;
semilogx(batches,mean1)
hold all;
semilogx(batches,mean2)
semilogx(batches,mean3)
xlabel('Number of Samples');
ylabel('Mean of Roll Metric');
legend('Normal','R. Engine Out','L. Engine Out','location','northwest');
grid on; box on;
set_figure_size(gcf,8,5);
saveas(gcf,'images/mc_mean_convergence.png');

% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.pitch(1:100));
% [f2,x2] = ecdf(perf_metrics_MC.rightout.pitch(1:100));
% [f3,x3] = ecdf(perf_metrics_MC.leftout.pitch(1:100));
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.pitch,perf_metrics_mean.normal.pitch],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.pitch,perf_metrics_mean.leftout.pitch],[0 1],'--','LineWidth',2);
% set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Pitch Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
% %set(gcf,'Position',[312,456,1084,420]);
% xlim([0.5, 0.8]);

% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.roll(1:100));
% [f2,x2] = ecdf(perf_metrics_MC.rightout.roll(1:100));
% [f3,x3] = ecdf(perf_metrics_MC.leftout.roll(1:100));
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--','LineWidth',2);
% % set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Roll Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
% %set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);
% grid on; box on;

% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.yaw(1:100));
% [f2,x2] = ecdf(perf_metrics_MC.rightout.yaw(1:100));
% [f3,x3] = ecdf(perf_metrics_MC.leftout.yaw(1:100));
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.yaw,perf_metrics_mean.normal.yaw],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.yaw,perf_metrics_mean.rightout.yaw],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.yaw,perf_metrics_mean.leftout.yaw],[0 1],'--','LineWidth',2);
% set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Yaw Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


%% 500 samples
% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.pitch(1:500));
% [f2,x2] = ecdf(perf_metrics_MC.rightout.pitch(1:500));
% [f3,x3] = ecdf(perf_metrics_MC.leftout.pitch(1:500));
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.pitch,perf_metrics_mean.normal.pitch],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.pitch,perf_metrics_mean.leftout.pitch],[0 1],'--','LineWidth',2);
% set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Pitch Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.roll(1:500));
% [f2,x2] = ecdf(perf_metrics_MC.rightout.roll(1:500));
% [f3,x3] = ecdf(perf_metrics_MC.leftout.roll(1:500));
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--','LineWidth',2);
% % set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Roll Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
% %set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);
% grid on; box on;

% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.yaw(1:500));
% [f2,x2] = ecdf(perf_metrics_MC.rightout.yaw(1:500));
% [f3,x3] = ecdf(perf_metrics_MC.leftout.yaw(1:500));
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.yaw,perf_metrics_mean.normal.yaw],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.yaw,perf_metrics_mean.rightout.yaw],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.yaw,perf_metrics_mean.leftout.yaw],[0 1],'--','LineWidth',2);
% set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Yaw Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


%% 1000 samples
% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.pitch);
% [f2,x2] = ecdf(perf_metrics_MC.rightout.pitch);
% [f3,x3] = ecdf(perf_metrics_MC.leftout.pitch);
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.pitch,perf_metrics_mean.normal.pitch],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.pitch,perf_metrics_mean.leftout.pitch],[0 1],'--','LineWidth',2);
% set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Pitch Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.roll);
% [f2,x2] = ecdf(perf_metrics_MC.rightout.roll);
% [f3,x3] = ecdf(perf_metrics_MC.leftout.roll);
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--','LineWidth',2);
% % set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Roll Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
% %set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);
% grid on; box on;

% figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.normal.yaw);
% [f2,x2] = ecdf(perf_metrics_MC.rightout.yaw);
% [f3,x3] = ecdf(perf_metrics_MC.leftout.yaw);
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% plot([perf_metrics_mean.normal.yaw,perf_metrics_mean.normal.yaw],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.rightout.yaw,perf_metrics_mean.rightout.yaw],[0 1],'--','LineWidth',2);
% plot([perf_metrics_mean.leftout.yaw,perf_metrics_mean.leftout.yaw],[0 1],'--','LineWidth',2);
% set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Yaw Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

% %%
% figs{5} = figure; hold on;
% [f1,x1] = ecdf(perf_metrics_MC.rightout.roll(1:200));
% [f2,x2] = ecdf(perf_metrics_MC.rightout.roll(1:500));
% [f3,x3] = ecdf(perf_metrics_MC.rightout.roll);
% 
% plot(x1,f1,'LineWidth',2);
% plot(x2,f2,'LineWidth',2);
% plot(x3,f3,'LineWidth',2)
% set(gca,'ColorOrderIndex',1)
% % plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--','LineWidth',2);
% % plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--','LineWidth',2);
% % plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--','LineWidth',2);
% % set(gca,'FontSize',12,'FontWeight','bold');
% xlabel('Roll Metric','FontWeight','bold');
% ylabel('Cumulative Probability','FontWeight','bold');
% legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
% %set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

end

