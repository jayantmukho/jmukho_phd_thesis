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
y_lf_func = @(x1) 0.5.*(6.*x1 -2).^2 .* sin(12.*x1 -4) + 10.*(x1-0.5) - 5 ;
y_hf_func = @(x2) 2*y_lf_func(x2) - 20*x2 +20 + sin(10.*cos(5.*x2));

% Get the truth values at the sample points
figure(1); clf;
plot(x_samp,y_hf_func(x_samp))
hold on
plot(x_samp,y_lf_func(x_samp))
legend('True function','Low-fidelity approximation','location','northwest')


%% Low

rng(10)
n_lf=11;
n_hf = 4;
% X_LF = lhsdesign(n_lf,1);
X_HF = lhsdesign(n_hf,1);
X_HF = linspace(0,1.0,n_hf)';
X_HF = [0.0, 0.4, 0.6, 1.0]';
X_LF = linspace(0,1.0,n_lf)';
Y_LF = y_lf_func(X_LF);
Y_HF = y_hf_func(X_HF);
sig_LF = ones(n_lf,1)*0.5;
sig_HF = ones(n_hf,1)*0.3;
gp = MF_GP;
gp = gp.add_data(X_LF,Y_LF,sig_LF);
gp = gp.add_data(X_HF,Y_HF,sig_HF);
gp.expand_hf = 'no';
% gp.order = [1;1];
gp = gp.Process();
% gp.plot_input_data();
figure(4); clf;
gp.plot_GP_1D_slice(x_samp,x_samp)
errorbar(X_HF,Y_HF,2.*sig_HF,'ko','MarkerSize',msz,'LineWidth',lw,'capsize',8,'HandleVisibility','off')
hold on
errorbar(X_LF,Y_LF,2.*sig_LF,'bx','MarkerSize',msz,'LineWidth',lw,'capsize',8)

plot(x_samp,y_hf_func(x_samp),'HandleVisibility','off')
plot(x_samp,y_lf_func(x_samp))
[y_samp,~] = gp.Query(x_samp);
rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
% title(sprintf('$RMSE =%.5f$',rmse));
legend('$2\sigma$','GP Mean','Low-fidelity data points','Low-fidelity function','location','northwest')

saveas(gcf,sprintf('images/mf_%i_noise.png',n_hf))

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
saveas(gcf,sprintf('images/hf_%i_noise.png',n_hf))