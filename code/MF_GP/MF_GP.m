classdef MF_GP
    
    properties
        x_dat       = {}; % Cell array of independent data
        y_dat       = {}; % Cell array of dependent data
        sig_dat     = {}; % Cell array of 1-sigma values
        x_labs      = {}; % Labels for the dimensions of the independent data
        y_lab       = ''; % Label for the dependent data
        DataNames   = {}; % Labels for the data series
        sample_seed = 0;  % Optional RNG seed value for repeatibility
        x_samp      = {}; % Optional pre-defined sample points
        scaling     = 1;  % Option to normalize data before learning
        cov_scaling = 0;  % Option to switch on/off the Kennedy Scaling
        mf_type     = 'gratiet'; % Options are 'gratiet' or 'kennedy'
        expand_hf   = 'no'; % Read Expand_HF(obj) function definition for explanation
        order       = [1;1]; % polynomial order for regression functions 
                             % for bias terms [additive; multiplicative]
    end % properties
    
    properties (Access = private)
        covfunc     = @simple_covSEard;
        N_dim       = [];
        N_DataSet   = 0;
        hyp         = {};
        hyp_tot     = {};
        x_scaling   = [];
        y_scaling   = [];
        x_scaled    = {};
        y_scaled    = {};
        sig_scaled  = {};
        init_guess  = struct('ell',5,'sig',1);
    end % properties private
    
    methods
        function obj = add_data(obj,x,y,sig,DataName)
            % Append data series to the MF_GP
            % Inputs:
            % x     -- Independent data
            % y     -- Dependent data
            % sig   -- 1-sigma values
            % DataName -- Optional name for the data series
            
            % Validate sizes
            x_sz        = size(x);
            y_sz        = size(y);
            s_sz        = size(sig);
            chk(1)      = x_sz(1) == y_sz(1);
            chk(2)      = x_sz(1) == s_sz(1);
            if ~isempty(obj.x_dat)
                chk(3)  = x_sz(2) == obj.N_dim;
            end
            if ~prod(chk)
                error('Incompatible data input');
            end
            
            obj.x_dat   = [obj.x_dat,x];
            obj.y_dat   = [obj.y_dat,y];
            obj.sig_dat = [obj.sig_dat,sig];
            
            obj.N_dim   = x_sz(2);
            obj.N_DataSet = obj.N_DataSet+1;
            
            if ~exist('DataName','var')
                DataName    = sprintf('DataSet_%02d',obj.N_DataSet);
            end
            obj.DataNames{obj.N_DataSet} = DataName;
            
        end % add_data
        
        function obj = Process(obj)
            % Perform hyperparameter fitting depending on specified
            % framework
            
            obj = obj.set_scaled_data();
            if strcmp(obj.mf_type,'gratiet')
                
                [obj.hyp,obj.hyp_tot] = get_hyp_params_gratiet(obj.x_scaled,...
                    obj.y_scaled, obj.sig_scaled,obj.covfunc,obj.init_guess,obj.order);
                
                % If expand_hf is set to yes, perform expansion
                if strcmp(obj.expand_hf,'yes')
                    obj = obj.Expand_HF();
                end
                
            elseif strcmp(obj.mf_type,'kennedy')
                [obj.hyp,obj.hyp_tot] = get_hyp_params(obj.x_scaled,...
                    obj.y_scaled, obj.sig_scaled,obj.covfunc,obj.init_guess);
            else
                error('Invalid Multi-Fidelity framework specified');
            end
        end % GP_Process
        
        function obj = Expand_HF(obj)
            % Expand the highest fidelity (HF) dataset to include any lower
            % fidelity (LF) data points that are outside domain of the HF
            % data. This enables better predictions where the HF data is
            % localized to some part of the domain, while the LF data spans
            % the entire domain of the problem.
            
            for i = 2:obj.N_DataSet
                lf = obj.x_dat{i-1};
                hf = obj.x_dat{i};
                dim = size(obj.x_scaled{i},2);
                for j = 1:dim
                    % find points that are outside the domain of the HF 
                    % data use the learned length scale as a buffer for 
                    % this selection
                    outside_domain_ind = find(lf(:,j) < ...
                        (min(hf(:,j)) - exp(obj.hyp{i}.cov(j))) ...
                        | lf(:,j) > (max(hf(:,j))+ exp(obj.hyp{i}.cov(j))));
                    
                    % copy the LF data into the HF dataset
                    obj.x_scaled{i} = [obj.x_scaled{i}; obj.x_scaled{i-1}(outside_domain_ind,:)];
                    obj.y_scaled{i} = [obj.y_scaled{i}; obj.y_scaled{i-1}(outside_domain_ind)];
                    obj.sig_scaled{i} = [obj.sig_scaled{i}; obj.sig_scaled{i-1}(outside_domain_ind)];
                    % remove the data points from the LF dataset
                    obj.x_scaled{i-1}(outside_domain_ind,:) = [];
                    obj.y_scaled{i-1}(outside_domain_ind) = [];
                    obj.sig_scaled{i-1}(outside_domain_ind) = [];
                    % copy the uncertainty information
                    obj.hyp{i}.lik = log(obj.sig_scaled{i});
                    obj.hyp{i-1}.lik = log(obj.sig_scaled{i-1});
                    obj.hyp_tot{i}.lik = log(obj.sig_scaled{i});
                    obj.hyp_tot{i-1}.lik = log(obj.sig_scaled{i-1});
                end
            end
            
        end
        
        function [Mu,S,Mu_vec,Q,dCov_dSig] = Query(obj,varargin)
            % Extract Mean and Covariance from the GP at specified points
            %
            % Input Option 1:
            % Query(x_samp)
            %   -- x_samp is a N x N_dim matrix, where N_dim is number of
            %   independent variables
            %
            % Input Option 2:
            % Query(X_samp_1,X_samp_2,...)
            %   -- X_samp_i are identically-sized matrices for each
            %   dimension (e.g. output of meshgrid)
            %
            % Outputs: [Mu,S,Mu_vec,Q] = Query()
            %
            % Mu -- GP mean, returned as matrix of size compatible with the
            % input
            % S  -- GP 1-sigma values, returned as matrix of size compatible with the
            % input
            % Mu_vec -- GP mean, always returned as a N x 1 vector
            % Q -- cholesky factor of the GP covariance matrix
            in_args                 = varargin;
            [x_samp,out_size_vec]   = obj.process_sample_varargin(varargin);
            
            x_samp = obj.normalize_x_samp(x_samp);
            
            if obj.cov_scaling
                [Mu_vec,Q]  = Kennedy_scaling(obj.hyp,obj.hyp_tot,obj.x_scaled,...
                    obj.y_scaled, obj.sig_scaled,x_samp,obj.covfunc,obj.mf_type, obj.order);
            else
                if strcmp(obj.mf_type,'gratiet')
                    [Mu_vec,K_post]  = get_Mu_K_MF_gratiet(obj.x_scaled,obj.y_scaled,x_samp,x_samp,obj.hyp_tot,obj.covfunc,obj.order);
                    K_post      = fix_K_eigval(K_post);
                    Q = chol(K_post,'lower');
                elseif strcmp(obj.mf_type,'kennedy')
                    [Mu_vec,Q]  = get_Mu_Q_MF(obj.x_scaled,obj.y_scaled,x_samp,obj.hyp_tot,obj.covfunc);
                else
                    error('Invalid Multi-Fidelity framework specified');
                end
            end
            
            [Mu_vec,Q]  = obj.rescale_output(Mu_vec,Q);
            
            Mu          = reshape(Mu_vec,out_size_vec);
            K           = Q*Q';
            sig_vec     = sqrt(diag(K));
            S           = reshape(sig_vec,out_size_vec);
            
            if nargout>4
                % get correlation matrix from K and sig_vec
                D           = diag(sig_vec);
                Dinv        = inv(D);
                CorrMat     = Dinv*K*Dinv;
                nx          = length(sig_vec);
                
                % Now K = D*CorrMat*D; compute gradient WRT diagonals of D
                % Return as sparse since only one row, one col will be
                % non-zero
                dCov_dSig   = cell(nx,1);
                for ii = 1:nx
                    J_ii            = zeros(nx,nx);
                    J_ii(ii,ii)     = 1;
                    dCov_dSig{ii}   = sparse(D*CorrMat*J_ii + J_ii*CorrMat*D);
                end % ii
            end % if nargout
            
        end % GP_Query
        
        
        function [y_samp] = Sample(obj,varargin)
            % Returns a random sample of the GP at specified points
            %
            % Input Option 1:
            % Sample(x_samp)
            %   -- x_samp is a N x N_dim matrix, where N_dim is number of
            %   independent variables
            %
            % Input Option 2:
            % Sample(X_samp_1,X_samp_2,...)
            %   -- X_samp_i are identically-sized matrices for each
            %   dimension (e.g. output of meshgrid)
            %
            % Uses the value of sample_seed for the randn seed value
            % iff MF_GP.sample_seed ~=0
            
            [x_samp,out_size_vec] = obj.process_sample_varargin(varargin);
            
            if obj.sample_seed~=0
                randn('seed',obj.sample_seed);
            end % if
            
            [~,~,Mu_vec,Q]       = obj.Query(x_samp);
            
            [nx,N_dims]         = size(x_samp);
            Rvec                = randn(nx,1);
            y_samp              = Q*Rvec + Mu_vec;
            
            if N_dims>1
                y_samp          = reshape(y_samp,out_size_vec);
            end
            
        end % GP_Sample
        
        
        function plot_input_data(obj,varargin)
            % Error bar plot of the provided data series
            % Functions for 1-D data only
            n_varargin  = length(varargin);
            if n_varargin == 0
                markers = ['o';'^';'x'];
            else
                markers = varargin{1};
            end
            
            n_data_set  = length(obj.x_dat);
            if n_data_set == 1
                markers = ['o'];
            elseif n_data_set == 2
                markers = ['o';'^'];
            elseif n_data_set == 3
                markers = ['o';'^';'x'];
            end
            c = get(gca,'colororder');
            if obj.N_dim == 1
                
                for ii = 1:n_data_set
                    h_err{ii}   = errorbar(obj.x_dat{ii},obj.y_dat{ii},2*obj.sig_dat{ii},markers(ii,:),'LineWidth',2,'MarkerSize',10,'color',c(ii,:));
                    hold all
                end % ii
            end % if
            
        end %plot_input_data
        
        function h_cell = plot_GP_1D_slice(obj,x_samp,x_vec)
            % Plots the 1-D mean and 2-sigma envelope at specified points
            % x_samp -- N x N_dim matrix of sample points
            % x_vec -- (Optional) N x 1 vector for ticklabeling of the
            % abscissa
            x_vec_given         = exist('x_vec','var');
            
            [Mu,S]             = obj.Query(x_samp);
            
            N_dim               = size(x_samp,2);
            sig_vec             = S;
            
            nx              = size(x_samp,1);
            if ~x_vec_given
                x_vec           = [1:nx]';
            end
            
            fill_x1         = [x_vec;flipud(x_vec)];
            
            fill_SD         = [ Mu - 2*sig_vec;...
                flipud( Mu + 2*sig_vec)];
            
            h_fill          = fill(fill_x1,fill_SD,[0.55,0.55,0.55],'facealpha',0.5,'edgealpha',0);
            hold all
            plot(x_vec, Mu,'k','linewidth',2);
            ylabel(obj.y_lab);
            if ~x_vec_given
                set(gca,'xtick',[x_vec(1),x_vec(end)]);
                x_lab           = {};
                x_lab{1}        = ['[ ',sprintf('%0.2f ',x_samp(1,:)),']'];
                x_lab{2}        = ['[ ',sprintf('%0.2f ',x_samp(end,:)),']'];
                set(gca,'xticklabel',x_lab);
            end
        end % plot_dim
        
        function h = plot_GP_2D_surf(obj,x1,x2,x3)
            % Plots the 2-D mean and 2-sigma envelope at a grid mesh
            % defined by x1, x2, and optionally, x3
            % x1 -- N1 x 1 matrix of sample locations in 1st dimension
            % x2 -- N2 x 1 matrix of sample locations in 2nd dimension
            % x3 -- N3 x 1 matrix of sample locations in 3rd dimension
            % Note: if all three x1, x2, and x3 are specified, one of them
            % must be a scalar so that the 3D GP can be plotted in 2
            % dimensions
            
            n_slice = 100; % number of sample points for 1D representation
            
            
            x3_given         = exist('x3','var');
            
            % If 3 inputs specified, the GP must be 3-dimensional.
            % Additionally, one of the inputs must be a scalar so that the
            % 3D GP can be plotted using 2D surfaces. This code block makes
            % the necessary transformations to ensure proper plotting
            if x3_given
                if obj.N_dim ~= 3
                    error('3 inputs specified, but GP is not 3-dimensional')
                end
                [X1,X2,X3]            = ndgrid(x1,x2,x3);
                [Mu,S]             = obj.Query(X1,X2,X3);
                
                % Find which input is a scalar
                singular_dim = find(size(Mu) == 1);
                if isempty(singular_dim)
                    error(['Atleast one input vector must have only ', ...
                        '1 element to allow plotting of 3-dimensional', ...
                        'GP in 2 dimensions']);
                else
                    % First input is a scalar. Matrices and vectors must be
                    % transformed to work with the 2nd and 3rd inputs
                    if singular_dim == 1
                        X1 = permute(X2,[2,3,1]);
                        X2 = permute(X3,[2,3,1]);
                        Mu = permute(Mu,[2,3,1]);
                        S = permute(S,[2,3,1]);
                        x1_slice = linspace(min(x2),max(x2),n_slice);
                        x2_slice = linspace(max(x3),min(x3),n_slice);
                        x_slice  = [ones(n_slice,1)*x1,x1_slice(:),x2_slice(:)];
                        
                    % Second input is a scalar. Matrices and vectors must be
                    % transformed to work with the 1st and 3rd inputs
                    elseif singular_dim == 2
                        X1 = permute(X1,[1,3,2]);
                        X2 = permute(X3,[1,3,2]);
                        Mu = permute(Mu,[1,3,2]);
                        S = permute(S,[1,3,2]);
                        x1_slice = linspace(min(x1),max(x1),n_slice);
                        x2_slice = linspace(max(x3),min(x3),n_slice);
                        x_slice  = [x1_slice(:),ones(n_slice,1).*x2,x2_slice(:)];
                        
                    % Third input is a scalar. 3rd input must be included 
                    % sampling locations
                    else
                        x1_slice = linspace(min(x1),max(x1),n_slice);
                        x2_slice = linspace(max(x2),min(x2),n_slice);
                        x_slice  = [x1_slice(:),x2_slice(:),ones(n_slice,1)*x3];
                    end
                end
            % If only 2 inputs are specified, the GP must be 2-dimensional,
            % rest is straightforward
            else 
                if obj.N_dim ~= 2
                    error('2 inputs specified, but GP is not 2-dimensional')
                end
                [X1,X2]            = ndgrid(x1,x2);
                [Mu,S]             = obj.Query(X1,X2);
                n_slice         = 100;
                x1_slice        = linspace(min(x1),max(x1),n_slice);
                x2_slice        = linspace(max(x2),min(x2),n_slice);
                x_slice         = [x1_slice(:),x2_slice(:)];
            end
            
            % Plot mean and +- 2\sigma surfaces
            subplot(1,2,1)
            surf(X1,X2,Mu);
            hold all
            axis square
            surf(X1,X2,Mu+2*S,'facealpha',.2)%,'edgecolor','flat');
            surf(X1,X2,Mu-2*S,'facealpha',.2)%,'edgecolor','flat');
            
            % Create a diagonal slice across the domain and plot the GP in
            % 1 dimension as well
            [Mu,S]          = obj.Query(x_slice);
            V               = [Mu+2*S, Mu, Mu-2*S];
            surf(x1_slice'*ones(1,3),x2_slice'*ones(1,3),V,'facecolor','r');
            
            subplot(1,2,2)
            obj.plot_GP_1D_slice(x_slice);
            axis square
            h = gcf;
        end
        
        function obj = set_initial_guess(obj,ell,sig)
            obj.init_guess.ell = ell;
            obj.init_guess.sig = sig;
        end
        
        function [loo_prob] = get_cv_prob(obj)
            loo_prob = 0;
            x_s = obj.x_dat{end};
            y_s = obj.y_dat{end};
            sig_s = obj.sig_dat{end};
            n = length(x_s);
            if n < 2
                return;
            end
            
            for i = 1:length(x_s)
                obj.x_dat{end}(i) = [];
                obj.y_dat{end}(i) = [];
                obj.sig_dat{end}(i) = [];
                
                obj = obj.Process;
                [mu,sig] = obj.Query(x_s(i));
                loo_prob = loo_prob - 0.5*(log(sig^2) + (y_s(i)-mu)^2/sig^2 + log(2*pi));
                
                obj.x_dat{end} = x_s;
                obj.y_dat{end} = y_s;
                obj.sig_dat{end} = sig_s;
            end
            obj = obj.Process;
            
        end
        
        function [loo_err] = get_cv_error(obj)
            loo_err = 0;
            x_s = obj.x_dat{end};
            y_s = obj.y_dat{end};
            sig_s = obj.sig_dat{end};
            n = length(x_s);
            if n < 2
                return;
            end
            
            for i = 1:length(x_s)
                obj.x_dat{end}(i) = [];
                obj.y_dat{end}(i) = [];
                obj.sig_dat{end}(i) = [];
                
                obj = obj.Process;
                [mu,sig] = obj.Query(x_s(i));
                loo_err = loo_err + (y_s(i)-mu)^2/length(x_s);
                
                obj.x_dat{end} = x_s;
                obj.y_dat{end} = y_s;
                obj.sig_dat{end} = sig_s;
            end
            obj = obj.Process;
            
        end
        
    end % methods
    methods (Access = private)
        
        function [x_samp,out_size_vec] = process_sample_varargin(obj,args)
            n_varargin  = length(args);
            if n_varargin == 0
                % use predefined points
                args    = obj.x_samp;
                if ~iscell(args)
                    args    = {args};
                end
                n_varargin  = length(args);
            end
            if n_varargin == 1
                % Data is 1-D or passed as matrix
                x_samp          = args{1};
                N_dims          = size(x_samp,2);
                size_vec        = size(x_samp);
                out_size_vec    = [size_vec(1),1];
                nx              = out_size_vec(1);
            else
                N_dims          = n_varargin;
                temp            = args{1};
                out_size_vec    = size(temp);
                nx              = numel(temp);
                x_samp          = zeros(nx,N_dims);
                for ii = 1:N_dims
                    x_samp(:,ii) = reshape(args{ii},nx,1);
                end % for
                
            end % if
        end% process_sample_varargin
        
        function obj = get_xy_scaling(obj)
            % Gets the scaling required to make the data have zero mean and
            % a standard deviation of 1.
            n_fid = length(obj.y_dat);
            total_y = [];
            total_x = [];
            for ii = 1:n_fid
                total_y = [total_y; obj.y_dat{ii}];
                total_x = [total_x; obj.x_dat{ii}];
            end
            avg = mean(total_y);
            sd = range(total_y)/2;
            obj.y_scaling = [avg; sd];
            
            avg = mean(total_x);
            %             sd = range(total_x)/2;
            obj.x_scaling = {avg; chol(cov(total_x),'lower')};
            
        end % get_xy_scaling
        
        function obj = set_scaled_data(obj)
            % If scaling is enabled, scale the input data to lie between -1
            % and 1
            obj.x_scaled = obj.x_dat;
            obj.y_scaled = obj.y_dat;
            obj.sig_scaled = obj.sig_dat;
            if obj.scaling
                obj = obj.get_xy_scaling();
                for ii = 1:length(obj.y_dat)
                    obj.y_scaled{ii} = (obj.y_dat{ii} - obj.y_scaling(1))./obj.y_scaling(2);
                    obj.sig_scaled{ii} = obj.sig_dat{ii} ./ obj.y_scaling(2);
                    obj.x_scaled{ii} = bsxfun(@minus, obj.x_dat{ii}, obj.x_scaling{1});
                    %                     obj.x_scaled{ii} = bsxfun(@rdivide, obj.x_scaled{ii}, obj.x_scaling(2,:));
                    obj.x_scaled{ii} = [obj.x_scaling{2}\obj.x_scaled{ii}']';
                end % for
            end % if
        end % set_scaled_data
        
        function [Mu_vec, Q] = rescale_output(obj,Mu_vec,Q)
            % Rescales vector y using the scaling obtained from the data
            % originally
            if obj.scaling
                Mu_vec = (Mu_vec * obj.y_scaling(2)) + obj.y_scaling(1);
                Q = Q .* obj.y_scaling(2);
            end % if
        end % rescale_output
        
        function [x_out] = normalize_x_samp(obj,x)
            % Rescales vector x_samp using the scaling obtained from the data
            % originally
            x_out = x;
            if obj.scaling
                x_out = bsxfun(@minus, x, obj.x_scaling{1});
                %                 x_out = bsxfun(@rdivide, x_out, obj.x_scaling(2,:));
                x_out = [obj.x_scaling{2}\x_out']';
            end % if
        end % normalize_x_samp
    end % private methods
    
end