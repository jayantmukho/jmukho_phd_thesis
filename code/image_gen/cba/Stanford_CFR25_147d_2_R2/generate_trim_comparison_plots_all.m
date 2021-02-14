function [] = generate_trim_comparison_plots_all(perf_metrics_MC,perf_metrics_MC2,perf_metrics_MC3,perf_metrics_MC4,perf_metrics_MC5,perf_metrics_mean,perf_metrics_mean2,perf_metrics_mean3,perf_metrics_mean4,perf_metrics_mean5)
figure; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.alpha_deg);
[f2,x2] = ecdf(perf_metrics_MC2.normal.alpha_deg);
[f3,x3] = ecdf(perf_metrics_MC3.normal.alpha_deg);
[f4,x4] = ecdf(perf_metrics_MC4.normal.alpha_deg);
[f5,x5] = ecdf(perf_metrics_MC5.normal.alpha_deg);
plot(x1,f1,'k','LineWidth',2);
plot(x2,f2,'LineWidth',2);
plot(x3,f3,'LineWidth',2);
plot(x4,f4,'LineWidth',2);
plot(x5,f5,'LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.normal.alpha_deg,perf_metrics_mean.normal.alpha_deg],[0 1],'k--','LineWidth',2);
plot([perf_metrics_mean2.normal.alpha_deg,perf_metrics_mean2.normal.alpha_deg],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean3.normal.alpha_deg,perf_metrics_mean3.normal.alpha_deg],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean4.normal.alpha_deg,perf_metrics_mean4.normal.alpha_deg],[0 1],'--','LineWidth',2);
plot([perf_metrics_mean5.normal.alpha_deg,perf_metrics_mean5.normal.alpha_deg],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Trim Angle of Attack (deg)','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Full WT dataset','AVL dataset','AVL+SU2 dataset','AVL+SU2+WT dataset','Sparse WT dataset','FontWeight','bold');
set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);
end

