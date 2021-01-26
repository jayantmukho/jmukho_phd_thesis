%% Plot all GPs
close all
load('gmatt_3f_3d_gp.mat');
load('GMATT_aero+ctrl_corrected.mat');
GMATT = add_zeros(GMATT_new);

%%
close all
setup_plots(plotting_options('thesis'))
alpha_lim = 21;     % upper limit on alpha
ctab = GMATT_3F.CTAB;
ctab_coeffs = fieldnames(ctab);

ctrl = GMATT_3F.CTRL;
ctrl_coeffs = fieldnames(ctrl);

plotting = true;   % Boolean for plotting
% close all

n_sample = 5;

for i=1:length(ctab_coeffs)
    coeff = ctab.(ctab_coeffs{i});
    coeff_hf = GMATT.CTAB.(ctab_coeffs{i});
    fields = fieldnames(coeff);
    GP = coeff.GP;
    if ~isfield(coeff,'betaSamp')
        % 1D function
        if plotting
            inds = coeff.alphaSamp<alpha_lim;
            alpha = coeff.alphaSamp(inds)';
            figure(i);% clf;
            GP.plot_input_data();
            hold on
            x_samp = linspace(min(alpha),max(alpha),100)';
            GP.plot_GP_1D_slice(x_samp,x_samp)
            xlabel('$\alpha$')
            ylabel(ctab_coeffs{i})
            hold all
            nx = length(coeff.muSamp);
            for j = 1:n_sample
                Rvec = randn(nx,1);
                Y = coeff.qSamp*Rvec + coeff.muSamp;
                plot(coeff.alphaSamp,Y,'HandleVisibility','off');
            end
            legend('AVL Data','WT Data','$2\sigma$','GP Mean','location','best')
%             pause % This just helps see the plots one by one
        end
    else
        % 2D function
        if plotting
