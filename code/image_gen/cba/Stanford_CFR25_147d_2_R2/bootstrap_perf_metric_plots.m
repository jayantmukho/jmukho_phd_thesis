function [] = bootstrap_perf_metric_plots(perf_metrics_MC,   perf_metrics_MC2,   perf_metrics_MC3,   perf_metrics_MC4,   perf_metrics_MC5,...
    perf_metrics_mean, perf_metrics_mean2, perf_metrics_mean3, perf_metrics_mean4, perf_metrics_mean5,...
    perf_ctrl_MC,      perf_ctrl_MC2,      perf_ctrl_MC3,      perf_ctrl_MC4,      perf_ctrl_MC5,...
    perf_ctrl_mean,    perf_ctrl_mean2,    perf_ctrl_mean3,    perf_ctrl_mean4,    perf_ctrl_mean5)
% setup_plots(plotting_options('thesis'));
rng(1);
%% Recalculate Metrics
% Recompute metrics with a smaller deflection limit range
%   Original saturation limits: delta_ail = [-25,25] deg
%   New saturation limits: delta_ail = [-15,15] deg
old_ail_lim = 25;
new_ail_lim = 15;
perf_metrics_MC.normal.roll2    = (perf_metrics_MC.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC.rightout.roll2  = (perf_metrics_MC.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC.leftout.roll2   = (perf_metrics_MC.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC2.normal.roll2   = (perf_metrics_MC2.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC2.rightout.roll2 = (perf_metrics_MC2.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC2.leftout.roll2  = (perf_metrics_MC2.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC3.normal.roll2   = (perf_metrics_MC3.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC3.rightout.roll2 = (perf_metrics_MC3.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC3.leftout.roll2  = (perf_metrics_MC3.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC4.normal.roll2   = (perf_metrics_MC4.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC4.rightout.roll2 = (perf_metrics_MC4.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC4.leftout.roll2  = (perf_metrics_MC4.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC5.normal.roll2   = (perf_metrics_MC5.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC5.rightout.roll2 = (perf_metrics_MC5.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_MC5.leftout.roll2  = (perf_metrics_MC5.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.normal.roll2  = (perf_metrics_mean.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean2.normal.roll2 = (perf_metrics_mean2.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean3.normal.roll2 = (perf_metrics_mean3.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean4.normal.roll2 = (perf_metrics_mean4.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean5.normal.roll2 = (perf_metrics_mean5.normal.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.rightout.roll2  = (perf_metrics_mean.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean2.rightout.roll2 = (perf_metrics_mean2.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean3.rightout.roll2 = (perf_metrics_mean3.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean4.rightout.roll2 = (perf_metrics_mean4.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean5.rightout.roll2 = (perf_metrics_mean5.rightout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean.leftout.roll2  = (perf_metrics_mean.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean2.leftout.roll2 = (perf_metrics_mean2.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean3.leftout.roll2 = (perf_metrics_mean3.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean4.leftout.roll2 = (perf_metrics_mean4.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;
perf_metrics_mean5.leftout.roll2 = (perf_metrics_mean5.leftout.roll*old_ail_lim - (old_ail_lim-new_ail_lim))/new_ail_lim;

% Recompute metrics with a smaller deflection limit range
%   Original saturation limits: delta_rud = [-30,30] deg
%   New saturation limits: delta_rud = [-20,20] deg
old_rud_lim = 30;
new_rud_lim = 20;
perf_metrics_MC.normal.yaw2    = (perf_metrics_MC.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC.rightout.yaw2  = (perf_metrics_MC.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC.leftout.yaw2   = (perf_metrics_MC.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC2.normal.yaw2   = (perf_metrics_MC2.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC2.rightout.yaw2 = (perf_metrics_MC2.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC2.leftout.yaw2  = (perf_metrics_MC2.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC3.normal.yaw2   = (perf_metrics_MC3.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC3.rightout.yaw2 = (perf_metrics_MC3.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC3.leftout.yaw2  = (perf_metrics_MC3.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC4.normal.yaw2   = (perf_metrics_MC4.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC4.rightout.yaw2 = (perf_metrics_MC4.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC4.leftout.yaw2  = (perf_metrics_MC4.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC5.normal.yaw2   = (perf_metrics_MC5.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC5.rightout.yaw2 = (perf_metrics_MC5.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_MC5.leftout.yaw2  = (perf_metrics_MC5.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.normal.yaw2  = (perf_metrics_mean.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean2.normal.yaw2 = (perf_metrics_mean2.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean3.normal.yaw2 = (perf_metrics_mean3.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean4.normal.yaw2 = (perf_metrics_mean4.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean5.normal.yaw2 = (perf_metrics_mean5.normal.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.rightout.yaw2  = (perf_metrics_mean.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean2.rightout.yaw2 = (perf_metrics_mean2.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean3.rightout.yaw2 = (perf_metrics_mean3.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean4.rightout.yaw2 = (perf_metrics_mean4.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean5.rightout.yaw2 = (perf_metrics_mean5.rightout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean.leftout.yaw2  = (perf_metrics_mean.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean2.leftout.yaw2 = (perf_metrics_mean2.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean3.leftout.yaw2 = (perf_metrics_mean3.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean4.leftout.yaw2 = (perf_metrics_mean4.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;
perf_metrics_mean5.leftout.yaw2 = (perf_metrics_mean5.leftout.yaw*old_rud_lim - (old_rud_lim-new_rud_lim))/new_rud_lim;

n = length(perf_metrics_MC.normal.roll); % size of each bootstrap sample
m = n;  % number of bootstrap samples

weights = sort(rand(m,length(perf_metrics_MC.normal.roll)-1),2);
weights = [zeros(m,1) weights ones(m,1)];
weights = diff(weights,1,2);
% weights = ones(m,n)./n;

for i = 1:m
    y_samp = datasample(1:length(perf_metrics_MC.normal.roll),n,'weights',weights(i,:));
    
    %% Roll metric
    bootstrap_MC.roll.metrics(i,:) =  perf_metrics_MC.rightout.roll2(y_samp);
    bootstrap_MC2.roll.metrics(i,:) = perf_metrics_MC2.rightout.roll2(y_samp);
    bootstrap_MC3.roll.metrics(i,:) = perf_metrics_MC3.rightout.roll2(y_samp);
    bootstrap_MC4.roll.metrics(i,:) = perf_metrics_MC4.rightout.roll2(y_samp);
    bootstrap_MC5.roll.metrics(i,:) = perf_metrics_MC5.rightout.roll2(y_samp);
    
    [f1,x1] = ecdf(bootstrap_MC.roll.metrics(i,:));
    [f2,x2] = ecdf(bootstrap_MC2.roll.metrics(i,:));
    [f3,x3] = ecdf(bootstrap_MC3.roll.metrics(i,:));
    [f4,x4] = ecdf(bootstrap_MC4.roll.metrics(i,:));
    [f5,x5] = ecdf(bootstrap_MC5.roll.metrics(i,:));
    
    bootstrap_MC.roll.failure_rate(i)  = sum(bootstrap_MC.roll.metrics(i,:)<0)/length(y_samp);
    bootstrap_MC2.roll.failure_rate(i) = sum(bootstrap_MC2.roll.metrics(i,:)<0)/length(y_samp);
    bootstrap_MC3.roll.failure_rate(i) = sum(bootstrap_MC3.roll.metrics(i,:)<0)/length(y_samp);
    bootstrap_MC4.roll.failure_rate(i) = sum(bootstrap_MC4.roll.metrics(i,:)<0)/length(y_samp);
    bootstrap_MC5.roll.failure_rate(i) = sum(bootstrap_MC5.roll.metrics(i,:)<0)/length(y_samp);
    bootstrap_MC.roll.aileron_95(i)  = new_ail_lim-x1(find(f1<=0.0501,1,'last'))*new_ail_lim;
    bootstrap_MC2.roll.aileron_95(i) = new_ail_lim-x2(find(f2<=0.0501,1,'last'))*new_ail_lim;
    bootstrap_MC3.roll.aileron_95(i) = new_ail_lim-x3(find(f3<=0.0501,1,'last'))*new_ail_lim;
    bootstrap_MC4.roll.aileron_95(i) = new_ail_lim-x4(find(f4<=0.0501,1,'last'))*new_ail_lim;
    bootstrap_MC5.roll.aileron_95(i) = new_ail_lim-x5(find(f5<=0.0501,1,'last'))*new_ail_lim;
    bootstrap_MC.roll.aileron_100(i)  = new_ail_lim-x1(1)*new_ail_lim;
    bootstrap_MC2.roll.aileron_100(i) = new_ail_lim-x2(1)*new_ail_lim;
    bootstrap_MC3.roll.aileron_100(i) = new_ail_lim-x3(1)*new_ail_lim;
    bootstrap_MC4.roll.aileron_100(i) = new_ail_lim-x4(1)*new_ail_lim;
    bootstrap_MC5.roll.aileron_100(i) = new_ail_lim-x5(1)*new_ail_lim;
    
    
    
end
bootstrap_MC.roll.aileron_95_mean = sum(bootstrap_MC.roll.aileron_95);
bootstrap_MC2.roll.aileron_95_mean = sum(bootstrap_MC2.roll.aileron_95);
bootstrap_MC3.roll.aileron_95_mean = sum(bootstrap_MC3.roll.aileron_95);
bootstrap_MC4.roll.aileron_95_mean = sum(bootstrap_MC4.roll.aileron_95);
bootstrap_MC5.roll.aileron_95_mean = sum(bootstrap_MC5.roll.aileron_95);

bootstrap_MC.roll.aileron_100_mean = sum(bootstrap_MC.roll.aileron_100);
bootstrap_MC2.roll.aileron_100_mean = sum(bootstrap_MC2.roll.aileron_100);
bootstrap_MC3.roll.aileron_100_mean = sum(bootstrap_MC3.roll.aileron_100);
bootstrap_MC4.roll.aileron_100_mean = sum(bootstrap_MC4.roll.aileron_100);
bootstrap_MC5.roll.aileron_100_mean = sum(bootstrap_MC5.roll.aileron_100);

% for i = 1:n
%     %% Roll metric
%     bootstrap_MC.roll.metrics(i,:)./weights(i,:) - ;
%     bootstrap_MC2.roll.metrics(i,:) = perf_metrics_MC2.rightout.roll2(y_samp).*weights(i,:);
%     bootstrap_MC3.roll.metrics(i,:) = perf_metrics_MC3.rightout.roll2(y_samp).*weights(i,:);
%     bootstrap_MC4.roll.metrics(i,:) = perf_metrics_MC4.rightout.roll2(y_samp).*weights(i,:);
%     bootstrap_MC5.roll.metrics(i,:) = perf_metrics_MC5.rightout.roll2(y_samp).*weights(i,:);
%
%     [f1,x1] = ecdf(bootstrap_MC.roll.metrics(i,:));
%     [f2,x2] = ecdf(bootstrap_MC2.roll.metrics(i,:));
%     [f3,x3] = ecdf(bootstrap_MC3.roll.metrics(i,:));
%     [f4,x4] = ecdf(bootstrap_MC4.roll.metrics(i,:));
%     [f5,x5] = ecdf(bootstrap_MC5.roll.metrics(i,:));
%
%     bootstrap_MC.roll.failure_rate(i)  = sum(bootstrap_MC.roll.metrics(i,:)<0)/length(y_samp);
%     bootstrap_MC2.roll.failure_rate(i) = sum(bootstrap_MC2.roll.metrics(i,:)<0)/length(y_samp);
%     bootstrap_MC3.roll.failure_rate(i) = sum(bootstrap_MC3.roll.metrics(i,:)<0)/length(y_samp);
%     bootstrap_MC4.roll.failure_rate(i) = sum(bootstrap_MC4.roll.metrics(i,:)<0)/length(y_samp);
%     bootstrap_MC5.roll.failure_rate(i) = sum(bootstrap_MC5.roll.metrics(i,:)<0)/length(y_samp);
%     bootstrap_MC.roll.aileron_95(i)  = x1(find(f1<=0.0501,1,'last'));
%     bootstrap_MC2.roll.aileron_95(i) = x2(find(f2<=0.0501,1,'last'));
%     bootstrap_MC3.roll.aileron_95(i) = x3(find(f3<=0.0501,1,'last'));
%     bootstrap_MC4.roll.aileron_95(i) = x4(find(f4<=0.0501,1,'last'));
%     bootstrap_MC5.roll.aileron_95(i) = x5(find(f5<=0.0501,1,'last'));
%     bootstrap_MC.roll.aileron_100(i)  = x1(1);
%     bootstrap_MC2.roll.aileron_100(i) = x2(1);
%     bootstrap_MC3.roll.aileron_100(i) = x3(1);
%     bootstrap_MC4.roll.aileron_100(i) = x4(1);
%     bootstrap_MC5.roll.aileron_100(i) = x5(1);
%
%
% end

figure;
set_figure_size(gcf,6,8)

h = subplot(3,2,1);
histogram(bootstrap_MC.roll.failure_rate);
hold on;
plot(mean(bootstrap_MC.roll.failure_rate)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC.roll.failure_rate);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,2);
histogram(bootstrap_MC2.roll.failure_rate);
hold on;
plot(mean(bootstrap_MC2.roll.failure_rate)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC2.roll.failure_rate);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,3);
histogram(bootstrap_MC3.roll.failure_rate);
hold on;
plot(mean(bootstrap_MC3.roll.failure_rate)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC3.roll.failure_rate);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,4);
histogram(bootstrap_MC4.roll.failure_rate);
hold on;
plot(mean(bootstrap_MC4.roll.failure_rate)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC4.roll.failure_rate);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,5);
histogram(bootstrap_MC5.roll.failure_rate);
hold on;
plot(mean(bootstrap_MC5.roll.failure_rate)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC5.roll.failure_rate);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')


figure;
set_figure_size(gcf,6,8)
h = subplot(3,2,1);
histogram(bootstrap_MC.roll.aileron_95);
hold on;
plot(mean(bootstrap_MC.roll.aileron_95)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC.roll.aileron_95);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,2);
histogram(bootstrap_MC2.roll.aileron_95);
hold on;
plot(mean(bootstrap_MC2.roll.aileron_95)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC2.roll.aileron_95);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,3);
histogram(bootstrap_MC3.roll.aileron_95);
hold on;
plot(mean(bootstrap_MC3.roll.aileron_95)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC3.roll.aileron_95);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,4);
histogram(bootstrap_MC4.roll.aileron_95);
hold on;
plot(mean(bootstrap_MC4.roll.aileron_95)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC4.roll.aileron_95);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,5);
histogram(bootstrap_MC5.roll.aileron_95);
hold on;
plot(mean(bootstrap_MC5.roll.aileron_95)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC5.roll.aileron_95);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

figure;
set_figure_size(gcf,6,8)
h = subplot(3,2,1);
histogram(bootstrap_MC.roll.aileron_100);
hold on;
plot(mean(bootstrap_MC.roll.aileron_100)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC.roll.aileron_100);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,2);
histogram(bootstrap_MC2.roll.aileron_100);
hold on;
plot(mean(bootstrap_MC2.roll.aileron_100)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC2.roll.aileron_100);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,3);
histogram(bootstrap_MC3.roll.aileron_100);
hold on;
plot(mean(bootstrap_MC3.roll.aileron_100)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC3.roll.aileron_100);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,4);
histogram(bootstrap_MC4.roll.aileron_100);
hold on;
plot(mean(bootstrap_MC4.roll.aileron_100)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC4.roll.aileron_100);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

h = subplot(3,2,5);
histogram(bootstrap_MC5.roll.aileron_100);
hold on;
plot(mean(bootstrap_MC5.roll.aileron_100)*ones(2,1),[0,h.YLim(2)*1.2],'linewidth',2,'color','r')
[f1,x1] = ecdf(bootstrap_MC5.roll.aileron_100);
low_ci = x1(find(f1<=0.0251,1,'last'));
high_ci = x1(find(f1<=0.976,1,'last'));
plot([low_ci,high_ci],[0,0],'linewidth',2,'color','r')

end
