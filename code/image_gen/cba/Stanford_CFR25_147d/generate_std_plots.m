function figs = generate_std_plots(perf_metrics_MC,perf_metrics_mean)
%UNTITLED2 Summary of this function goes here
fs = 18;
lw = 3;
set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)
lims = [-0.1, 0.9];
figs = {};

figs{1} = figure('units','inch','position',[0,0,8,5]); clf; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.pitch);
[f2,x2] = ecdf(perf_metrics_MC.rightout.pitch);
[f3,x3] = ecdf(perf_metrics_MC.leftout.pitch);
plot(x1,f1,'LineWidth',lw);
plot(x2,f2,'LineWidth',lw);
plot(x3,f3,'LineWidth',lw)
set(gca,'ColorOrderIndex',1)
plot([perf_metrics_mean.normal.pitch,perf_metrics_mean.normal.pitch],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.rightout.pitch,perf_metrics_mean.rightout.pitch],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.leftout.pitch,perf_metrics_mean.leftout.pitch],[0 1],'--','LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Pitch Metric');
ylabel('Cumulative Probability');
% legend('Normal','R. Engine Out','L. Engine Out');
grid on
box on
axis square
xlim(lims);
sr_nominal = sum(perf_metrics_MC.normal.pitch>0)/10;
sr_reo = sum(perf_metrics_MC.rightout.pitch>0)/10;
sr_leo = sum(perf_metrics_MC.leftout.pitch>0)/10;

fprintf('Pitch Metric success rate, Normal = %2.2f \n',sr_nominal);
fprintf('Pitch Metric success rate, LEO = %2.2f \n',sr_reo);
fprintf('Pitch Metric success rate, REO = %2.2f \n',sr_leo);

figs{2} = figure('units','inch','position',[0,0,8,5]); clf; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.roll);
[f2,x2] = ecdf(perf_metrics_MC.rightout.roll);
[f3,x3] = ecdf(perf_metrics_MC.leftout.roll);
plot(x1,f1,'LineWidth',lw);
plot(x2,f2,'LineWidth',lw);
plot(x3,f3,'LineWidth',lw)
set(gca,'ColorOrderIndex',1)
plot([perf_metrics_mean.normal.roll,perf_metrics_mean.normal.roll],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.rightout.roll,perf_metrics_mean.rightout.roll],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.leftout.roll,perf_metrics_mean.leftout.roll],[0 1],'--','LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Roll Metric');
ylabel('Cumulative Probability');
% legend('Normal','R. Engine Out','L. Engine Out');
grid on
box on
axis square
xlim(lims);

sr_nominal = sum(perf_metrics_MC.normal.roll>0)/10;
sr_reo = sum(perf_metrics_MC.rightout.roll>0)/10;
sr_leo = sum(perf_metrics_MC.leftout.roll>0)/10;

fprintf('Roll Metric success rate, Normal = %2.2f \n',sr_nominal);
fprintf('Roll Metric success rate, LEO = %2.2f \n',sr_reo);
fprintf('Roll Metric success rate, REO = %2.2f \n',sr_leo);

figs{3} = figure('units','inch','position',[0,0,8,5]); clf; hold on;
[f1,x1] = ecdf(perf_metrics_MC.normal.yaw);
[f2,x2] = ecdf(perf_metrics_MC.rightout.yaw);
[f3,x3] = ecdf(perf_metrics_MC.leftout.yaw);
plot(x1,f1,'LineWidth',lw);
plot(x2,f2,'LineWidth',lw);
plot(x3,f3,'LineWidth',lw)
set(gca,'ColorOrderIndex',1)
plot([perf_metrics_mean.normal.yaw,perf_metrics_mean.normal.yaw],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.rightout.yaw,perf_metrics_mean.rightout.yaw],[0 1],'--','LineWidth',lw);
plot([perf_metrics_mean.leftout.yaw,perf_metrics_mean.leftout.yaw],[0 1],'--','LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Yaw Metric');
ylabel('Cumulative Probability');
% legend('Normal','R. Engine Out','L. Engine Out');
grid on
box on
axis square
xlim(lims);
sr_nominal = sum(perf_metrics_MC.normal.yaw>0)/10;
sr_reo = sum(perf_metrics_MC.rightout.yaw>0)/10;
sr_leo = sum(perf_metrics_MC.leftout.yaw>0)/10;

fprintf('Yaw Metric success rate, Normal = %2.2f \n',sr_nominal);
fprintf('Yaw Metric success rate, LEO = %2.2f \n',sr_reo);
fprintf('Yaw Metric success rate, REO = %2.2f \n',sr_leo);

end