%             inds = coeff.alphaSamp<alpha_lim;
            alpha = coeff.alphaSamp;
            beta = coeff.betaSamp;
            
            % Get Mean and SD data
            [X1_S,X2_S] = meshgrid(alpha',beta');
            Mu_S = reshape(coeff.muSamp,[length(alpha),length(beta)])';
            K = coeff.qSamp*coeff.qSamp';
            S_S = reshape(sqrt(diag(K)),[length(alpha),length(beta)])';
            figure(i); %clf;
            subplot(1,2,1)
            
            % Plot mean surface
            surf(X1_S,X2_S,Mu_S,'HandleVisibility','off');
            hold all
            surf(X1_S,X2_S,Mu_S+2*S_S,'facealpha',.2,'HandleVisibility','off');
            surf(X1_S,X2_S,Mu_S-2*S_S,'facealpha',.2,'HandleVisibility','off');
            xlabel('$\alpha$');
            ylabel('$\beta$');
            zlabel(ctab_coeffs{i});
            hold all
            inds_a = coeff_hf.alphaRange<alpha_lim;
            inds_b = coeff_hf.betaRange>-0.5;
            data_locs = combvec([-4:2:8,9:20],coeff_hf.betaRange(inds_b)')';
            plot3(data_locs(:,1),data_locs(:,2),reshape(coeff_hf.data(inds_a,inds_b),[],1),'x');
            % Plot 5 samples
%             nx = length(coeff.muSamp);
%             
%             Rvec = 2*ones(nx,1);
%             sig = coeff.qSamp*Rvec;
%             sig = reshape(sig,length(coeff.alphaSamp),length(coeff.betaSamp));
%             [X1_S,X2_S] = meshgrid(coeff.alphaSamp,coeff.betaSamp);
%             surf(X1_S,X2_S,Y','facealpha',.2);
           
            % Define and plot a slice
            n_slice         = 100;
            x1_slice        = linspace(min(alpha),max(alpha),n_slice);
            x2_slice        = linspace(max(beta),min(beta),n_slice);
            x_slice         = [x1_slice(:),x2_slice(:)];
            [Mu,S]          = GP.Query(x_slice);
            V               = [Mu+2*S, Mu, Mu-2*S];
            h = surf(x1_slice'*ones(1,3),x2_slice'*ones(1,3),V,'facecolor','r');
            legend('WT Data','Slice Location','location','northwest')
            
            subplot(1,2,2)
            % Plot and sample the GP along the slice
            GP.plot_GP_1D_slice(x_slice)
            hold all
%             for ii = 1:10;
%                 y_samp     = GP.Sample(x_slice);
%                 plot(1:size(x_slice,1),y_samp);
%             end
            ylabel(ctab_coeffs{i});
            set(gcf,'position',[20, 50, 1300, 700]);
            legend('$2\sigma$','GP Mean','location','best')
%             pause
            
        end
    end
    savefig(gcf,['figs/', ctab_coeffs{i},'.fig']);
    saveas(gcf,['images/', ctab_coeffs{i},'.png'])
end
%%
plotting = true;   % Boolean for plotting
offset = length(ctab_coeffs);
for i=1:length(ctrl_coeffs)
    coeff = ctrl.(ctrl_coeffs{i});
    coeff_hf = GMATT.CTRL.(ctrl_coeffs{i});
    fields = fieldnames(coeff);
    GP = coeff.GP;
    if ~isfield(coeff,'betaSamp')
        % 1D function
        figure(offset + i); clf;
        deflSamp = coeff.deflSamp;
        for j = 1:length(coeff_hf.deflRange)
            j_3f = find(deflSamp == coeff_hf.deflRange(j));
            if plotting
                
                inds = coeff_hf.alphaRange<alpha_lim;
                alpha = coeff_hf.alphaRange(inds)';
                
                plot(alpha,coeff_hf.data(inds,j),'kx');
                coeff.GP.plot_input_data();
                hold on
                x_samp = linspace(min(alpha),max(alpha),50)';
                x_samp = [x_samp, ones(size(x_samp)) * coeff.deflSamp(j_3f)];
                GP.plot_GP_1D_slice(x_samp,x_samp(:,1))
                xlabel('$\alpha$')
                ylabel(ctrl_coeffs{i})
                nx = length(coeff.muSamp);
                
%                 for k = 1:n_sample
%                     Rvec = randn(nx,1);
%                     Y = coeff.qSamp*Rvec + coeff.muSamp;
%                     Y = reshape(Y,length(coeff.alphaSamp),length(coeff.deflSamp));
%                     plot(coeff.alphaSamp,Y(:,j));
%                 end
%                 saveas(gcf,['ctrl_figs/' ctrl_coeffs{i} '.pdf'])
%                 pause % This just helps see the plots one by one
            end
        end
        legend('WT Data','$2\sigma$','GP Mean','location','best')
    else
        % 2D function
        inds = coeff.alphaSamp<alpha_lim;
        alpha = coeff.alphaSamp(inds);
        beta = coeff.betaSamp;
        deflSamp = coeff.deflSamp;
        data_locs = combvec(alpha',beta')';
        % Get Mean and SD data
        if length(deflSamp) == 1
            
            [X1_S,X2_S] = meshgrid(alpha',beta');
            Mu_S = reshape(coeff.muSamp,[length(alpha),length(beta)])';
            K = coeff.qSamp*coeff.qSamp';
            S_S = reshape(sqrt(diag(K)),[length(alpha),length(beta)])';
        else
            [X1_S,X2_S,X3_S] = meshgrid(alpha',beta',deflSamp');
            Mu_S = reshape(coeff.muSamp,[length(alpha),length(beta),length(deflSamp)]);
            Mu_S = permute(Mu_S,[2,1,3]);
            K = coeff.qSamp*coeff.qSamp';
            S_S = reshape(sqrt(diag(K)),[length(alpha),length(beta),length(deflSamp)]);
            S_S = permute(S_S,[2,1,3]);
%             [Mu_Mean, S_Mean] = GP.Query(X1_Mean,X2_Mean,X3_Mean);
        end
        figure(offset + i); clf;
        for j = 1:length(coeff_hf.deflRange)
            j_3f = find(deflSamp == coeff_hf.deflRange(j));
            if plotting

                subplot(1,2,1)

                % Plot mean surface
                surf(X1_S(:,:,j_3f),X2_S(:,:,j_3f),Mu_S(:,:,j_3f),'HandleVisibility','off');
                hold all
                surf(X1_S(:,:,j_3f),X2_S(:,:,j_3f),Mu_S(:,:,j_3f)+2*S_S(:,:,j_3f),'facealpha',.2,'HandleVisibility','off');
                surf(X1_S(:,:,j_3f),X2_S(:,:,j_3f),Mu_S(:,:,j_3f)-2*S_S(:,:,j_3f),'facealpha',.2,'HandleVisibility','off');
                inds_a = coeff_hf.alphaRange<alpha_lim;
                inds_b = coeff_hf.betaRange<21;
                data_locs = combvec(coeff_hf.alphaRange(inds_a)',coeff_hf.betaRange(inds_b)')';
                plot3(data_locs(:,1),data_locs(:,2),reshape(coeff_hf.data(inds_a,inds_b,j),[],1),'x');
%                 coeff.GP.plot_input_data();
                xlabel('$\alpha$');
                ylabel('$\beta$');
                zlabel(ctrl_coeffs{i});
                hold all
                % Plot 5 samples
%                 nx = length(coeff.muSamp);
%                 for k = 1:n_sample
%                     Rvec = randn(nx,1);
%                     Y = coeff.qSamp*Rvec + coeff.muSamp;
%                     if length(deflSamp) == 1
%                         [X1_Samp,X2_Samp] = meshgrid(coeff.alphaSamp',coeff.betaSamp');
%                         Y = reshape(Y,length(coeff.alphaSamp),length(coeff.betaSamp));
%                     else
%                         [X1_Samp,X2_Samp,X3_Samp] = meshgrid(coeff.alphaSamp',coeff.betaSamp',coeff.deflSamp');
%                         Y = reshape(Y,length(coeff.alphaSamp),length(coeff.betaSamp),length(coeff.deflSamp));
%                     end
%                     surf(X1_Samp(:,:,j),X2_Samp(:,:,j),Y(:,:,j)','facealpha',.2);
%                 end

                % Define and plot a slice
                n_slice         = 100;
                x1_slice        = linspace(min(alpha),max(alpha),n_slice);
                x2_slice        = linspace(max(beta),min(beta),n_slice);
                if length(deflSamp) == 1
                    x_slice         = [x1_slice(:),x2_slice(:)];
                else
                    x3_slice        = ones(size(x1_slice)) * coeff.deflSamp(j_3f);
                    x_slice         = [x1_slice(:),x2_slice(:), x3_slice(:)];
                end
                [Mu,S]          = GP.Query(x_slice);
                V               = [Mu+2*S, Mu, Mu-2*S];
                h = surf(x1_slice'*ones(1,3),x2_slice'*ones(1,3),V,'facecolor','r');
                legend('WT Data','Slice Location','location','northwest')
                
                subplot(1,2,2)
                % Plot and sample the GP along the slice
                GP.plot_GP_1D_slice(x_slice)
                hold all
%                 for ii = 1:10;
%                     y_samp     = GP.Sample(x_slice);
%                     plot(1:size(x_slice,1),y_samp);
%                 end
                ylabel(ctrl_coeffs{i});
                xlabel('[$\alpha$,$\beta$,$\delta$]')
                set(gcf,'position',[20, 50, 1300, 700]);
                
            end
            legend('$2\sigma$','GP Mean','location','best')
        end
%         pause
%         saveas(gcf,['ctrl_figs/' ctrl_coeffs{i} '.pdf'])
        
    end
    savefig(gcf,['figs/', ctrl_coeffs{i},'.fig']);
    saveas(gcf,['images/', ctrl_coeffs{i},'.png'])
end