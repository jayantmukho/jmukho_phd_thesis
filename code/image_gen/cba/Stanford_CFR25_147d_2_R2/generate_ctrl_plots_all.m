function [] = generate_ctrl_plots_all(perf_metrics_MC,perf_metrics_MC2,perf_metrics_MC3,perf_metrics_MC4,perf_metrics_MC5,perf_metrics_mean,perf_metrics_mean2,perf_metrics_mean3,perf_metrics_mean4,perf_metrics_mean5)

%% Elevator metric
elev_list = [perf_metrics_MC.normal.elev_deg.max;perf_metrics_MC.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f1,x1] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC.rightout.elev_deg.max;perf_metrics_MC.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f2,x2] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC.leftout.elev_deg.max;perf_metrics_MC.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f3,x3] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC2.normal.elev_deg.max;perf_metrics_MC2.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f4,x4] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC2.rightout.elev_deg.max;perf_metrics_MC2.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f5,x5] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC2.leftout.elev_deg.max;perf_metrics_MC2.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f6,x6] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC3.normal.elev_deg.max;perf_metrics_MC3.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f7,x7] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC3.rightout.elev_deg.max;perf_metrics_MC3.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f8,x8] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC3.leftout.elev_deg.max;perf_metrics_MC3.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f9,x9] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC4.normal.elev_deg.max;perf_metrics_MC4.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f10,x10] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC4.rightout.elev_deg.max;perf_metrics_MC4.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f11,x11] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC4.leftout.elev_deg.max;perf_metrics_MC4.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f12,x12] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC5.normal.elev_deg.max;perf_metrics_MC5.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f13,x13] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC5.rightout.elev_deg.max;perf_metrics_MC5.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f14,x14] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_MC5.leftout.elev_deg.max;perf_metrics_MC5.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
[f15,x15] = ecdf(elev_list(1,:));

