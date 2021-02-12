load GMATT_aero+ctrl_corrected;
if ~exist('GMATT_WT','var')
    load('C:\Users\Mukho\Documents\GitHub\phd_defense\code\GMATT Data\1f\wt\gmatt_wt_3d_plotting.mat');
end
GMATT_new = add_zeros(GMATT_new);

close all

fs = 18;
lw = 2.0;
msz= 8;
plot_options = plotting_options('thesis');
plot_options.width = 5;
plot_options.height = 5;
plot_options.font_size = fs;
plot_options.line_width = lw;
setup_plots(plot_options);

%%
alpha_lim = 21;     % upper limit on alpha
close all

ctrl = GMATT_WT.CTRL;
ctrl_coeffs = fieldnames(ctrl);

coeff_labels = {'$C_{m_{\delta_a}}$';
                '$C_{l_{\delta_a}}$';
                '$C_{n_{\delta_a}}$';
                '$C_{m_{\delta_r}}$';
                '$C_{l_{\delta_r}}$';
                '$C_{n_{\delta_r}}$';
                '$C_{m_{\delta_e}}$';
                '$C_{l_{\delta_e}}$';
                '$C_{n_{\delta_e}}$';
                '$C_{m_{\delta_f}}$';
                '$C_{l_{\delta_f}}$';
                '$C_{n_{\delta_f}}$';
                '$C_{L_{\delta_f}}$';
                '$C_{D_{\delta_f}}$';
                '$C_{SF_{\delta_f}}$';
                '$C_{m_{\delta_s}}$';
                '$C_{l_{\delta_s}}$';
                '$C_{n_{\delta_s}}$'};
defl_labels = {'$\delta_a$';
                '$\delta_a$';
                '$\delta_a$';
                '$\delta_r$';
                '$\delta_r$';
                '$\delta_r$';
                '$\delta_e$';
                '$\delta_e$';
                '$\delta_e$';
                '$\delta_f$';
                '$\delta_f$';
                '$\delta_f$';
                '$\delta_f$';
                '$\delta_f$';
                '$\delta_f$';
                '$\delta_s$';
                '$\delta_s$';
                '$\delta_s$'};

% Setup 3D plot views            
views= zeros(length(coeff_labels),2);
views(:,1) = -37.5;
views(:,2) = 30;
% views(3,:) = [-150,30]; % CSFTAB
% views(4,:) = [-150,30]; % CRMTAB
% views(5,:) = [-215,30]; % CPMTAB
% views(6,:) = [60,30];   % CYMTAB

