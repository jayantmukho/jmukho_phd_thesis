clear variables
close all
clc
% The new defaults will not take effect if there are any open figures. To
% use them, we close all figures, and then repeat the first example.

% Defaults for this blog post
width = 4;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 10;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize
FA = 0.25;      % Face Alpha
EA = 0.0;       % Edge Alpha
afz = 10;       % Axis label font size

% The properties we've been using in the figures
set(groot,'defaultLineLineWidth',lw);   % set the default line width to lw
set(groot,'defaultLineMarkerSize',msz); % set the default line marker size to msz
set(groot,'defaultAxesFontSize',fsz)

% Set the default Size for display
defpos = get(groot,'defaultFigurePosition');
set(groot,'defaultFigurePosition', [defpos(1) defpos(2) width*100, height*100]);

% Set the defaults for saving/printing to a file
set(groot,'defaultFigureInvertHardcopy','on'); % This is the default anyway
set(groot,'defaultFigurePaperUnits','inches'); % This is the default anyway
defsize = get(gcf, 'PaperSize');
left = (defsize(1)- width)/2;
bottom = (defsize(2)- height)/2;
defsize = [left, bottom, width, height];
set(groot, 'defaultFigurePaperPosition', defsize);

%%
n_samp = 201;
x_samp      = linspace(0,1,n_samp)';
% Define the truth latent function
% y1_func = @(x1) 0.5.*(6.*x1 -2).^2 .* sin(12.*x1 -4) + 10.*(x1-0.5) - 5 ;

y_lf_func = @(x1) -(x1*2).^3 .* cos(8.*x1) + 10.*(x1) - 5 ;
y_hf_func = @(x2) 20*x2.^2-5.* cos(8.*x2);
% Get the truth values at the sample points
figure(1)
plot(x_samp,y_hf_func(x_samp))
hold on
plot(x_samp,y_lf_func(x_samp))
legend('True function','Low-fidelity approximation','location','northwest')

%% High Fidelity

for i = 3:2:7
    rng(10)
    n_hf=i;
    X_HF = lhsdesign(n_hf,1);
%     X_HF = linspace(0.0,1.0,n_hf)';
    Y = y_hf_func(X_HF);
    sig = ones(n_hf,1)*.001;
    gp = MF_GP;
    gp = gp.add_data(X_HF,Y,sig);
    gp = gp.Process();
    % gp.plot_input_data();
    figure(2); clf;
    gp.plot_GP_1D_slice(x_samp,x_samp)
    plot(X_HF,Y,'ko')
    plot(x_samp,y_hf_func(x_samp))
    if i ==3 
        legend('$2\sigma$','GP Mean','Data points','True Function','location','northwest')
    end
    xlabel('$x$')
    ylabel('$y$')
    set(gcf,'Position', [defpos(1) defpos(2) width*100, height*100]);
    [y_samp,~] = gp.Query(x_samp);
    rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
    title(sprintf('$RMSE =%.5f$',rmse)); 
    saveas(gcf,sprintf('images/hf_%i.png',i))
    
    
    sig = ones(n_hf,1)*1.0; 
    gp = MF_GP;
    gp = gp.add_data(X_HF,Y,sig);
    gp = gp.Process();
    % gp.plot_input_data();
    figure(3); clf;
    gp.plot_GP_1D_slice(x_samp,x_samp)
    errorbar(X_HF,Y,2.*sig,'ko','MarkerSize',msz,'LineWidth',lw,'capsize',8)
    plot(x_samp,y_hf_func(x_samp))
    if i ==3 
        legend('$2\sigma$','GP Mean','Data points','True Function','location','northwest')
    end
    xlabel('$x$')
    ylabel('$y$')
    [y_samp,~] = gp.Query(x_samp);
    rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
    title(sprintf('$RMSE =%.5f$',rmse)); 
    set(gcf,'Position', [defpos(1) defpos(2) width*100, height*100]);
    saveas(gcf,sprintf('images/hf_%i_noise.png',i))
end


%% Low 

rng(10)
n_lf=21;
n_hf = 5;
% X_LF = lhsdesign(n_lf,1);
X_HF = lhsdesign(n_hf,1);
X_LF = linspace(0,1.0,n_lf)';
Y_LF = y_lf_func(X_LF);
Y_HF = y_hf_func(X_HF);
sig_LF = ones(n_lf,1)*1.0;
sig_HF = ones(n_hf,1)*0.5; 
gp = MF_GP;
gp = gp.add_data(X_LF,Y_LF,sig_LF);
gp = gp.add_data(X_HF,Y_HF,sig_HF);
gp.expand_hf = 'no';
% gp.order = [1;1];
gp = gp.Process();
% gp.plot_input_data();
figure(4); clf;
gp.plot_GP_1D_slice(x_samp,x_samp)
errorbar(X_HF,Y_HF,2.*sig_HF,'ko','MarkerSize',msz,'LineWidth',lw,'capsize',8)
hold on
errorbar(X_LF,Y_LF,2.*sig_LF,'bx','MarkerSize',msz,'LineWidth',lw,'capsize',8)

plot(x_samp,y_hf_func(x_samp))
plot(x_samp,y_lf_func(x_samp))
[y_samp,~] = gp.Query(x_samp);
rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
title(sprintf('$RMSE =%.5f$',rmse)); 
legend('$2\sigma$','GP Mean','Data points','True Function','location','northwest')
set(gcf,'Position', [defpos(1) defpos(2) width*100, height*100]);
saveas(gcf,sprintf('images/mf_%i_noise.png',i))

gp = MF_GP;
gp = gp.add_data(X_HF,Y_HF,sig_HF);
gp = gp.Process();
% gp.plot_input_data();
figure(5); clf;
gp.plot_GP_1D_slice(x_samp,x_samp)
errorbar(X_HF,Y_HF,2.*sig_HF,'ko','MarkerSize',msz,'LineWidth',lw,'capsize',8)
hold on
plot(x_samp,y_hf_func(x_samp))
legend('$2\sigma$','GP Mean','Data points','True Function','location','northwest')
[y_samp,~] = gp.Query(x_samp);
rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
title(sprintf('$RMSE =%.5f$',rmse));
set(gcf,'Position', [defpos(1) defpos(2) width*100, height*100]);
saveas(gcf,sprintf('images/mf_%i_noise.png',i))