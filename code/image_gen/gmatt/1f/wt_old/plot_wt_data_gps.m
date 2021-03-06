
load('C:\Users\Mukho\Documents\GitHub\phd_defense\code\GMATT Data\1f\wt\gmatt_wt_3d_plotting.mat');
load GMATT_aero+ctrl_corrected;
GMATT_new = add_zeros(GMATT_new);

fs = 18;
lw = 2.0;
msz= 8;
plot_options = plotting_options('thesis');
plot_options.width = 5;
plot_options.height = 5;
plot_options.font_size = fs;
plot_options.line_width = lw;
setup_plots(plot_options);

close all
%%
alpha_lim = 21;     % upper limit on alpha
ctab = GMATT_WT.CTAB;
ctab_coeffs = fieldnames(ctab);

ctrl = GMATT_WT.CTRL;
ctrl_coeffs = fieldnames(ctrl);

coeff_labels = {'$C_L$';
                '$C_D$';
                '$C_{SF}$';
                '$C_l$';
                '$C_m$';
                '$C_n$';
                '$C_{m_q}$';
                '$C_{n_r}$';
                '$C_{n_p}$';
                '$C_{l_r}$';
                '$C_{l_p}$'};
            
% Setup 3D plot views            
views= zeros(length(coeff_labels),2);
views(:,1) = -37.5;
views(:,2) = 30;
views(3,:) = [-150,30]; % CSFTAB
views(4,:) = [-150,30]; % CRMTAB
views(5,:) = [-215,30]; % CPMTAB
views(6,:) = [60,30];   % CYMTAB

