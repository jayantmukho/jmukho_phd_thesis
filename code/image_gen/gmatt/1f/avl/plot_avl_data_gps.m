% load GMATT_AVL;
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

%%
alpha_lim = 21;     % upper limit on alpha
ctab = GMATT_AVL.CTAB;
ctab_coeffs = fieldnames(ctab);

ctrl = GMATT_AVL.CTRL;
ctrl_coeffs = fieldnames(ctrl);
plotting = 1;
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
    coeff = ctab.(ctab_coeffs{i});
    fields = fieldnames(coeff);
    coeff = GMATT_AVL.CTAB.(ctab_coeffs{i});
    if ~isfield(coeff,'betaRange')
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
        
        % GP Prediction
        X_GP = coeff.alphaSamp;
        Y_GP = coeff.muSamp;
        sn     = sqrt(diag(coeff.qSamp*coeff.qSamp'));
        fill_x1 = [X_GP;flipud(X_GP)];
        fill_SD = [ Y_GP - 2*sn;...
                    flipud( Y_GP + 2*sn)];
        plot(X_GP, Y_GP,'k','linewidth',2);
        h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);
        
        xlim([-4,20]);
        set_figure_size(gcf,5,5);
        legend('AVL Data','GP Mean','$2\sigma$','location','best')
        grid('on')
        savefig(gcf,['figs/gps/', ctab_coeffs{i},'.fig']);
        saveas(gcf,['images/gps/', ctab_coeffs{i},'.png'])
       
    else
        % AVL Data
        inds_a = coeff.alphaRange<alpha_lim;
        inds_b = coeff.betaRange > -0.5;
        alpha = coeff.alphaRange(inds_a);
        beta = coeff.betaRange(inds_b);
        X_AVL = combvec(alpha',beta')';
        Y_AVL = reshape(coeff.data(inds_a,inds_b),[],1);
        
        % GP Prediction
        [X1_S,X2_S] = meshgrid(coeff.alphaSamp',coeff.betaSamp');
        Mu_S = reshape(coeff.muSamp,size(X1_S'))';
        
        % 3D plot with all data
        figure(i*3-2); clf;
        plot3(X_AVL(:,1),X_AVL(:,2),Y_AVL,'o')
        xlabel('$\alpha$');
        ylabel('$\beta$');
        zlabel(coeff_labels{i});
        hold all
        surf(X1_S,X2_S,Mu_S,'facealpha',0.75);
        set_figure_size(gcf,6,6);
        grid('on')
        legend('AVL Data','location','northeast')
        xlim([-5,25])
        view(views(i,:));
        legend('AVL Data','location','northeast')
        savefig(gcf,['figs/gps/', ctab_coeffs{i},'.fig']);
        saveas(gcf,['images/gps/', ctab_coeffs{i},'.png'])
        
        % Include all beta data
        inds_a = coeff.alphaRange<alpha_lim;
        alpha = coeff.alphaRange(inds_a);
        beta = coeff.betaRange;
        X_AVL = combvec(alpha',beta')';
        Y_AVL = reshape(coeff.data(inds_a,:),[],1);
        sn = get_sig_avl(X_AVL,Y_AVL);
 
        % % 1D plot for beta = 4
        % AVL Data                
        figure(i*3-1); clf;
        inds = X_AVL(:,2) == 4;
        e = errorbar(X_AVL(inds,1),Y_AVL(inds),2*sn(inds),'o');
        hold all
        
        % GP Data
        inds = X2_S == 4;
        X_GP = X1_S(inds);
        Y_GP = reshape(coeff.muSamp,size(X1_S'))';
        Y_GP = Y_GP(inds);
        sn_GP   = reshape(sqrt(diag(coeff.qSamp*coeff.qSamp')),size(X1_S'))';
        sn_GP   = sn_GP(inds);
        fill_x1 = [X_GP;flipud(X_GP)];
        fill_SD = [ Y_GP - 2*sn_GP;...
                    flipud( Y_GP + 2*sn_GP)];
        plot(X_GP, Y_GP,'k','linewidth',2);
        h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);
        
        format_plot(e,plotting_options('thesis'))
        set_figure_size(gcf,5,5);
        xlabel('$\alpha$');
        ylabel(coeff_labels{i});
        xlim([-4,20]);
        grid('on')
        legend('AVL Data','GP Mean','$2\sigma$','location','best')
        savefig(gcf,['figs/gps/', ctab_coeffs{i},'_beta=4.fig']);
        saveas(gcf,['images/gps/', ctab_coeffs{i},'_beta=4.png'])
        
        % % 1D plot for alpha = 8
        figure(i*3); clf;
        
        % AVL Data
        inds_a = coeff.alphaRange<alpha_lim;
        alpha = coeff.alphaRange(inds_a);
        beta = coeff.betaRange;
        X_AVL = combvec(alpha',beta')';
        Y_AVL = reshape(coeff.data(inds_a,:),[],1);
        inds = X_AVL(:,1) == 8;
        sn = get_sig_avl(X_AVL,Y_AVL);
        e = errorbar(X_AVL(inds,2),Y_AVL(inds),2*sn(inds),'o');
        hold all
        
        inds = X1_S == 8;
        X_GP = X2_S(inds);
        Y_GP = reshape(coeff.muSamp,size(X1_S'))';
        Y_GP = Y_GP(inds);
        sn_GP   = reshape(sqrt(diag(coeff.qSamp*coeff.qSamp')),size(X1_S'))';
        sn_GP   = sn_GP(inds);
        
        X_GP = [flipud(-X_GP); X_GP];
        if i == 3 || i == 4 || i == 6
            Y_GP = [flipud(-Y_GP); Y_GP];
        else
            Y_GP = [flipud(Y_GP); Y_GP];
        end
        sn_GP  = [ flipud(sn_GP); sn_GP];
        
        fill_x1 = [X_GP;flipud(X_GP)];
        fill_SD = [ Y_GP - 2*sn_GP;...
                    flipud( Y_GP + 2*sn_GP)];
                
        plot(X_GP, Y_GP,'k','linewidth',2);
        h_fill  = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);

        format_plot(e,plotting_options('thesis'))
        set_figure_size(gcf,5,5);
        xlabel('$\beta$');
        ylabel(coeff_labels{i});
        grid('on')
        legend('AVL Data','GP Mean','$2\sigma$','location','best')
        savefig(gcf,['figs/gps/', ctab_coeffs{i},'_alpha=8.fig']);
        saveas(gcf,['images/gps/', ctab_coeffs{i},'_alpha=8.png'])
    end

end