function figs = generate_trajectory_plots(CPR_data_MC,CPR_data_mean,CPA_data_MC,CPA_data_mean)
fs = 18;
lw = 3;
idx_list = 1:10;
use_legend = false;
figs = {};

% Roll Angle
figs{1} = figure('units','inch','position',[0,0,8,5]); clf; hold on;

plot(CPR_data_mean.phi_rad.time,CPR_data_mean.phi_rad.values*180/pi,'k','LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Angle (deg)');
if use_legend
    legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
    set(legend,'NumColumns',2,'Location','Best');
end

% CPR Pdot
figs{2} = figure('units','inch','position',[0,0,8,5]); clf; hold on;

plot(CPR_data_mean.pdot_dps2.time,CPR_data_mean.pdot_dps2.values,'k','LineWidth',lw);
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Roll Acceleration (deg/sec^2)');
if use_legend
    legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
    set(legend,'NumColumns',2,'Location','Best');
end

% CPR Qdot
figs{3} = figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Pitch Acceleration (deg/sec^2)');
if use_legend
    legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
    set(legend,'NumColumns',2,'Location','Best');
end

% CPR Rdot
figs{4} = figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;
set(gca,'FontSize',fs);
xlabel('Time (sec)');
ylabel('Yaw Acceleration (deg/sec^2)');
if use_legend
    legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
    set(legend,'NumColumns',2,'Location','Best');
end

% Aileron
figs{5} = figure('units','inch','position',[0,0,8,8]); clf;
subplot(2,1,1); hold on; i = length(idx_list)+1;
plot(CPA_data_mean.ail_left_deg.time,CPA_data_mean.ail_left_deg.values,'k','LineWidth',lw);
set(gca,'FontSize',fs);
xlim([0 max(CPA_data_MC(end).ail_left_deg.time)-2]);
xlabel('Time (sec)');
ylabel('L. Aileron (deg)');
if use_legend
    legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
    set(legend,'NumColumns',2,'Location','Best');
end
subplot(2,1,2); hold on; i = length(idx_list)+1;
plot(CPA_data_mean.ail_right_deg.time,CPA_data_mean.ail_right_deg.values,'k','LineWidth',lw);
set(gca,'FontSize',fs);
xlim([0 max(CPA_data_MC(end).ail_right_deg.time)-2]);
xlabel('Time (sec)');
ylabel('R. Aileron (deg)');
if use_legend
    legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
    set(legend,'NumColumns',2,'Location','Best');
end

% Rudder
figs{6} = figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;

plot(CPA_data_mean.rud_deg.time,CPA_data_mean.rud_deg.values,'k','LineWidth',lw);
set(gca,'FontSize',fs);
xlim([0 max(CPA_data_MC(end).rud_deg.time)-2]);
xlabel('Time (sec)');
ylabel('Rudder (deg)');
if use_legend
    legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
    set(legend,'NumColumns',2,'Location','Best');
end

% Elevator
figs{7} = figure('units','inch','position',[0,0,8,5]); clf; hold on; i = length(idx_list)+1;

plot(CPA_data_mean.elev_deg.time,CPA_data_mean.elev_deg.values,'k','LineWidth',lw);
set(gca,'FontSize',fs);
xlim([0 max(CPA_data_MC(end).elev_deg.time)-2]);
xlabel('Time (sec)');
ylabel('Elevator (deg)');

if use_legend
    legend('Nominal','Sample 1','Sample 2','Sample 3','Sample 4','Sample 5','Sample 6','Sample 7','Sample 8','Sample 9','Sample 10');
    set(legend,'NumColumns',2,'Location','Best');
end

end

