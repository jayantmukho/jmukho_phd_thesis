clear variables
% The new defaults will not take effect if there are any open figures. To
% use them, we close all figures, and then repeat the first example.
close all;

% Defaults for this blog post
width = 5;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 11;      % Fontsize
lw = 1.5;      % LineWidth
msz = 10;       % MarkerSize
FA = 0.25;      % Face Alpha
EA = 0.0;       % Edge Alpha
afz = 16;       % Axis label font size

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

%% baseline
H = .591*.0254;
Ub = 19.812;
c=473;
r=141;
simData = dlmread('baseline/flow.dat','\t',[3,0,66695,17]);
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));

wall= simData(1:c,:);
wallPlus= simData(c+1:2*c,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_base=tauWall./(wall(:,3)*.5*Ub^2);

topWallIndex=r*c-c+1;
wall= simData(topWallIndex:topWallIndex+c-1,:);
wallPlus= simData(topWallIndex-c:topWallIndex-1,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_top_base=-tauWall./(wall(:,3)*.5*Ub^2);

eps=1e-1;
x_base_32=[];
x_base_neg6=[];
x_base_pos6=[];
x_base_17=[];
x_base_27=[];
for i=1:n
    if abs(simData(i,1)/H- 32) < eps
        x_base_32= [x_base_32; simData(i,:)];
    elseif abs(simData(i,1)/H+ 6) < eps*2
        x_base_neg6= [x_base_neg6; simData(i,:)];
    elseif abs(simData(i,1)/H - 6) < eps/2
        x_base_pos6 = [x_base_pos6; simData(i,:)];
    elseif abs(simData(i,1)/H - 17) < eps/2
        x_base_17 = [x_base_17; simData(i,:)];
    elseif abs(simData(i,1)/H - 27) < eps
        x_base_27 = [x_base_27; simData(i,:)];
    end
end

% 
% figure(1)
% plot(wall(:,1)/H,Cf_bot_base);
% axis([-110,75,-.002,.009])
% hold on
% 
% figure(2)
% plot(wall(:,1)/H,Cf_top_base);
% axis([-110,75,-.002,.009])
% hold on
% 
% figure(3)
% plot(x_base_32(:,2)./H,x_base_32(:,4)./Ub)
% hold on

%% 1c Perturbation
H = .591*.0254;
Ub = 22.5857;
simData = dlmread('1c/flow.dat','\t',[3,0,66695,17]);
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));

wall= simData(1:c,:);
wallPlus= simData(c+1:2*c,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_1c=tauWall./(wall(:,3)*.5*Ub^2);

topWallIndex=r*c-c+1;
wall= simData(topWallIndex:topWallIndex+c-1,:);
wallPlus= simData(topWallIndex-c:topWallIndex-1,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_top_1c=-tauWall./(wall(:,3)*.5*Ub^2);

eps=1e-1;
x_1c_32=[];
x_1c_neg6=[];
x_1c_pos6=[];
x_1c_17=[];
x_1c_27=[];
for i=1:n
    if abs(simData(i,1)/H- 32) < eps
        x_1c_32= [x_1c_32; simData(i,:)];
    elseif abs(simData(i,1)/H+ 6) < eps*2
        x_1c_neg6= [x_1c_neg6; simData(i,:)];
    elseif abs(simData(i,1)/H - 6) < eps/2
        x_1c_pos6 = [x_1c_pos6; simData(i,:)];
    elseif abs(simData(i,1)/H - 17) < eps/2
        x_1c_17 = [x_1c_17; simData(i,:)];
    elseif abs(simData(i,1)/H - 27) < eps
        x_1c_27 = [x_1c_27; simData(i,:)];
    end
end

% figure(1)
% plot(wall(:,1)/H,Cf_bot_1c);
% 
% figure(2)
% plot(wall(:,1)/H,Cf_top_1c);
% 
% figure(3)
% plot(x_1c_32(:,2)./H,x_1c_32(:,4)./Ub)


%% 2C Perturbation

H = .591*.0254;
Ub = 22.5857;
simData = dlmread('2c/flow.dat','\t',[3,0,66695,17]);
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));

