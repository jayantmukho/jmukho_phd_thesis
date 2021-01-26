load GMATT_AVL;

close all
setup_plots(plotting_options('thesis'))

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

for i=1:length(ctab_coeffs)
    coeff = ctab.(ctab_coeffs{i});
    fields = fieldnames(coeff);
    if ~isfield(coeff,'betaRange')
        % 1D function
        
        inds = coeff.alphaRange<alpha_lim;
        X_AVL = coeff.alphaRange(inds);
        Y_AVL = coeff.data(inds);
        sn = get_sig_avl(X_AVL,Y_AVL);
        
        figure(i*3); clf;
        e=errorbar(X_AVL, Y_AVL, 2*sn,'o');
        xlabel('$\alpha$')
        ylabel(coeff_labels{i})
        hold all         
        legend('AVL Data','location','best')
        format_plot(e,plotting_options('thesis'))
        grid('on')
        savefig(gcf,['figs/avl/', ctab_coeffs{i},'.fig']);
        saveas(gcf,['images/avl/', ctab_coeffs{i},'.png'])
    else
        % 1D function
        inds_a = coeff.alphaRange<alpha_lim;
        inds_b = coeff.betaRange > -0.5;
        alpha = coeff.alphaRange(inds_a);
        beta = coeff.betaRange(inds_b);
        X_AVL = combvec(alpha',beta')';
        
        Y_AVL = reshape(coeff.data(inds_a,inds_b),[],1);
        sn = get_sig_avl(X_AVL,Y_AVL);
        % 3D plot with all data
        figure(i*3-2); clf;
        plot3(X_AVL(:,1),X_AVL(:,2),Y_AVL,'o')
        xlabel('$\alpha$');
        ylabel('$\beta$');
        zlabel(coeff_labels{i});
        hold all
        set_figure_size(gcf,6,6);
        grid('on')
        legend('AVL Data','location','northeast')
        savefig(gcf,['figs/avl/', ctab_coeffs{i},'.fig']);
        saveas(gcf,['images/avl/', ctab_coeffs{i},'.png'])
 
        % 1D plot for beta = 4
        figure(i*3-1); clf;
        inds = X_AVL(:,2) == 4;
        e = errorbar(X_AVL(inds,1),Y_AVL(inds),2*sn(inds),'o');
        format_plot(e,plotting_options('thesis'))
        xlabel('$\alpha$');
        ylabel(coeff_labels{i});
        hold all
        grid('on')
        legend('AVL Data','location','best')
        savefig(gcf,['figs/avl/', ctab_coeffs{i},'_beta=4.fig']);
        saveas(gcf,['images/avl/', ctab_coeffs{i},'_beta=4.png'])
        
        % 1D plot for alpha = 4
        figure(i*3); clf;
        inds_a = coeff.alphaRange<alpha_lim;
        alpha = coeff.alphaRange(inds_a);
        beta = coeff.betaRange;
        
        X_AVL = combvec(alpha',beta')';
        Y_AVL = reshape(coeff.data(inds_a,:),[],1);
        inds = X_AVL(:,1) == 4;
        sn = get_sig_avl(X_AVL,Y_AVL);
        e = errorbar(X_AVL(inds,2),Y_AVL(inds),2*sn(inds),'o');
        format_plot(e,plotting_options('thesis'))
        xlabel('$\beta$');
        ylabel(coeff_labels{i});
        hold all
        grid('on')
        legend('AVL Data','location','best')
        savefig(gcf,['figs/avl/', ctab_coeffs{i},'_alpha=4.fig']);
        saveas(gcf,['images/avl/', ctab_coeffs{i},'_alpha=4.png'])
    end

end