for i=1:length(ctab_coeffs)
    coeff_wt = GMATT_new.CTAB.(ctab_coeffs{i});
    coeff_gp = ctab.(ctab_coeffs{i});
    fields = fieldnames(coeff);
    if ~isfield(coeff_wt,'betaRange')
        % 1D function
        
        figure(i*3); clf;        

        % WT Data 
        [X_WT,Y_WT,sn] = process_wt_data(coeff_wt);
        figure(i*3); clf;
        e=errorbar(X_WT,Y_WT,2*sn,'x');
        xlabel('$\alpha$')
        ylabel(coeff_labels{i})
        hold all
        format_plot(e,plotting_options('thesis'))
        grid('on')
        
        % GP Prediction
        X_GP = coeff_gp.alphaSamp;
        Y_GP = coeff_gp.muSamp;
        sn     = sqrt(diag(coeff_gp.qSamp*coeff_gp.qSamp'));
        fill_x1 = [X_GP;flipud(X_GP)];
        fill_SD = [ Y_GP - 2*sn;...
                    flipud( Y_GP + 2*sn)];
        plot(X_GP, Y_GP,'k','linewidth',2);
        h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);
        
        set_figure_size(gcf,5,5);
        legend('WT Data','GP Mean','$2\sigma$','location','best')
        grid('on')
        xlim([-4,20]);
        savefig(gcf,['figs/gps/', ctab_coeffs{i},'.fig']);
        saveas(gcf,['images/gps/', ctab_coeffs{i},'.png'])
    
    else

        % WT Data
        [X_WT,Y_WT,~] = process_wt_data(coeff_wt);
        inds_b = X_WT(:,2)>-0.5;
        X_WT = X_WT(inds_b,:);
        Y_WT = Y_WT(inds_b);
        
        % GP Prediction
        [X1_S,X2_S] = meshgrid(coeff_gp.alphaSamp',coeff_gp.betaSamp');
        Mu_S = reshape(coeff_gp.muSamp,size(X1_S'))';        
        
        % 3D plot with all data
        figure(i*3-2); clf;
        plot3(X_WT(:,1),X_WT(:,2),Y_WT,'kx');
        xlabel('$\alpha$');
        ylabel('$\beta$');
        zlabel(coeff_labels{i});
        hold all
        surf(X1_S,X2_S,Mu_S,'facealpha',0.75);
        set_figure_size(gcf,5,5);
        xlim([-5,25])
        view(views(i,:));
        grid('on')
        legend('WT Data','location','northeast')
        savefig(gcf,['figs/gps/', ctab_coeffs{i},'.fig']);
        saveas(gcf,['images/gps/', ctab_coeffs{i},'.png'])
        
       
        % 1D plot for beta = 4
        figure(i*3-1); clf;
        
        % WT Data
        [X_WT,Y_WT,sn] = process_wt_data(coeff_wt);
        inds_b = abs(X_WT(:,2)-4)<0.5;
        X_WT = X_WT(inds_b,:);
        Y_WT = Y_WT(inds_b);
        sn = sn(inds_b);
        e = errorbar(X_WT(:,1),Y_WT,sn/2,'kx');
        format_plot(e,plotting_options('thesis'))
        xlabel('$\alpha$');
        ylabel(coeff_labels{i});
        hold all
        
        % GP Predictions
        inds = X2_S == 4;
        X_GP = X1_S(inds);
        Y_GP = reshape(coeff_gp.muSamp,size(X1_S'))';
        Y_GP = Y_GP(inds);
        sn_GP   = reshape(sqrt(diag(coeff_gp.qSamp*coeff_gp.qSamp')),size(X1_S'))';
        sn_GP   = sn_GP(inds);
        fill_x1 = [X_GP;flipud(X_GP)];
        fill_SD = [ Y_GP - 2*sn_GP;...
                    flipud( Y_GP + 2*sn_GP)];
        plot(X_GP(:,1), Y_GP,'k','linewidth',2);
        h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);
        
        format_plot(e,plotting_options('thesis'))
        set_figure_size(gcf,5,5);
        xlim([-4,20]);
        grid('on')
        legend('WT Data','GP Mean','$2\sigma$','location','best')
        savefig(gcf,['figs/gps/', ctab_coeffs{i},'_beta=4.fig']);
        saveas(gcf,['images/gps/', ctab_coeffs{i},'_beta=4.png'])
        
        % 1D plot for alpha = 8
        figure(i*3); clf;
        
        % WT Data
        [X_WT,Y_WT,sn] = process_wt_data(coeff_wt);
        inds_a = abs(X_WT(:,1)-8)<0.7;
        X_WT = X_WT(inds_a,:);
        Y_WT = Y_WT(inds_a);
        sn = sn(inds_a);
        e = errorbar(X_WT(:,2),Y_WT,sn/2,'kx');
        format_plot(e,plotting_options('thesis'))
        hold all
        
        % GP Predictions
        X_GP = combvec(coeff_gp.alphaSamp',coeff_gp.betaSamp')';
        Y_GP = coeff_gp.muSamp;
        sn   = sqrt(diag(coeff_gp.qSamp*coeff_gp.qSamp'));
        inds_a = abs(X_GP(:,1)-8)<0.5;
        X_GP = X_GP(inds_a,:);
        X_GP = [flipud([X_GP(:,1), -X_GP(:,2)]); X_GP];
        Y_GP = Y_GP(inds_a,:);
        if i == 3 || i == 4 || i == 6
            Y_GP = [flipud(-Y_GP); Y_GP];
        else
            Y_GP = [flipud(Y_GP); Y_GP];
        end
        sn   = sn(inds_a,:);
        sn  = [ flipud(sn); sn];
        fill_x1 = [X_GP;flipud(X_GP)];
        fill_SD = [ Y_GP - 2*sn;...
                    flipud( Y_GP + 2*sn)];
        plot(X_GP(:,2), Y_GP,'k','linewidth',2);
        h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);

        set_figure_size(gcf,5,5);
        xlabel('$\beta$');
        ylabel(coeff_labels{i});
        grid('on')
        legend('WT Data','GP Mean','$2\sigma$','location','best')
        savefig(gcf,['figs/gps/', ctab_coeffs{i},'_alpha=8.fig']);
        saveas(gcf,['images/gps/', ctab_coeffs{i},'_alpha=8.png'])
    end

end