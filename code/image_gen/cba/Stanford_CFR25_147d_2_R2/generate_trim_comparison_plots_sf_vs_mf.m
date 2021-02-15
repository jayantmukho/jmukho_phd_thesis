function [] = generate_trim_comparison_plots_sf_vs_mf(perf_metrics_MC,perf_metrics_MC2,perf_metrics_MC3,perf_metrics_MC4,perf_metrics_MC5,perf_metrics_mean,perf_metrics_mean2,perf_metrics_mean3,perf_metrics_mean4,perf_metrics_mean5)
% set(groot,'defaultAxesFontSize',18)
% set(groot,'defaultAxesTickLength',[0.01 0.01])
% set(groot,'defaultAxesLineWidth',2)
% 
% 
% fs = 18;
% lw = 3.0;
% 
% plot_options = plotting_options('thesis');
% plot_options.width = 8;
% plot_options.height = 5;
% plot_options.font_size = fs;
% plot_options.line_width = lw;
% setup_plots(plot_options);

figure; hold on;
set(gca,'ColorOrderIndex',1);
[f1,x1] = ecdf(perf_metrics_MC.normal.alpha_deg);
[f2,x2] = ecdf(perf_metrics_MC2.normal.alpha_deg);
[f3,x3] = ecdf(perf_metrics_MC3.normal.alpha_deg);
[f4,x4] = ecdf(perf_metrics_MC4.normal.alpha_deg);
plot(x1,f1,'k');
plot(x2,f2);
plot(x3,f3);
plot(x4,f4);
set(gca,'ColorOrderIndex',1);
plot([perf_metrics_mean.normal.alpha_deg,perf_metrics_mean.normal.alpha_deg],[0 1],'k--');
plot([perf_metrics_mean2.normal.alpha_deg,perf_metrics_mean2.normal.alpha_deg],[0 1],'--');
plot([perf_metrics_mean3.normal.alpha_deg,perf_metrics_mean3.normal.alpha_deg],[0 1],'--');
plot([perf_metrics_mean4.normal.alpha_deg,perf_metrics_mean4.normal.alpha_deg],[0 1],'--');
set(gca,'FontWeight','bold');
xlabel('Trim Angle of Attack (deg)','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
% legend('WT','AVL','AVL+SU2','AVL+SU2+WT','FontWeight','bold');
box on; grid on;
saveas(gcf,'images/trim_aoa_sf_vs_mf.png');
% set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);
end

