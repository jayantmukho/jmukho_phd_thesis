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

% y_lf_func = @(x1) -(x1*2).^3 .* cos(10.*x1) + 10.*(x1) - 5 ;
% y_hf_func = @(x2) 20*x2.^2 - 8.* cos(10.*x2) - x2;
% Get the truth values at the sample points
figure(1); clf;
plot(x_samp,y_hf_func(x_samp))
hold on
plot(x_samp,y_lf_func(x_samp))
legend('True function','Low-fidelity approximation','location','northwest')

%% High Fidelity
i = 8;
rng(1)
n_hf=i;
X_HF = lhsdesign(n_hf,1);
X_HF = linspace(0.0,1.0,n_hf)';
% X_HF = [0.0, 0.4, 0.6, 1.0]';
Y = y_hf_func(X_HF);% + randn(size(X_HF))*0.1;
sig = ones(n_hf,1)*.001;
gp = MF_GP;
gp = gp.add_data(X_HF,Y,sig);
gp = gp.Process();
% gp.plot_input_data();
figure(2); clf;
gp.plot_GP_1D_slice(x_samp,x_samp)
plot(X_HF,Y,'ko')
plot(x_samp,y_hf_func(x_samp))
legend('$2\sigma$','GP Mean','Data points','True Function','location','northwest')

xlabel('$x$')
ylabel('$y$')
[y_samp,~] = gp.Query(x_samp);
rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
%     title(sprintf('$RMSE =%.5f$',rmse));
saveas(gcf,sprintf('images/hf_%i.png',i))
n_sample = 5;
for j = 1:n_sample
    plot(x_samp,gp.Sample(x_samp),'LineWidth',1,'HandleVisibility','off')
end
saveas(gcf,sprintf('images/hf_%i_samples.png',i))

sig = ones(n_hf,1)*1.0;
gp = MF_GP;
gp = gp.add_data(X_HF,Y,sig);
gp = gp.Process();
% gp.plot_input_data();
figure(3); clf;
gp.plot_GP_1D_slice(x_samp,x_samp)
errorbar(X_HF,Y,2.*sig,'ko','MarkerSize',msz,'LineWidth',lw,'capsize',8)
plot(x_samp,y_hf_func(x_samp))
legend('$2\sigma$','GP Mean','Data points','True Function','location','northwest')

xlabel('$x$')
ylabel('$y$')
[y_samp,~] = gp.Query(x_samp);
rmse = sum((y_samp-y_hf_func(x_samp)).^2)/n_samp;
%     title(sprintf('$RMSE =%.5f$',rmse));
saveas(gcf,sprintf('images/hf_%i_noise.png',i))
for j = 1:n_sample
    plot(x_samp,gp.Sample(x_samp),'LineWidth',1,'HandleVisibility','off')
end
saveas(gcf,sprintf('images/hf_%i_noise_samples.png',i))