function [] = generate_std_plots(perf_metrics_MC,perf_metrics_mean)
%UNTITLED2 Summary of this function goes here
figure; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.pitch);
[f2,x2] = ecdf(perf_metrics_MC.rightout.pitch);
[f3,x3] = ecdf(perf_metrics_MC.leftout.pitch);
plot(x1,f1,'LineWidth',2);
plot(x2,f2,'LineWidth',2);
plot(x3,f3,'LineWidth',2)
set(gca,'ColorOrderIndex',1)
plot([perf_metrics_mean.normal.pitch,perf_metrics_mean.normal.pitch],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean.leftout.pitch,perf_metrics_mean.leftout.pitch],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Pitch Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

figure; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.roll);
[f2,x2] = ecdf(perf_metrics_MC.rightout.roll);
[f3,x3] = ecdf(perf_metrics_MC.leftout.roll);
plot(x1,f1,'LineWidth',2);
plot(x2,f2,'LineWidth',2);
plot(x3,f3,'LineWidth',2)
set(gca,'ColorOrderIndex',1)
plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Roll Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

figure; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.yaw);
[f2,x2] = ecdf(perf_metrics_MC.rightout.yaw);
[f3,x3] = ecdf(perf_metrics_MC.leftout.yaw);
plot(x1,f1,'LineWidth',2);
plot(x2,f2,'LineWidth',2);
plot(x3,f3,'LineWidth',2)
set(gca,'ColorOrderIndex',1)
plot([perf_metrics_mean.normal.yaw,perf_metrics_mean.normal.yaw],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean.rightout.yaw,perf_metrics_mean.rightout.yaw],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean.leftout.yaw,perf_metrics_mean.leftout.yaw],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Yaw Metric','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal','R. Engine Out','L. Engine Out','FontWeight','bold');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

end