wall= simData(1:c,:);
wallPlus= simData(c+1:2*c,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_2c=tauWall./(wall(:,3)*.5*Ub^2);

wall= simData(topWallIndex:topWallIndex+c-1,:);
wallPlus= simData(topWallIndex-c:topWallIndex-1,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_top_2c=-tauWall./(wall(:,3)*.5*Ub^2);

eps=1e-1;
x_2c_32=[];
x_2c_neg6=[];
x_2c_pos6=[];
x_2c_17=[];
x_2c_27=[];
for i=1:n
    if abs(simData(i,1)/H- 32) < eps
        x_2c_32= [x_2c_32; simData(i,:)];
    elseif abs(simData(i,1)/H+ 6) < eps*2
        x_2c_neg6= [x_2c_neg6; simData(i,:)];
    elseif abs(simData(i,1)/H - 6) < eps/2
        x_2c_pos6 = [x_2c_pos6; simData(i,:)];
    elseif abs(simData(i,1)/H - 17) < eps/2
        x_2c_17 = [x_2c_17; simData(i,:)];
    elseif abs(simData(i,1)/H - 27) < eps
        x_2c_27 = [x_2c_27; simData(i,:)];
    end
end

% figure(1)
% plot(wall(:,1)/H,Cf_bot_2c);
% 
% figure(2)
% plot(wall(:,1)/H,Cf_top_2c);
% 
% figure(3)
% plot(x_2c_32(:,2)./H,x_2c_32(:,4)./Ub)

%% 3C perturbation
H = .591*.0254;
Ub = 22.5857;
simData = dlmread('3c/flow.dat','\t',[3,0,66695,17]);
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));

wall= simData(1:c,:);
wallPlus= simData(c+1:2*c,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_3c=tauWall./(wall(:,3)*.5*Ub^2);

wall= simData(topWallIndex:topWallIndex+c-1,:);
wallPlus= simData(topWallIndex-c:topWallIndex-1,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_top_3c=-tauWall./(wall(:,3)*.5*Ub^2);

eps=1e-1;
x_3c_32=[];
x_3c_neg6=[];
x_3c_pos6=[];
x_3c_17=[];
x_3c_27=[];
for i=1:n
    if abs(simData(i,1)/H- 32) < eps
        x_3c_32= [x_3c_32; simData(i,:)];
    elseif abs(simData(i,1)/H+ 6) < eps*2
        x_3c_neg6= [x_3c_neg6; simData(i,:)];
    elseif abs(simData(i,1)/H - 6) < eps/2
        x_3c_pos6 = [x_3c_pos6; simData(i,:)];
    elseif abs(simData(i,1)/H - 17) < eps/2
        x_3c_17 = [x_3c_17; simData(i,:)];
    elseif abs(simData(i,1)/H - 27) < eps
        x_3c_27 = [x_3c_27; simData(i,:)];
    end
end

% figure(1)
% plot(wall(:,1)/H,Cf_bot_3c);
% 
% figure(2)
% plot(wall(:,1)/H,Cf_top_3c);
% 
% figure(3)
% plot(x_3c_32(:,2)./H,x_3c_32(:,4)./Ub)

%% P1C1 perturbation
H = .591*.0254;
Ub = 22.5857;
simData = dlmread('p1c1/flow.dat','\t',[3,0,66695,17]);
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));

wall= simData(1:c,:);
wallPlus= simData(c+1:2*c,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_p1c1=tauWall./(wall(:,3)*.5*Ub^2);

wall= simData(topWallIndex:topWallIndex+c-1,:);
wallPlus= simData(topWallIndex-c:topWallIndex-1,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_top_p1c1=-tauWall./(wall(:,3)*.5*Ub^2);

eps=1e-1;
x_p1c1_32=[];
x_p1c1_neg6=[];
x_p1c1_pos6=[];
x_p1c1_17=[];
x_p1c1_27=[];
for i=1:n
    if abs(simData(i,1)/H- 32) < eps
        x_p1c1_32= [x_p1c1_32; simData(i,:)];
    elseif abs(simData(i,1)/H+ 6) < eps*2
        x_p1c1_neg6= [x_p1c1_neg6; simData(i,:)];
    elseif abs(simData(i,1)/H - 6) < eps/2
        x_p1c1_pos6 = [x_p1c1_pos6; simData(i,:)];
    elseif abs(simData(i,1)/H - 17) < eps/2
        x_p1c1_17 = [x_p1c1_17; simData(i,:)];
    elseif abs(simData(i,1)/H - 27) < eps
        x_p1c1_27 = [x_p1c1_27; simData(i,:)];
    end
end
% 
% figure(1)
% plot(wall(:,1)/H,Cf_bot_p1c1);
% 
% figure(2)
% plot(wall(:,1)/H,Cf_top_p1c1);
% 
% figure(3)
% plot(x_p1c1_32(:,2)./H,x_p1c1_32(:,4)./Ub)

%% P1C2 perturbation
H = .591*.0254;
Ub = 22.5857;
simData = dlmread('p1c2/flow.dat','\t',[3,0,66695,17]);
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));

