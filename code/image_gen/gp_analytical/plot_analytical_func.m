clear all;
close all;
clc;
set(groot,'defaultAxesFontSize',18)
set(groot,'defaultAxesTickLength',[0.01 0.01])
set(groot,'defaultAxesLineWidth',2)


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
n_samp = 201;
x_samp      = linspace(0,1,n_samp)';
% Define the truth latent function
y_1f_func = @(x1) 0.5.*(6.*x1 -2).^2 .* sin(12.*x1 -4) + 10.*(x1-0.5) - 5 ;
y_hf_func = @(x2) 2*y_lf_func(x2) - 20*x2 +20;

y_lf_func = @(x1) -(x1*2).^3 .* cos(10.*x1) + 10.*(x1) - 5 ;
y_hf_func = @(x2) 20*x2.^2 - 8.* cos(10.*x2) - x2;
% Get the truth values at the sample points
figure(1); clf;
plot(x_samp,y_hf_func(x_samp))
hold on
plot(x_samp,y_lf_func(x_samp))
legend('True function','Low-fidelity approximation','location','northwest')

%% High Fidelity

for i = 3:1:6
    rng(1)
    n_hf=i;
    X_HF = lhsdesign(n_hf,1);
    X_HF = linspace(0.0,1.0,n_hf)';
    Y = y_hf_func(X_HF) + randn(size(X_HF))*0.2;
    sig = ones(n_hf,1)*.001;
    gp = MF_GP;
    gp = gp.add_data(X_HF,Y,sig);
    gp = gp.Process();
    % gp.plot_input_data();
    figure(2); clf;
    gp.plot_GP_1D_slice(x_samp,x_samp)
    plot(X_HF,Y,'ko')
    plot(x_samp,y_hf_func(x_samp))
    if i ==6 
        legend('$2\sigma$','GP Mean','Data points','True Function','location','northwest')
    end
    xlabel('$x$')
    ylabel('$y$')
    [y_samp,~] = gp.Query(x_samp);
    rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
%     title(sprintf('$RMSE =%.5f$',rmse)); 
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
    if i ==6 
        legend('$2\sigma$','GP Mean','Data points','True Function','location','northwest')
    end
    xlabel('$x$')
    ylabel('$y$')
    [y_samp,~] = gp.Query(x_samp);
    rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
%     title(sprintf('$RMSE =%.5f$',rmse)); 
    saveas(gcf,sprintf('images/hf_%i_noise.png',i))
end


%% Low 

rng(10)
n_lf=21;
n_hf = i;
% X_LF = lhsdesign(n_lf,1);
X_HF = lhsdesign(n_hf,1);
X_HF = linspace(0,1.0,n_hf)';
X_LF = linspace(0,1.0,n_lf)';
Y_LF = y_lf_func(X_LF);
Y_HF = y_hf_func(X_HF);
sig_LF = ones(n_lf,1)*2.0;
sig_HF = ones(n_hf,1)*1.0; 
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
xlabel('$x$')
ylabel('$y$')
% title(sprintf('$RMSE =%.5f$',rmse));
saveas(gcf,sprintf('images/hf_%i_noise.png',i))