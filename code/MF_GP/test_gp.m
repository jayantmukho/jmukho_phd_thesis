% test_gp

% Turning this off is expected to yield samples with discontinuities 
% Turning this on smooths the transition across uncertainty levels.
filter_sigmas = 1;


x_vec   = [0:.4:10]';
y_vec   = [0:5,5,5,5,5,5]';
y_vec   = interp1(0:10,y_vec,x_vec);
s_vec   = 0.08*ones(length(x_vec),1);
inds    = find(x_vec>4 & x_vec<8);
s_vec(inds) = 0.252;
s_vec2   = s_vec;
if filter_sigmas
d = designfilt('lowpassiir', ...
    'PassbandFrequency',0.0625,'FilterOrder',1,'PassbandRipple',0.1);
s_vec2 = filtfilt(d,s_vec);
end
test_GP = MF_GP;
test_GP = test_GP.add_data(x_vec,y_vec,s_vec2);
test_GP = test_GP.Process;

x_samp  = [linspace(0,10,1000)]';


figure(1);clf
test_GP.plot_GP_1D_slice(x_samp,x_samp);
hold all
test_GP.plot_input_data;
for ii = 1:25
    plot(x_samp,test_GP.Sample(x_samp));
end

figure(2);clf
plot(x_vec,s_vec,x_vec,s_vec2)
legend('Raw sigmas','Sigmas used in GP')