for i=2:2 %length(ctrl_coeffs)
    coeff_gp = ctrl.(ctrl_coeffs{i});
    coeff_wt = coeff_gp; %GMATT_new.CTRL.(ctrl_coeffs{i});
    fields = fieldnames(coeff_wt);
    if ~isfield(coeff_wt,'betaRange')
        % 1D function
        
        % AVL Data
        inds = coeff.alphaRange<alpha_lim;
        X_AVL = coeff.alphaRange(inds);
        Y_AVL = coeff.data(inds);
        sn = get_sig_avl(X_AVL,Y_AVL);
        
        figure(i*3); clf;
        e=errorbar(X_AVL, Y_AVL, 2*sn,'o');
        xlabel('$\alpha$')
        ylabel(coeff_labels{i})
        hold all
        format_plot(e,plotting_options('thesis'))
        grid('on')

        % WT Data 
        [X_WT,Y_WT,sn] = process_wt_data(coeff_wt);
        e=errorbar(X_WT,Y_WT,2*sn,'x');
        format_plot(e,plotting_options('thesis'))
        
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
        legend('AVL Data','WT Data','GP Mean','$2\sigma$','location','best')
        grid('on')
        xlim([-4,20]);
        savefig(gcf,['figs/gps/', ctrl_coeffs{i},'.fig']);
        saveas(gcf,['images/gps/', ctrl_coeffs{i},'.png'])
    
    else
        % Process Data
        
        % WT
        [X_WT,Y_WT,sn_WT] = process_wt_data(coeff_wt);
        
        % GP
        inds_a = coeff_gp.alphaSamp<alpha_lim;
        alpha = coeff_gp.alphaSamp(inds_a);
        beta = coeff_gp.betaSamp;
        defl = coeff_gp.deflSamp;
        X_GP = combvec(alpha',beta',defl')';
        Y_GP = coeff_gp.muSamp;
        sn_GP   = sqrt(diag(coeff_gp.qSamp*coeff_gp.qSamp'));
        
        for j = 1:length(coeff_wt.deflRange)
            if coeff_wt.deflRange(j) == 0
                continue
            end
            j_gp = find(coeff_gp.deflSamp == coeff_wt.deflRange(j));
            
            %%%%% Contour plot %%%%%
            alpha = coeff_gp.alphaSamp;
            beta = coeff_gp.betaSamp;
            defl = coeff_gp.deflSamp;
            [X1_S,X2_S] = meshgrid(alpha',beta');
            inds = X_GP(:,3) == coeff_wt.deflRange(j);
            Mu_S = reshape(coeff_gp.muSamp(inds),size(X1_S'))';
            
            figure(i*4-3);
            surf(X1_S,X2_S,Mu_S,'facealpha',0.75);
            xlabel('$\alpha$');
            ylabel('$\beta$');
            zlabel(coeff_labels{i});
            hold all
            set_figure_size(gcf,5,5);
            xlim([-5,25])
            view(views(i,:));
            grid('on')
            
            %%%%% 1D plot for beta = 4 %%%%%
            figure(i*4-2);

            % WT Data
            inds = abs(X_WT(:,2)-4)<0.5 & X_WT(:,3) == coeff_wt.deflRange(j);
            e = errorbar(X_WT(inds,1),Y_WT(inds),sn_WT(inds),'kx');
            format_plot(e,plotting_options('thesis'))
            hold all

            % GP Predictions
            inds = abs(X_GP(:,2)-4)<0.5 & X_GP(:,3) == coeff_wt.deflRange(j);
            fill_x1 = [X_GP(inds,1);flipud(X_GP(inds,1))];
            fill_SD = [ Y_GP(inds) - 2*sn_GP(inds);...
                        flipud( Y_GP(inds) + 2*sn_GP(inds))];
            plot(X_GP(inds,1), Y_GP(inds),'k','linewidth',2);
            h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);

            set_figure_size(gcf,5,5);
            xlim([-4,20]);
            grid('on')
%             legend('WT Data','GP Mean','$2\sigma$','location','best')
            
            %%%%% 1D plot for alpha = 8 %%%%%
            figure(i*4-1);

            % WT Data
            inds = abs(X_WT(:,1)-8)<0.75 & X_WT(:,3) == coeff_wt.deflRange(j);
            e = errorbar(X_WT(inds,2),Y_WT(inds),sn_WT(inds),'kx');
            format_plot(e,plotting_options('thesis'))
            hold all
            % GP Predictions
            inds = X_GP(:,1) == 8 & X_GP(:,3) == coeff_wt.deflRange(j);
            fill_x1 = [X_GP(inds,2);flipud(X_GP(inds,2))];
            fill_SD = [ Y_GP(inds) - 2*sn_GP(inds);...
                        flipud( Y_GP(inds) + 2*sn_GP(inds))];
            plot(X_GP(inds,2), Y_GP(inds),'k','linewidth',2);
            h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);

            set_figure_size(gcf,5,5);
            grid('on')
%             legend('WT Data','GP Mean','$2\sigma$','location','best')

        end
        
        figure(i*4-3);
        x = [0.9 0.9];
        y = [0.37 0.7];
        annotation('textarrow',x,y,'String',{'Increasing',defl_labels{i}},...
            'Interpreter','latex','HorizontalAlignment','center','FontSize',14)
        savefig(gcf,['figs/gps/', ctrl_coeffs{i},'.fig']);
        saveas(gcf,['images/gps/', ctrl_coeffs{i},'.png']);
        
        figure(i*4-2);
        savefig(gcf,['figs/gps/', ctrl_coeffs{i},'_beta=4.fig']);
        saveas(gcf,['images/gps/', ctrl_coeffs{i},'_beta=4.png']);
        
        figure(i*4-1);
        savefig(gcf,['figs/gps/', ctrl_coeffs{i},'_alpha=8.fig']);
        saveas(gcf,['images/gps/', ctrl_coeffs{i},'_alpha=8.png'])
        
        %%%%% 1D plot for alpha = 8, beta = 4 %%%%%
        figure(i*4);


        % WT Data
        inds = abs(X_WT(:,1)-8)<0.75 & abs(X_WT(:,2)-4)<0.5;
        e = errorbar(X_WT(inds,3),Y_WT(inds),sn_WT(inds),'kx');
        format_plot(e,plotting_options('thesis'))
        hold all
        % GP Predictions
        inds = abs(X_GP(:,1)-8)<0.75 & X_GP(:,2) == 4;
        fill_x1 = [X_GP(inds,3);flipud(X_GP(inds,3))];
        fill_SD = [ Y_GP(inds) - 2*sn_GP(inds);...
                    flipud( Y_GP(inds) + 2*sn_GP(inds))];
        plot(X_GP(inds,3), Y_GP(inds),'k','linewidth',2);
        h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);

        set_figure_size(gcf,5,5);
        grid('on')
        legend('WT Data','GP Mean','$2\sigma$','location','southeast')
        savefig(gcf,['figs/gps/', ctrl_coeffs{i},'_alpha=8_beta=4.fig']);
        saveas(gcf,['images/gps/', ctrl_coeffs{i},'_alpha=8_beta=4.png'])
    end

end