elev_list = [perf_metrics_mean.normal.elev_deg.max;perf_metrics_mean.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m1 = elev_list(idx_max);

elev_list = [perf_metrics_mean.rightout.elev_deg.max;perf_metrics_mean.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m2 = elev_list(1,:);

elev_list = [perf_metrics_mean.leftout.elev_deg.max;perf_metrics_mean.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m3 = elev_list(1,:);

elev_list = [perf_metrics_mean2.normal.elev_deg.max;perf_metrics_mean2.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m4 = elev_list(1,:);

elev_list = [perf_metrics_mean2.rightout.elev_deg.max;perf_metrics_mean2.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m5 = elev_list(1,:);

elev_list = [perf_metrics_mean2.leftout.elev_deg.max;perf_metrics_mean2.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m6 = elev_list(1,:);

elev_list = [perf_metrics_mean3.normal.elev_deg.max;perf_metrics_mean3.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m7 = elev_list(1,:);

elev_list = [perf_metrics_mean3.rightout.elev_deg.max;perf_metrics_mean3.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m8 = elev_list(1,:);

elev_list = [perf_metrics_mean3.leftout.elev_deg.max;perf_metrics_mean3.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m9 = elev_list(1,:);

elev_list = [perf_metrics_mean4.normal.elev_deg.max;perf_metrics_mean4.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m10 = elev_list(1,:);

elev_list = [perf_metrics_mean4.rightout.elev_deg.max;perf_metrics_mean4.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m11 = elev_list(1,:);

elev_list = [perf_metrics_mean4.leftout.elev_deg.max;perf_metrics_mean4.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m12 = elev_list(1,:);

elev_list = [perf_metrics_mean5.normal.elev_deg.max;perf_metrics_mean5.normal.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m13 = elev_list(1,:);

elev_list = [perf_metrics_mean5.rightout.elev_deg.max;perf_metrics_mean5.rightout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m14 = elev_list(1,:);

elev_list = [perf_metrics_mean5.leftout.elev_deg.max;perf_metrics_mean5.leftout.elev_deg.min];
[~,idx_max] = max(abs(elev_list)); elev_list = elev_list(idx_max,:);
m15 = elev_list(1,:);


% Engines normal
figure; hold on;
plot(x1,f1,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x4,f4,'LineWidth',2);
plot(x7,f7,'LineWidth',2);
plot(x10,f10,'LineWidth',2);
plot(x13,f13,'LineWidth',2);
plot([m1,m1],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m4,m4],[0 1],'--','LineWidth',2);
plot([m7,m7],[0 1],'--','LineWidth',2);
plot([m10,m10],[0 1],'--','LineWidth',2);
plot([m13,m13],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max Elevator Defl (deg)','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal (Full WT)','Normal (AVL)','Normal (AVL+SU2)','Normal (AVL+SU2+WT)','Normal (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Right out
figure; hold on;
plot(x2,f2,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x5,f5,'LineWidth',2);
plot(x8,f8,'LineWidth',2);
plot(x11,f11,'LineWidth',2);
plot(x14,f14,'LineWidth',2);
plot([m2,m2],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m5,m5],[0 1],'--','LineWidth',2);
plot([m8,m8],[0 1],'--','LineWidth',2);
plot([m11,m11],[0 1],'--','LineWidth',2);
plot([m14,m14],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max Elevator Defl (deg)','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('R. Engine Out (Full WT)','R. Engine Out (AVL)','R. Engine Out (AVL+SU2)','R. Engine Out (AVL+SU2+WT)','R. Engine Out (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Left out
figure; hold on;
plot(x3,f3,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x6,f6,'LineWidth',2);
plot(x9,f9,'LineWidth',2);
plot(x12,f12,'LineWidth',2);
plot(x15,f15,'LineWidth',2);
plot([m3,m3],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m6,m6],[0 1],'--','LineWidth',2);
plot([m9,m9],[0 1],'--','LineWidth',2);
plot([m12,m12],[0 1],'--','LineWidth',2);
plot([m15,m15],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max Elevator Defl (deg)','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('L. Engine Out (Full WT)','L. Engine Out (AVL)','L. Engine Out (AVL+SU2)','L. Engine Out (AVL+SU2+WT)','L. Engine Out (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


%% Aileron metric
ail_list = [perf_metrics_MC.normal.ail_left_deg.max;perf_metrics_MC.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f1,x1] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC.rightout.ail_left_deg.max;perf_metrics_MC.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f2,x2] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC.leftout.ail_left_deg.max;perf_metrics_MC.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f3,x3] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC2.normal.ail_left_deg.max;perf_metrics_MC2.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f4,x4] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC2.rightout.ail_left_deg.max;perf_metrics_MC2.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f5,x5] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC2.leftout.ail_left_deg.max;perf_metrics_MC2.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f6,x6] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC3.normal.ail_left_deg.max;perf_metrics_MC3.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f7,x7] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC3.rightout.ail_left_deg.max;perf_metrics_MC3.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f8,x8] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC3.leftout.ail_left_deg.max;perf_metrics_MC3.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f9,x9] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC4.normal.ail_left_deg.max;perf_metrics_MC4.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f10,x10] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC4.rightout.ail_left_deg.max;perf_metrics_MC4.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f11,x11] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC4.leftout.ail_left_deg.max;perf_metrics_MC4.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f12,x12] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC5.normal.ail_left_deg.max;perf_metrics_MC5.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f13,x13] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC5.rightout.ail_left_deg.max;perf_metrics_MC5.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f14,x14] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_MC5.leftout.ail_left_deg.max;perf_metrics_MC5.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
[f15,x15] = ecdf(ail_list(1,:));

ail_list = [perf_metrics_mean.normal.ail_left_deg.max;perf_metrics_mean.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m1 = ail_list(1,:);

ail_list = [perf_metrics_mean.rightout.ail_left_deg.max;perf_metrics_mean.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m2 = ail_list(1,:);

ail_list = [perf_metrics_mean.leftout.ail_left_deg.max;perf_metrics_mean.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m3 = ail_list(1,:);

ail_list = [perf_metrics_mean2.normal.ail_left_deg.max;perf_metrics_mean2.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m4 = ail_list(1,:);

ail_list = [perf_metrics_mean2.rightout.ail_left_deg.max;perf_metrics_mean2.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m5 = ail_list(1,:);

ail_list = [perf_metrics_mean2.leftout.ail_left_deg.max;perf_metrics_mean2.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m6 = ail_list(1,:);

ail_list = [perf_metrics_mean3.normal.ail_left_deg.max;perf_metrics_mean3.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m7 = ail_list(1,:);

ail_list = [perf_metrics_mean3.rightout.ail_left_deg.max;perf_metrics_mean3.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m8 = ail_list(1,:);

ail_list = [perf_metrics_mean3.leftout.ail_left_deg.max;perf_metrics_mean3.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m9 = ail_list(1,:);

ail_list = [perf_metrics_mean4.normal.ail_left_deg.max;perf_metrics_mean4.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m10 = ail_list(1,:);

ail_list = [perf_metrics_mean4.rightout.ail_left_deg.max;perf_metrics_mean4.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m11 = ail_list(1,:);

ail_list = [perf_metrics_mean4.leftout.ail_left_deg.max;perf_metrics_mean4.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m12 = ail_list(1,:);

ail_list = [perf_metrics_mean5.normal.ail_left_deg.max;perf_metrics_mean5.normal.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m13 = ail_list(1,:);

ail_list = [perf_metrics_mean5.rightout.ail_left_deg.max;perf_metrics_mean5.rightout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m14 = ail_list(1,:);

ail_list = [perf_metrics_mean5.leftout.ail_left_deg.max;perf_metrics_mean5.leftout.ail_left_deg.min];
[~,idx_max] = max(abs(ail_list)); ail_list = ail_list(idx_max,:);
m15 = ail_list(1,:);

% Engines normal
figure; hold on;
plot(x1,f1,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x4,f4,'LineWidth',2);
plot(x7,f7,'LineWidth',2);
plot(x10,f10,'LineWidth',2);
plot(x13,f13,'LineWidth',2);
plot([m1,m1],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m4,m4],[0 1],'--','LineWidth',2);
plot([m7,m7],[0 1],'--','LineWidth',2);
plot([m10,m10],[0 1],'--','LineWidth',2);
plot([m13,m13],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max L. Aileron Defl','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal (Full WT)','Normal (AVL)','Normal (AVL+SU2)','Normal (AVL+SU2+WT)','Normal (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Right out
figure; hold on;
plot(x2,f2,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x5,f5,'LineWidth',2);
plot(x8,f8,'LineWidth',2);
plot(x11,f11,'LineWidth',2);
plot(x14,f14,'LineWidth',2);
plot([m2,m2],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m5,m5],[0 1],'--','LineWidth',2);
plot([m8,m8],[0 1],'--','LineWidth',2);
plot([m11,m11],[0 1],'--','LineWidth',2);
plot([m14,m14],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max L. Aileron Defl','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('R. Engine Out (Full WT)','R. Engine Out (AVL)','R. Engine Out (AVL+SU2)','R. Engine Out (AVL+SU2+WT)','R. Engine Out (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Left out
figure; hold on;
plot(x3,f3,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x6,f6,'LineWidth',2);
plot(x9,f9,'LineWidth',2);
plot(x12,f12,'LineWidth',2);
plot(x15,f15,'LineWidth',2);
plot([m3,m3],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m6,m6],[0 1],'--','LineWidth',2);
plot([m9,m9],[0 1],'--','LineWidth',2);
plot([m12,m12],[0 1],'--','LineWidth',2);
plot([m15,m15],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max L. Aileron Defl','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('L. Engine Out (Full WT)','L. Engine Out (AVL)','L. Engine Out (AVL+SU2)','L. Engine Out (AVL+SU2+WT)','L. Engine Out (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


%% Rudder metric
rud_list = [perf_metrics_MC.normal.rud_deg.max;perf_metrics_MC.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f1,x1] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC.rightout.rud_deg.max;perf_metrics_MC.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f2,x2] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC.leftout.rud_deg.max;perf_metrics_MC.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f3,x3] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC2.normal.rud_deg.max;perf_metrics_MC2.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f4,x4] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC2.rightout.rud_deg.max;perf_metrics_MC2.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f5,x5] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC2.leftout.rud_deg.max;perf_metrics_MC2.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f6,x6] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC3.normal.rud_deg.max;perf_metrics_MC3.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f7,x7] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC3.rightout.rud_deg.max;perf_metrics_MC3.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f8,x8] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC3.leftout.rud_deg.max;perf_metrics_MC3.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f9,x9] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC4.normal.rud_deg.max;perf_metrics_MC4.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f10,x10] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC4.rightout.rud_deg.max;perf_metrics_MC4.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f11,x11] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC4.leftout.rud_deg.max;perf_metrics_MC4.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f12,x12] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC5.normal.rud_deg.max;perf_metrics_MC5.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f13,x13] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC5.rightout.rud_deg.max;perf_metrics_MC5.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f14,x14] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_MC5.leftout.rud_deg.max;perf_metrics_MC5.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
[f15,x15] = ecdf(rud_list(1,:));

rud_list = [perf_metrics_mean.normal.rud_deg.max;perf_metrics_mean.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m1 = rud_list(1,:);

rud_list = [perf_metrics_mean.rightout.rud_deg.max;perf_metrics_mean.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m2 = rud_list(1,:);

rud_list = [perf_metrics_mean.leftout.rud_deg.max;perf_metrics_mean.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m3 = rud_list(1,:);

rud_list = [perf_metrics_mean2.normal.rud_deg.max;perf_metrics_mean2.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m4 = rud_list(1,:);

rud_list = [perf_metrics_mean2.rightout.rud_deg.max;perf_metrics_mean2.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m5 = rud_list(1,:);

rud_list = [perf_metrics_mean2.leftout.rud_deg.max;perf_metrics_mean2.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m6 = rud_list(1,:);

rud_list = [perf_metrics_mean3.normal.rud_deg.max;perf_metrics_mean3.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m7 = rud_list(1,:);

rud_list = [perf_metrics_mean3.rightout.rud_deg.max;perf_metrics_mean3.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m8 = rud_list(1,:);

rud_list = [perf_metrics_mean3.leftout.rud_deg.max;perf_metrics_mean3.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m9 = rud_list(1,:);

rud_list = [perf_metrics_mean4.normal.rud_deg.max;perf_metrics_mean4.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m10 = rud_list(1,:);

rud_list = [perf_metrics_mean4.rightout.rud_deg.max;perf_metrics_mean4.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m11 = rud_list(1,:);

rud_list = [perf_metrics_mean4.leftout.rud_deg.max;perf_metrics_mean4.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m12 = rud_list(1,:);

rud_list = [perf_metrics_mean5.normal.rud_deg.max;perf_metrics_mean5.normal.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m13 = rud_list(1,:);

rud_list = [perf_metrics_mean5.rightout.rud_deg.max;perf_metrics_mean5.rightout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m14 = rud_list(1,:);

rud_list = [perf_metrics_mean5.leftout.rud_deg.max;perf_metrics_mean5.leftout.rud_deg.min];
[~,idx_max] = max(abs(rud_list)); rud_list = rud_list(idx_max,:);
m15 = rud_list(1,:);

% Engines normal
figure; hold on;
plot(x1,f1,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x4,f4,'LineWidth',2);
plot(x7,f7,'LineWidth',2);
plot(x10,f10,'LineWidth',2);
plot(x13,f13,'LineWidth',2);
plot([m1,m1],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m4,m4],[0 1],'--','LineWidth',2);
plot([m7,m7],[0 1],'--','LineWidth',2);
plot([m10,m10],[0 1],'--','LineWidth',2);
plot([m13,m13],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max Rudder Defl','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('Normal (Full WT)','Normal (AVL)','Normal (AVL+SU2)','Normal (AVL+SU2+WT)','Normal (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Right out
figure; hold on;
plot(x2,f2,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x5,f5,'LineWidth',2);
plot(x8,f8,'LineWidth',2);
plot(x11,f11,'LineWidth',2);
plot(x14,f14,'LineWidth',2);
plot([m2,m2],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m5,m5],[0 1],'--','LineWidth',2);
plot([m8,m8],[0 1],'--','LineWidth',2);
plot([m11,m11],[0 1],'--','LineWidth',2);
plot([m14,m14],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max Rudder Defl','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('R. Engine Out (Full WT)','R. Engine Out (AVL)','R. Engine Out (AVL+SU2)','R. Engine Out (AVL+SU2+WT)','R. Engine Out (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);


% Left out
figure; hold on;
plot(x3,f3,'k','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot(x6,f6,'LineWidth',2);
plot(x9,f9,'LineWidth',2);
plot(x12,f12,'LineWidth',2);
plot(x15,f15,'LineWidth',2);
plot([m3,m3],[0 1],'k--','LineWidth',2);
set(gca,'ColorOrderIndex',1);
plot([m6,m6],[0 1],'--','LineWidth',2);
plot([m9,m9],[0 1],'--','LineWidth',2);
plot([m12,m12],[0 1],'--','LineWidth',2);
plot([m15,m15],[0 1],'--','LineWidth',2);
set(gca,'FontSize',12,'FontWeight','bold');
xlabel('Max Rudder Defl','FontWeight','bold');
ylabel('Cumulative Probability','FontWeight','bold');
legend('L. Engine Out (Full WT)','L. Engine Out (AVL)','L. Engine Out (AVL+SU2)','L. Engine Out (AVL+SU2+WT)','L. Engine Out (Sparse WT)','FontWeight','bold','Location','Best');
%set(gcf,'Position',[312,456,1084,420]);
% xlim([-0.1, 0.8]);

end

