function [] = generate_comparison_plots_all(perf_metrics_MC,perf_metrics_MC2,perf_metrics_MC3,perf_metrics_mean,perf_metrics_mean2,perf_metrics_mean3)

%% Pitch metric
[f1,x1] = ecdf(perf_metrics_MC.normal.pitch);
[f2,x2] = ecdf(perf_metrics_MC.rightout.pitch);
[f3,x3] = ecdf(perf_metrics_MC.leftout.pitch);
[f4,x4] = ecdf(perf_metrics_MC2.normal.pitch);
[f5,x5] = ecdf(perf_metrics_MC2.rightout.pitch);
[f6,x6] = ecdf(perf_metrics_MC2.leftout.pitch);
[f7,x7] = ecdf(perf_metrics_MC3.normal.pitch);
[f8,x8] = ecdf(perf_metrics_MC3.rightout.pitch);
[f9,x9] = ecdf(perf_metrics_MC3.leftout.pitch);

% Engines normal
figure; hold on;
plot(x1,f1,'k','LineWidth',2);
plot(x4,f4,'LineWidth',2);
plot(x7,f7,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.normal.pitch,perf_metrics_mean.normal.pitch],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.normal.pitch,perf_metrics_mean2.normal.pitch],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.normal.pitch,perf_metrics_mean3.normal.pitch],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Pitch Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal (Full WT)','Normal (AVL)','Normal (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Right out
figure; hold on;
plot(x2,f2,'k','LineWidth',2);
plot(x5,f5,'LineWidth',2);
plot(x8,f8,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.rightout.pitch,perf_metrics_mean2.rightout.pitch],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.rightout.pitch,perf_metrics_mean3.rightout.pitch],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Pitch Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('R. Engine Out (Full WT)','R. Engine Out (AVL)','R. Engine Out (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Left out
figure; hold on;
plot(x3,f3,'k','LineWidth',2);
plot(x6,f6,'LineWidth',2);
plot(x9,f9,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.leftout.pitch,perf_metrics_mean.leftout.pitch],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.leftout.pitch,perf_metrics_mean2.leftout.pitch],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.leftout.pitch,perf_metrics_mean3.leftout.pitch],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Pitch Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('L. Engine Out (Full WT)','L. Engine Out (AVL)','L. Engine Out (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


%% Roll metric
[f1,x1] = ecdf(perf_metrics_MC.normal.roll);
[f2,x2] = ecdf(perf_metrics_MC.rightout.roll);
[f3,x3] = ecdf(perf_metrics_MC.leftout.roll);
[f4,x4] = ecdf(perf_metrics_MC2.normal.roll);
[f5,x5] = ecdf(perf_metrics_MC2.rightout.roll);
[f6,x6] = ecdf(perf_metrics_MC2.leftout.roll);
[f7,x7] = ecdf(perf_metrics_MC3.normal.roll);
[f8,x8] = ecdf(perf_metrics_MC3.rightout.roll);
[f9,x9] = ecdf(perf_metrics_MC3.leftout.roll);

% Engines normal
figure; hold on;
plot(x1,f1,'k','LineWidth',2);
plot(x4,f4,'LineWidth',2);
plot(x7,f7,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.normal.roll,perf_metrics_mean2.normal.roll],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.normal.roll,perf_metrics_mean3.normal.roll],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Roll Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal (Full WT)','Normal (AVL)','Normal (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Right out
figure; hold on;
plot(x2,f2,'k','LineWidth',2);
plot(x5,f5,'LineWidth',2);
plot(x8,f8,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.rightout.roll,perf_metrics_mean2.rightout.roll],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.rightout.roll,perf_metrics_mean3.rightout.roll],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Roll Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('R. Engine Out (Full WT)','R. Engine Out (AVL)','R. Engine Out (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Left out
figure; hold on;
plot(x3,f3,'k','LineWidth',2);
plot(x6,f6,'LineWidth',2);
plot(x9,f9,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.leftout.roll,perf_metrics_mean2.leftout.roll],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.leftout.roll,perf_metrics_mean3.leftout.roll],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Roll Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('L. Engine Out (Full WT)','L. Engine Out (AVL)','L. Engine Out (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


%% Yaw metric
[f1,x1] = ecdf(perf_metrics_MC.normal.yaw);
[f2,x2] = ecdf(perf_metrics_MC.rightout.yaw);
[f3,x3] = ecdf(perf_metrics_MC.leftout.yaw);
[f4,x4] = ecdf(perf_metrics_MC2.normal.yaw);
[f5,x5] = ecdf(perf_metrics_MC2.rightout.yaw);
[f6,x6] = ecdf(perf_metrics_MC2.leftout.yaw);
[f7,x7] = ecdf(perf_metrics_MC3.normal.yaw);
[f8,x8] = ecdf(perf_metrics_MC3.rightout.yaw);
[f9,x9] = ecdf(perf_metrics_MC3.leftout.yaw);

% Engines normal
figure; hold on;
plot(x1,f1,'k','LineWidth',2);
plot(x4,f4,'LineWidth',2);
plot(x7,f7,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.normal.yaw,perf_metrics_mean.normal.yaw],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.normal.yaw,perf_metrics_mean2.normal.yaw],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.normal.yaw,perf_metrics_mean3.normal.yaw],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Yaw Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal (Full WT)','Normal (AVL)','Normal (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Right out
figure; hold on;
plot(x2,f2,'k','LineWidth',2);
plot(x5,f5,'LineWidth',2);
plot(x8,f8,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.rightout.yaw,perf_metrics_mean.rightout.yaw],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.rightout.yaw,perf_metrics_mean2.rightout.yaw],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.rightout.yaw,perf_metrics_mean3.rightout.yaw],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Yaw Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('R. Engine Out (Full WT)','R. Engine Out (AVL)','R. Engine Out (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Left out
figure; hold on;
plot(x3,f3,'k','LineWidth',2);
plot(x6,f6,'LineWidth',2);
plot(x9,f9,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.leftout.yaw,perf_metrics_mean.leftout.yaw],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.leftout.yaw,perf_metrics_mean2.leftout.yaw],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.leftout.yaw,perf_metrics_mean3.leftout.yaw],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Yaw Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('L. Engine Out (Full WT)','L. Engine Out (AVL)','L. Engine Out (AVL+SU2)','FontWeight','bold','Location','Best');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

end