wall= simData(1:c,:);
wallPlus= simData(c+1:2*c,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_p1c2=tauWall./(wall(:,3)*.5*Ub^2);

wall= simData(topWallIndex:topWallIndex+c-1,:);
wallPlus= simData(topWallIndex-c:topWallIndex-1,:);
du_dy_wall= (wallPlus(:,4)-wall(:,4))./(wallPlus(:,2)-wall(:,2));
tauWall=du_dy_wall.*wall(:,13);
Cf_top_p1c2=-tauWall./(wall(:,3)*.5*Ub^2);

eps=1e-1;
x_p1c2_32=[];
x_p1c2_neg6=[];
x_p1c2_pos6=[];
x_p1c2_17=[];
x_p1c2_27=[];
for i=1:n
    if abs(simData(i,1)/H- 32) < eps
        x_p1c2_32= [x_p1c2_32; simData(i,:)];
    elseif abs(simData(i,1)/H+ 6) < eps*2
        x_p1c2_neg6= [x_p1c2_neg6; simData(i,:)];
    elseif abs(simData(i,1)/H - 6) < eps/2
        x_p1c2_pos6 = [x_p1c2_pos6; simData(i,:)];
    elseif abs(simData(i,1)/H - 17) < eps/2
        x_p1c2_17 = [x_p1c2_17; simData(i,:)];
    elseif abs(simData(i,1)/H - 27) < eps
        x_p1c2_27 = [x_p1c2_27; simData(i,:)];
    end
end
% 
% figure(1)
% plot(wall(:,1)/H,Cf_bot_p1c2);
% 
% figure(2)
% plot(wall(:,1)/H,Cf_top_p1c2);
% 
% figure(3)
% plot(x_p1c2_32(:,2)./H,x_p1c2_32(:,4)./Ub)

%% Experimental Data
expCf_bot= dlmread('case8_2_csv/g_cf%.y00.csv',',');
expCf_bot=expCf_bot(:,1:2);
expCf_top= dlmread('case8_2_csv/g_cf%.y10.csv',',');
expCf_top=expCf_top(:,1:2);
x_exp_32= (dlmread('case8_2_csv/m__U%.x34.csv',',') + ...
    dlmread('case8_2_csv/m__U%.x30.csv',','))/2;
x_exp_32=x_exp_32(:,1:2);
x_exp_neg6 = dlmread('case8_2_csv/m__U%.x-6.csv',',');
x_exp_neg6= x_exp_neg6(:,1:2);
x_exp_pos6 = dlmread('case8_2_csv/m__U%.x06.csv',',');
x_exp_pos6 = x_exp_pos6(:,1:2);
x_exp_17 = dlmread('case8_2_csv/m__U%.x17.csv',',');
x_exp_17 = x_exp_17(:,1:2);
x_exp_27 = dlmread('case8_2_csv/m__U%.x27.csv',',');
x_exp_27 = x_exp_27(:,1:2);
% figure(1)
% plot(expCf_bot(:,1),expCf_bot(:,2),'k.')
% figure(2)
% plot(expCf_top(:,1),expCf_top(:,2),'k.')
% figure(3)
% plot(x_exp_32(:,1),x_exp_32(:,2),'k.');


%% Shade Plot
close all
wall(:,1:2) = wall(:,1:2)./H;
gray=1/255*[200,200,200];

Cf_bot_min=Cf_bot_1c;
Cf_bot_max=Cf_bot_1c;
Cf_top_min=Cf_top_1c;
Cf_top_max=Cf_top_1c;
x_min_32=x_1c_32;
x_max_32=x_1c_32;
x_min_neg6=x_1c_neg6;
x_max_neg6=x_1c_neg6;
x_min_pos6=x_1c_pos6;
x_max_pos6=x_1c_pos6;
x_min_17=x_1c_17;
x_max_17=x_1c_17;
x_min_27=x_1c_27;
x_max_27=x_1c_27;

for i=1:size(Cf_bot_min,1)
    Cf_bot_min(i) = min([Cf_bot_1c(i),Cf_bot_2c(i),Cf_bot_2c(i),...
        Cf_bot_p1c1(i),Cf_bot_p1c2(i),Cf_bot_base(i)]);
    Cf_bot_max(i) = max([Cf_bot_1c(i),Cf_bot_2c(i),Cf_bot_2c(i),...
        Cf_bot_p1c1(i),Cf_bot_p1c2(i),Cf_bot_base(i)]);
end

figure(4)
betweenX= [wall(:,1);flipud(wall(:,1))];
betweenY= [Cf_bot_min;flipud(Cf_bot_max)];
fill(betweenX,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(wall(:,1),Cf_bot_base,'k',expCf_bot(:,1),expCf_bot(:,2),'k.','MarkerSize',msz);
xlabel('$\frac{x}{H}$','FontSize',afz);
ylabel('$C_f$');
legend('Uncertainty estimates','Baseline','Experimental')
axis([-5,75,-.001,.002])
saveas(gcf,'images/diffuser_cf_bot.png')

for i=1:size(Cf_top_min,1)
    Cf_top_min(i) = min([Cf_top_1c(i),Cf_top_2c(i),Cf_top_3c(i),...
        Cf_top_p1c1(i),Cf_top_p1c2(i),Cf_top_base(i)]);
    Cf_top_max(i) = max([Cf_top_1c(i),Cf_top_2c(i),Cf_top_3c(i),...
        Cf_top_p1c1(i),Cf_top_p1c2(i),Cf_top_base(i)]);
end
figure(7)
%subplot(2,1,1)
betweenX= [wall(:,1);flipud(wall(:,1))];
betweenY= [Cf_top_min;flipud(Cf_top_max)];
fill(betweenX,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(wall(:,1),Cf_top_base,'k',expCf_top(:,1),expCf_top(:,2),'k.','MarkerSize',msz);
xlabel('$\frac{x}{H}$','FontSize',afz);
ylabel('$C_f$');
legend('Uncertainty estimates','Baseline','Experimental')
axis([-20,75,0,.01])
saveas(gcf,'images/diffuser_cf_top.png')
for i=1:size(x_min_32,1)
    x_min_32(i,4) = min([x_1c_32(i,4),x_2c_32(i,4),x_3c_32(i,4),...
        x_p1c1_32(i,4),x_p1c2_32(i,4),x_base_32(i,4)]);
    x_max_32(i,4) = max([x_1c_32(i,4),x_2c_32(i,4),x_3c_32(i,4),...
        x_p1c1_32(i,4),x_p1c2_32(i,4),x_base_32(i,4)]);
end

betweenX= [x_min_32(:,2)./H;flipud(x_max_32(:,2))./H];
betweenY= [x_min_32(:,4)./Ub;flipud(x_max_32(:,4))./Ub];

figure(6)
fill(10*betweenY+32,betweenX,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(10*x_base_32(:,4)./Ub + x_min_32(:,1)./H,x_base_32(:,2)./H,'k',...
    10*x_exp_32(:,2)+32,x_exp_32(:,1),'k.','MarkerSize',msz);
xlabel('$\frac{10u}{U_{ref}} + \frac{x}{H}$','FontSize',afz);
ylabel('$\frac{y}{H}$','FontSize',afz);
legend('Uncertainty estimates','Baseline','Experimental','location','southwest')

for i=1:size(x_min_neg6,1)
    x_min_neg6(i,4) = min([x_1c_neg6(i,4),x_2c_neg6(i,4),x_3c_neg6(i,4),...
        x_p1c1_neg6(i,4),x_p1c2_neg6(i,4),x_base_neg6(i,4)]);
    x_max_neg6(i,4) = max([x_1c_neg6(i,4),x_2c_neg6(i,4),x_3c_neg6(i,4),...
        x_p1c1_neg6(i,4),x_p1c2_neg6(i,4),x_base_neg6(i,4)]);
end

betweenX= [x_min_neg6(:,2)./H;flipud(x_max_neg6(:,2)./H)];
betweenY= [x_min_neg6(:,4)./Ub;flipud(x_max_neg6(:,4)./Ub)];

figure(6)
fill(10*betweenY-6,betweenX,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(10*x_base_neg6(:,4)./Ub + x_min_neg6(:,1)./H,x_base_neg6(:,2)./H,'k',...
    10*x_exp_neg6(:,2)-6,x_exp_neg6(:,1),'k.','MarkerSize',msz,'HandleVisibility','off');

for i=1:size(x_min_pos6,1)
    x_min_pos6(i,4) = min([x_1c_pos6(i,4),x_2c_pos6(i,4),x_3c_pos6(i,4),...
        x_p1c1_pos6(i,4),x_p1c2_pos6(i,4),x_base_pos6(i,4)]);
    x_max_pos6(i,4) = max([x_1c_pos6(i,4),x_2c_pos6(i,4),x_3c_pos6(i,4),...
        x_p1c1_pos6(i,4),x_p1c2_pos6(i,4),x_base_pos6(i,4)]);
end

betweenX= [x_min_pos6(:,2)./H;flipud(x_max_pos6(:,2)./H)];
betweenY= [x_min_pos6(:,4)./Ub;flipud(x_max_pos6(:,4)./Ub)];

figure(6)
fill(10*betweenY+6,betweenX,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(10*x_base_pos6(:,4)./Ub + x_min_pos6(:,1)./H,x_base_pos6(:,2)./H,'k',...
    10*x_exp_pos6(:,2)+6,x_exp_pos6(:,1),'k.','MarkerSize',msz,'HandleVisibility','off');

for i=1:size(x_min_17,1)
    x_min_17(i,4) = min([x_1c_17(i,4),x_2c_17(i,4),x_3c_17(i,4),...
        x_p1c1_17(i,4),x_p1c2_17(i,4),x_base_17(i,4)]);
    x_max_17(i,4) = max([x_1c_17(i,4),x_2c_17(i,4),x_3c_17(i,4),...
        x_p1c1_17(i,4),x_p1c2_17(i,4),x_base_17(i,4)]);
end

betweenX= [x_min_17(:,2)./H;flipud(x_max_17(:,2)./H)];
betweenY= [x_min_17(:,4)./Ub;flipud(x_max_17(:,4)./Ub)];

figure(6)
fill(10*betweenY+17,betweenX,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(10*x_base_17(:,4)./Ub + x_min_17(:,1)./H,x_base_17(:,2)./H,'k',...
    10*x_exp_17(:,2)+17,x_exp_17(:,1),'k.','MarkerSize',msz,'HandleVisibility','off');

for i=1:size(x_min_27,1)
    x_min_27(i,4) = min([x_1c_27(i,4),x_2c_27(i,4),x_3c_27(i,4),...
        x_p1c1_27(i,4),x_p1c2_27(i,4),x_base_27(i,4)]);
    x_max_27(i,4) = max([x_1c_27(i,4),x_2c_27(i,4),x_3c_27(i,4),...
        x_p1c1_27(i,4),x_p1c2_27(i,4),x_base_27(i,4)]);
end

betweenX= [x_min_27(:,2)./H;flipud(x_max_27(:,2)./H)];
betweenY= [x_min_27(:,4)./Ub;flipud(x_max_27(:,4)./Ub)];

figure(6)
fill(10*betweenY+27,betweenX,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(10*x_base_27(:,4)./Ub + x_min_27(:,1)./H,x_base_27(:,2)./H,'k',...
    10*x_exp_27(1:end-1,2)+27,x_exp_27(1:end-1,1),'k.','MarkerSize',msz,'HandleVisibility','off');
saveas(gcf,'images/diffuser_vel_prof.png')