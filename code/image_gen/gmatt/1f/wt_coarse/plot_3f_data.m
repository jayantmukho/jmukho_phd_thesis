load GMATT_AVL;
load GMATT_aero+ctrl_corrected;
load GMATT_SU2;

GMATT_WT = add_zeros(GMATT_new);

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
    coeff_wt = GMATT_WT.CTAB.(ctab_coeffs{i});
    fields = fieldnames(coeff);
    if ~isfield(coeff_wt,'betaRange')
        % 1D function
        
        inds = coeff.alphaRange<alpha_lim;
        X_AVL = coeff.alphaRange(inds);
        Y_AVL = coeff.data(inds);
        sn = get_sig_avl(X_AVL,Y_AVL);
        
        figure(i*3); clf;
        e=errorbar(X_AVL, Y_AVL, 2*sn,'o');
        format_plot(e,plotting_options('thesis'))
        xlabel('$\alpha$')
        ylabel(coeff_labels{i})
        hold all
        
        [X_WT,Y_WT,sn] = process_wt_data(coeff_wt);
        e=errorbar(X_WT,Y_WT,sn/2,'x');
        format_plot(e,plotting_options('thesis'))
        
        legend('AVL Data','WT Data','location','best')
        grid('on')
        savefig(gcf,['figs/', ctab_coeffs{i},'.fig']);
        saveas(gcf,['images/', ctab_coeffs{i},'.png'])
    else
        coeff_su2 = GMATT_SU2.CTAB.(ctab_coeffs{i});
        
        % AVL Data
        inds_a = coeff.alphaRange<alpha_lim;
        inds_b = coeff.betaRange > -0.5;
        alpha = coeff.alphaRange(inds_a);
        beta = coeff.betaRange(inds_b);
        X_AVL = combvec(alpha',beta')';
        Y_AVL = reshape(coeff.data(inds_a,inds_b),[],1);
        
        % SU2 Data
        inds_a = coeff_su2.alphaRange<alpha_lim;
        inds_b = coeff_su2.betaRange>-0.5;
        X_SU2 = combvec(coeff_su2.alphaRange(inds_a)',coeff_su2.betaRange(inds_b)')';
        Y_SU2 = reshape(coeff_su2.data(inds_a,inds_b),[],1);
        
        % WT Data
        [X_WT,Y_WT,~] = process_wt_data(coeff_wt);
        inds_b = X_WT(:,2)>-0.5;
        X_WT = X_WT(inds_b,:);
        Y_WT = Y_WT(inds_b);
        
        % 3D plot with all data
        figure(i*3-2); clf;
        plot3(X_AVL(:,1),X_AVL(:,2),Y_AVL,'o')
        xlabel('$\alpha$');
        ylabel('$\beta$');
        zlabel(coeff_labels{i});
        hold all
        plot3(X_SU2(:,1),X_SU2(:,2),Y_SU2,'^');
        plot3(X_WT(:,1),X_WT(:,2),Y_WT,'kx');      
        set_figure_size(gcf,6,6);
        grid('on')
        legend('AVL Data','SU2 Data','WT Data','location','northeast')
        savefig(gcf,['figs/', ctab_coeffs{i},'.fig']);
        saveas(gcf,['images/', ctab_coeffs{i},'.png'])
 
        % 1D plot for beta = 4
        figure(i*3-1); clf;
        
        % AVL Data
        sn = get_sig_avl(X_AVL,Y_AVL);
        inds = X_AVL(:,2) == 4;
        e = errorbar(X_AVL(inds,1),Y_AVL(inds),2*sn(inds),'o');
        format_plot(e,plotting_options('thesis'))
        xlabel('$\alpha$');
        ylabel(coeff_labels{i});
        hold all
        
        % SU2 Data
        inds_a = coeff_su2.alphaRange<alpha_lim;
        inds_b = abs(coeff_su2.betaRange-5)<0.5;
        X_SU2 = combvec(coeff_su2.alphaRange(inds_a)',coeff_su2.betaRange(inds_b)')';
        Y_SU2 = reshape(coeff_su2.data(inds_a,inds_b),[],1);
        sn = reshape(coeff_su2.sig_data(inds_a,inds_b),[],1);
        e = errorbar(X_SU2(:,1),Y_SU2,2*sn,'^');
        format_plot(e,plotting_options('thesis'))
        
        % WT Data
        [X_WT,Y_WT,sn] = process_wt_data(coeff_wt);
        inds_b = abs(X_WT(:,2)-4)<0.5;
        X_WT = X_WT(inds_b,:);
        Y_WT = Y_WT(inds_b);
        sn = sn(inds_b);
        e = errorbar(X_WT(:,1),Y_WT,sn/2,'kx');
        format_plot(e,plotting_options('thesis'))
        %             set_figure_size(gcf,6,6);
        grid('on')
        legend('AVL Data','SU2 Data','WT Data','location','best')
        savefig(gcf,['figs/', ctab_coeffs{i},'_beta=4.fig']);
        saveas(gcf,['images/', ctab_coeffs{i},'_beta=4.png'])
        
        % 1D plot for alpha = 8
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
        format_plot(e,plotting_options('thesis'))
        xlabel('$\beta$');
        ylabel(coeff_labels{i});
        hold all
        
        % SU2 Data
        inds_a = abs(coeff_su2.alphaRange-8)<0.5;
        inds_b = coeff_su2.betaRange>-25;
        X_SU2 = combvec(coeff_su2.alphaRange(inds_a)',coeff_su2.betaRange(inds_b)')';
        Y_SU2 = reshape(coeff_su2.data(inds_a,inds_b),[],1);
        sn = reshape(coeff_su2.sig_data(inds_a,inds_b),[],1);
        e = errorbar(X_SU2(:,2),Y_SU2,2*sn,'^');
        format_plot(e,plotting_options('thesis'))
        
        % WT Data
        [X_WT,Y_WT,sn] = process_wt_data(coeff_wt);
        inds_a = abs(X_WT(:,1)-8)<0.7;
        X_WT = X_WT(inds_a,:);
        Y_WT = Y_WT(inds_a);
        sn = sn(inds_a);
        e = errorbar(X_WT(:,2),Y_WT,sn/2,'kx');
        format_plot(e,plotting_options('thesis'))

        grid('on')
        legend('AVL Data','WT Data','location','best')
        savefig(gcf,['figs/', ctab_coeffs{i},'_alpha=8.fig']);
        saveas(gcf,['images/', ctab_coeffs{i},'_alpha=8.png'])
    end

end