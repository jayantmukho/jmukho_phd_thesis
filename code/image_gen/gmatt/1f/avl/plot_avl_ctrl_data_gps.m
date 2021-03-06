
load('C:\Users\Mukho\Documents\GitHub\phd_defense\code\GMATT Data\model\gmatt_final\GMATT_AVL_Database_Generation\gmatt_avl_3d_plotting.mat');

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
c = get(gca,'colororder');

%%
alpha_lim = 21;     % upper limit on alpha
close all
ctrl = GMATT_AVL.CTRL;
ctrl_coeffs = fieldnames(ctrl);
plotting = 1;
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
    coeff = ctrl.(ctrl_coeffs{i});
    coeff_gp = coeff;
    coeff.data = coeff.data * 0.75;
    fields = fieldnames(coeff);
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
        % AVL
        inds_a = coeff.alphaRange<alpha_lim;
        alpha = coeff.alphaRange(inds_a);
        beta = coeff.betaRange;
        defl = coeff.deflRange;
        X_AVL = combvec(alpha',beta',defl')';
        Y_AVL = reshape(coeff.data(inds_a,:),[],1);
        sn_AVL = get_sig_avl(X_AVL,Y_AVL);
        
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
            j_avl = find(coeff.deflRange == coeff_wt.deflRange(j));
            
            %%%%% Contour plot %%%%%
            alpha = coeff_gp.alphaSamp;
            beta = coeff_gp.betaSamp;
            defl = coeff_gp.deflSamp;
            [X1_S,X2_S] = meshgrid(alpha',beta');
            X_GP = combvec(alpha',beta',defl')';
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

            % AVL Data
            sn_AVL = get_sig_avl(X_AVL,Y_AVL);
            inds = X_AVL(:,2) == 4 & X_AVL(:,3) == coeff_wt.deflRange(j);
            e = errorbar(X_AVL(inds,1),Y_AVL(inds),2*sn_AVL(inds),'o','color',c(1,:));
            format_plot(e,plotting_options('thesis'))
            xlabel('$\alpha$');
            ylabel(coeff_labels{i});
            hold all    

            % GP Predictions
            inds = abs(X_GP(:,2)-4)<0.5 & X_GP(:,3) == coeff_wt.deflRange(j);
            fill_x1 = [X_GP(inds,1);flipud(X_GP(inds,1))];
            fill_SD = [ Y_GP(inds) - 2*sn_GP(inds);...
                        flipud( Y_GP(inds) + 2*sn_GP(inds))];
            plot(X_GP(inds,1), Y_GP(inds),'k','linewidth',2);
            h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);

            format_plot(e,plotting_options('thesis'))
            set_figure_size(gcf,5,5);
            xlim([-4,20]);
            grid('on')
%             legend('AVL Data','GP Mean','$2\sigma$','location','best')
            
            %%%%% 1D plot for alpha = 8 %%%%%
            figure(i*4-1);

            % AVL Data
            inds = X_AVL(:,1) == 8 & X_AVL(:,3) == coeff_wt.deflRange(j);
            e = errorbar(X_AVL(inds,2),Y_AVL(inds),2*sn_AVL(inds),'o','color',c(1,:));
            format_plot(e,plotting_options('thesis'))
            xlabel('$\beta$');
            ylabel(coeff_labels{i});
            hold all

            % GP Predictions
            inds = X_GP(:,1) == 8 & X_GP(:,3) == coeff_wt.deflRange(j);
            fill_x1 = [X_GP(inds,2);flipud(X_GP(inds,2))];
            fill_SD = [ Y_GP(inds) - 2*sn_GP(inds);...
                        flipud( Y_GP(inds) + 2*sn_GP(inds))];
            plot(X_GP(inds,2), Y_GP(inds),'k','linewidth',2);
            h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);

            format_plot(e,plotting_options('thesis'))
            set_figure_size(gcf,5,5);
            grid('on')
%             legend('AVL Data','GP Mean','$2\sigma$','location','best')

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

        % AVL Data
        inds = X_AVL(:,1) == 8 & X_AVL(:,2) == 4;
        e = errorbar(X_AVL(inds,3),Y_AVL(inds),2*sn_AVL(inds),'o');
        format_plot(e,plotting_options('thesis'))
        xlabel(defl_labels{i});
        ylabel(coeff_labels{i});
        hold all

        % GP Predictions
        inds = abs(X_GP(:,1)-8)<0.75 & X_GP(:,2) == 4;
        fill_x1 = [X_GP(inds,3);flipud(X_GP(inds,3))];
        fill_SD = [ Y_GP(inds) - 2*sn_GP(inds);...
                    flipud( Y_GP(inds) + 2*sn_GP(inds))];
        plot(X_GP(inds,3), Y_GP(inds),'k','linewidth',2);
        h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);

        format_plot(e,plotting_options('thesis'))
        set_figure_size(gcf,5,5);
        grid('on')
        legend('AVL Data','GP Mean','$2\sigma$','location','best')
        savefig(gcf,['figs/gps/', ctrl_coeffs{i},'_alpha=8_beta=4.fig']);
        saveas(gcf,['images/gps/', ctrl_coeffs{i},'_alpha=8_beta=4.png'])
    end

end