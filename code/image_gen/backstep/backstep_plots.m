clear variables
close all
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

ms = 14;
%% baseline
H = .5*.0254;
Ub = 47.95;

c=285;
r=1;
simData = dlmread('flowData');
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);
simData(:,3) = 1.09023 * ones(n,1);
% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));
Ub = max(simData(700:760,4));

eps = 1e-4;
wall = [];
wallPlus= [];
x_base_10=[];
x_base_5=[];
x_base_2_5=[];
x_base_7=[];
for i=1:n
    if abs(simData(i,2)/H) < eps 
        wall= [wall; simData(i,:)];
    elseif abs(simData(i,2)/H-1) < eps && simData(i,1) <=0
        wall=[wall; simData(i,:)];
    end
    
    if abs(simData(i,1)/H - 10) < .2 && simData(i,2)/H < 3
        x_base_10 = [x_base_10; simData(i,:)];
    end
    if abs(simData(i,1)/H - 7) < .2 && simData(i,2)/H < 3
        x_base_7 = [x_base_7; simData(i,:)];
    end
    if abs(simData(i,1)/H - 5) < .1 && simData(i,2)/H < 3
        x_base_5 = [x_base_5; simData(i,:)];
    end
    if abs(simData(i,1)/H - 2.5) < .1 && simData(i,2)/H < 3
        x_base_2_5 = [x_base_2_5; simData(i,:)];
    end
       
end
wall=sortrows(wall);
x_base_10 = sortrows(x_base_10,2);
x_base_5 = sortrows(x_base_5,2);
x_base_2_5 = sortrows(x_base_2_5,2);

du_dy_wall= wall(:,22);
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_base=tauWall./(wall(:,3)*.5*Ub^2);

x_base_2_5(:,4)=x_base_2_5(:,4)./Ub;
x_base_5(:,4)=x_base_5(:,4)./Ub;

% figure(1)
% plot(wall(:,1)/H,Cf_bot_base,'k');
% axis([0,20,-.003,.004])
% hold on
% 
% figure(2)
% plot(x_base_2_5(:,2)./H,x_base_2_5(:,4),'k')
% axis([0,2,-.5,.95])
% hold on

%% 1c Perturbation

simData = dlmread('1c/flowData');
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);
simData(:,3) = 1.09023 * ones(n,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));
Ub = max(simData(700:760,4));

eps = 1e-4;
wall = [];
wallPlus= [];
x_1c_10=[];
x_1c_5=[];
x_1c_2_5=[];
x_1c_7=[];
for i=1:n
    if abs(simData(i,2)/H) < eps 
        wall= [wall; simData(i,:)];
    elseif abs(simData(i,2)/H-1) < eps && simData(i,1) <=0
        wall=[wall; simData(i,:)];
    end
    
    if abs(simData(i,1)/H - 10) < .2 && simData(i,2)/H < 3
        x_1c_10 = [x_1c_10; simData(i,:)];
    end
    if abs(simData(i,1)/H - 7) < .2 && simData(i,2)/H < 3
        x_1c_7 = [x_1c_7; simData(i,:)];
    end
    if abs(simData(i,1)/H - 5) < .1 && simData(i,2)/H < 3
        x_1c_5 = [x_1c_5; simData(i,:)];
    end
    if abs(simData(i,1)/H - 2.5) < .1 && simData(i,2)/H < 3
        x_1c_2_5 = [x_1c_2_5; simData(i,:)];
    end
       
end
wall=sortrows(wall);
x_1c_10 = sortrows(x_1c_10,2);
x_1c_5 = sortrows(x_1c_5,2);
x_1c_2_5 = sortrows(x_1c_2_5,2);

du_dy_wall= wall(:,22);
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_1c=tauWall./(wall(:,3)*.5*Ub^2);

x_1c_2_5(:,4)=x_1c_2_5(:,4)./Ub;
x_1c_5(:,4)=x_1c_5(:,4)./Ub;
% 
% figure(1)
% plot(wall(:,1)/H,Cf_bot_1c);
% 
% figure(2)
% plot(x_1c_2_5(:,2)./H,x_1c_2_5(:,4))

%% 2C Perturbation

simData = dlmread('2c/flowData');
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);
simData(:,3) = 1.09023 * ones(n,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));
%Ub = max(simData(:,4));
Ub = max(simData(700:760,4));

eps = 1e-4;
wall = [];
wallPlus= [];
x_2c_10=[];
x_2c_5=[];
x_2c_2_5=[];
x_2c_7=[];

for i=1:n
    if abs(simData(i,2)/H) < eps 
        wall= [wall; simData(i,:)];
    elseif abs(simData(i,2)/H-1) < eps && simData(i,1) <=0
        wall=[wall; simData(i,:)];
    end
    
    if abs(simData(i,1)/H - 10) < .2 && simData(i,2)/H < 3
        x_2c_10 = [x_2c_10; simData(i,:)];
    end
    if abs(simData(i,1)/H - 7) < .2 && simData(i,2)/H < 3
        x_2c_7 = [x_2c_7; simData(i,:)];
    end
    if abs(simData(i,1)/H - 5) < .1 && simData(i,2)/H < 3
        x_2c_5 = [x_2c_5; simData(i,:)];
    end
    if abs(simData(i,1)/H - 2.5) < .1 && simData(i,2)/H < 3
        x_2c_2_5 = [x_2c_2_5; simData(i,:)];
    end
       
end
wall=sortrows(wall);
x_2c_10 = sortrows(x_2c_10,2);
x_2c_5 = sortrows(x_2c_5,2);
x_2c_2_5 = sortrows(x_2c_2_5,2);

du_dy_wall= wall(:,22);
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_2c=tauWall./(wall(:,3)*.5*Ub^2);

x_2c_2_5(:,4)=x_2c_2_5(:,4)./Ub;
x_2c_5(:,4)=x_2c_5(:,4)./Ub;

% figure(1)
% plot(wall(:,1)/H,Cf_bot_2c);
% 
% figure(2)
% plot(x_2c_2_5(:,2)./H,x_2c_2_5(:,4))


%% 3C perturbation

simData = dlmread('3c/flowData');
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);
simData(:,3) = 1.09023 * ones(n,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));
Ub = max(simData(700:760,4));

eps = 1e-4;
wall = [];
wallPlus= [];
x_3c_10=[];
x_3c_5=[];
x_3c_2_5=[];
x_3c_7=[];
for i=1:n
    if abs(simData(i,2)/H) < eps 
        wall= [wall; simData(i,:)];
    elseif abs(simData(i,2)/H-1) < eps && simData(i,1) <=0
        wall=[wall; simData(i,:)];
    end
    
    if abs(simData(i,1)/H - 10) < .2 && simData(i,2)/H < 3
        x_3c_10 = [x_3c_10; simData(i,:)];
    end
    if abs(simData(i,1)/H - 7) < .2 && simData(i,2)/H < 3
        x_3c_7 = [x_3c_7; simData(i,:)];
    end
    if abs(simData(i,1)/H - 5) < .1 && simData(i,2)/H < 3
        x_3c_5 = [x_3c_5; simData(i,:)];
    end
    if abs(simData(i,1)/H - 2.5) < .1 && simData(i,2)/H < 3
        x_3c_2_5 = [x_3c_2_5; simData(i,:)];
    end
       
end
wall=sortrows(wall);
x_3c_10 = sortrows(x_3c_10,2);
x_3c_5 = sortrows(x_3c_5,2);
x_3c_2_5 = sortrows(x_3c_2_5,2);
du_dy_wall= wall(:,22);
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_3c=tauWall./(wall(:,3)*.5*Ub^2);

x_3c_2_5(:,4)=x_3c_2_5(:,4)./Ub;
x_3c_5(:,4)=x_3c_5(:,4)./Ub;
% 
% figure(1)
% plot(wall(:,1)/H,Cf_bot_3c);
% 
% figure(2)
% plot(x_3c_2_5(:,2)./H,x_3c_2_5(:,4))

%% P1C1 perturbation
simData = dlmread('p1c1/flowData');
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);
simData(:,3) = 1.09023 * ones(n,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));
Ub = max(simData(700:760,4));

eps = 1e-4;
wall = [];
wallPlus= [];
x_p1c1_10=[];
x_p1c1_5=[];
x_p1c1_2_5=[];
x_p1c1_7=[];

for i=1:n
    if abs(simData(i,2)/H) < eps 
        wall= [wall; simData(i,:)];
    elseif abs(simData(i,2)/H-1) < eps && simData(i,1) <=0
        wall=[wall; simData(i,:)];
    end
    
    if abs(simData(i,1)/H - 10) < .2 && simData(i,2)/H < 3
        x_p1c1_10 = [x_p1c1_10; simData(i,:)];
    end
    if abs(simData(i,1)/H - 7) < .2 && simData(i,2)/H < 3
        x_p1c1_7 = [x_p1c1_7; simData(i,:)];
    end
    if abs(simData(i,1)/H - 5) < .1 && simData(i,2)/H < 3
        x_p1c1_5 = [x_p1c1_5; simData(i,:)];
    end
    if abs(simData(i,1)/H - 2.5) < .1 && simData(i,2)/H < 3
        x_p1c1_2_5 = [x_p1c1_2_5; simData(i,:)];
    end
       
end
wall=sortrows(wall);
x_p1c1_10 = sortrows(x_p1c1_10,2);
x_p1c1_5 = sortrows(x_p1c1_5,2);
x_p1c1_2_5 = sortrows(x_p1c1_2_5,2);

du_dy_wall= wall(:,22);
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_p1c1=tauWall./(wall(:,3)*.5*Ub^2);

x_p1c1_2_5(:,4)=x_p1c1_2_5(:,4)./Ub;
x_p1c1_5(:,4)=x_p1c1_5(:,4)./Ub;

% figure(1)
% plot(wall(:,1)/H,Cf_bot_p1c1);
% 
% figure(2)
% plot(x_p1c1_2_5(:,2)./H,x_p1c1_2_5(:,4))
%% P1C2 perturbation

simData = dlmread('p1c2/flowData');
% mirrData= simData;
% mirrData(:,2) = -mirrData(:,2);
% simData= [simData; flipud(mirrData)];
n = size(simData,1);
simData(:,3) = 1.09023 * ones(n,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2);
simData(:,4)= simData(:,4) ./ (simData(:,3));
simData(:,5)= simData(:,5) ./ (simData(:,3));
Ub = max(simData(700:760,4));

eps = 1e-4;
wall = [];
wallPlus= [];
x_p1c2_10=[];
x_p1c2_5=[];
x_p1c2_2_5=[];
x_p1c2_7=[];
for i=1:n
    if abs(simData(i,2)/H) < eps 
        wall= [wall; simData(i,:)];
    elseif abs(simData(i,2)/H-1) < eps && simData(i,1) <=0
        wall=[wall; simData(i,:)];
    end
    
    if abs(simData(i,1)/H - 10) < .2 && simData(i,2)/H < 3
        x_p1c2_10 = [x_p1c2_10; simData(i,:)];
    end
    if abs(simData(i,1)/H - 7) < .2 && simData(i,2)/H < 3
        x_p1c2_7 = [x_p1c2_7; simData(i,:)];
    end
    if abs(simData(i,1)/H - 5) < .1 && simData(i,2)/H < 3
        x_p1c2_5 = [x_p1c2_5; simData(i,:)];
    end
    if abs(simData(i,1)/H - 2.5) < .1 && simData(i,2)/H < 3
        x_p1c2_2_5 = [x_p1c2_2_5; simData(i,:)];
    end
       
end
wall=sortrows(wall);
x_p1c2_10 = sortrows(x_p1c2_10,2);
x_p1c2_5 = sortrows(x_p1c2_5,2);
x_p1c2_2_5 = sortrows(x_p1c2_2_5,2);

du_dy_wall= wall(:,22);
tauWall=du_dy_wall.*wall(:,13);
Cf_bot_p1c2=tauWall./(wall(:,3)*.5*Ub^2);

x_p1c2_2_5(:,4)=x_p1c2_2_5(:,4)./Ub;
x_p1c2_5(:,4)=x_p1c2_5(:,4)./Ub;
% figure(1)
% plot(wall(:,1)/H,Cf_bot_p1c2);
% 
% figure(2)
% plot(x_p1c2_2_5(:,2)./H,x_p1c2_2_5(:,4))

%% Experimental Data
expCf_bot= dlmread('expData/cf_bot_exp.csv',',');
expCf_bot=expCf_bot(:,1:2);

x_exp_10 = dlmread('expData/x_exp_10.csv',',');
x_exp_10= x_exp_10(:,2:3);

x_exp_7 = dlmread('expData/x_exp_7.csv',',');
x_exp_7= x_exp_7(:,2:3);

x_exp_5 = dlmread('expData/x_exp_5.csv',',');
x_exp_5= x_exp_5(:,2:3);

x_exp_2_5 = dlmread('expData/x_exp_2_5.csv',',');
x_exp_2_5= x_exp_2_5(:,2:3);

% figure(1)
% plot(expCf_bot(:,1),expCf_bot(:,2),'k.')
% legend('Baseline Sim','1c','2c','3c','p1c1','p1c2','PIV')
% 
% 
% figure(2)
% plot(x_exp_2_5(:,1),x_exp_2_5(:,2),'k.');
% legend('Baseline Sim','1c','2c','3c','p1c1','p1c2','PIV')



%% Shade Plot
wall(:,1:2) = wall(:,1:2)./H;
gray=1/255*[200,200,200];

Cf_bot_min=Cf_bot_1c;
Cf_bot_max=Cf_bot_1c;

x_min_10=x_1c_10;
x_max_10=x_1c_10;

for i=1:size(Cf_bot_min,1)
    Cf_bot_min(i) = min([Cf_bot_1c(i),Cf_bot_2c(i),Cf_bot_2c(i),...
        Cf_bot_p1c1(i),Cf_bot_p1c2(i),Cf_bot_base(i)]);
    Cf_bot_max(i) = max([Cf_bot_1c(i),Cf_bot_2c(i),Cf_bot_2c(i),...
        Cf_bot_p1c1(i),Cf_bot_p1c2(i),Cf_bot_base(i)]);
end

figure(3)
betweenX= [wall(:,1);flipud(wall(:,1))];
betweenY= [Cf_bot_min;flipud(Cf_bot_max)];
fill(betweenX,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
inds = wall(:,1) > 0.0;
plot(wall(inds,1),Cf_bot_base(inds),'k',expCf_bot(:,1),expCf_bot(:,2),'k.','MarkerSize',msz);
axis([0,20,-.003,.004])
xlabel('$\frac{x}{H}$','FontSize',afz);
ylabel('$C_f$');
legend('Uncertainty estimates','Baseline','Experimental','Location','southeast')
axis([0,20,-.003,.004])
saveas(gcf,'images\backstep_cf_bot.png')

for i=1:size(x_min_10,1)
    x_min_10(i,4) = min([x_1c_10(i,4),x_2c_10(i,4),x_3c_10(i,4),...
        x_p1c1_10(i,4),x_p1c2_10(i,4),x_base_10(i,4)]);
    x_max_10(i,4) = max([x_1c_10(i,4),x_2c_10(i,4),x_3c_10(i,4),...
        x_p1c1_10(i,4),x_p1c2_10(i,4),x_base_10(i,4)]);
end

betweenY= [x_min_10(:,2)./H;flipud(x_max_10(:,2))./H];
betweenX= [x_min_10(:,4)./Ub;flipud(x_max_10(:,4))./Ub];
figure(5)
fill(betweenX+10/2,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(x_base_10(:,4)./Ub + x_base_10(:,1)./(2*H),x_base_10(:,2)./H,'k',...
    x_exp_10(:,2)+10/2,x_exp_10(:,1),'k.','MarkerSize',msz);
ylabel('$\frac{y}{H}$','FontSize',afz);
xlabel('$\frac{u}{U_{ref}} + \frac{x}{2H}$','FontSize',afz);
axis([1,.95+5,0,2])


x_min_5=x_1c_5;
x_max_5=x_1c_5;
x_min_2_5=x_1c_2_5;
x_max_2_5=x_1c_2_5;
x_min_7=x_1c_7;
x_max_7=x_1c_7;

for i=1:size(x_min_5,1)
    x_min_5(i,4) = min([x_1c_5(i,4),x_2c_5(i,4),x_3c_5(i,4),...
        x_p1c1_5(i,4),x_p1c2_5(i,4),x_base_5(i,4)]);
    x_max_5(i,4) = max([x_1c_5(i,4),x_2c_5(i,4),x_3c_5(i,4),...
        x_p1c1_5(i,4),x_p1c2_5(i,4),x_base_5(i,4)]);
end

betweenY= [x_min_5(:,2)./H;flipud(x_max_5(:,2))./H];
betweenX= [x_min_5(:,4);flipud(x_max_5(:,4))];
figure(5)
fill(betweenX+5/2,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(x_base_5(:,4) + x_base_5(:,1)./(2*H),x_base_5(:,2)./H,'k',...
    x_exp_5(:,2)+5/2,x_exp_5(:,1),'k.','MarkerSize',msz);
%axis([-.05,1.2,0,1.4])

for i=1:size(x_min_2_5,1)
    x_min_2_5(i,4) = min([x_1c_2_5(i,4),x_2c_2_5(i,4),x_3c_2_5(i,4),...
        x_p1c1_2_5(i,4),x_p1c2_2_5(i,4),x_base_2_5(i,4)]);
    x_max_2_5(i,4) = max([x_1c_2_5(i,4),x_2c_2_5(i,4),x_3c_2_5(i,4),...
        x_p1c1_2_5(i,4),x_p1c2_2_5(i,4),x_base_2_5(i,4)]);
end

betweenY= [x_min_2_5(:,2)./H;flipud(x_max_2_5(:,2))./H];
betweenX= [x_min_2_5(:,4);flipud(x_max_2_5(:,4))];

figure(5)
fill(betweenX+2.5/2,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(x_base_2_5(:,4) + x_base_2_5(:,1)./(2*H),x_base_2_5(:,2)./H,'k',...
    x_exp_2_5(:,2)+2.5/2,x_exp_2_5(:,1),'k.','MarkerSize',msz);


for i=1:size(x_min_7,1)
    x_min_7(i,4) = min([x_1c_7(i,4),x_2c_7(i,4),x_3c_7(i,4),...
        x_p1c1_7(i,4),x_p1c2_7(i,4),x_base_7(i,4)]);
    x_max_7(i,4) = max([x_1c_7(i,4),x_2c_7(i,4),x_3c_7(i,4),...
        x_p1c1_7(i,4),x_p1c2_7(i,4),x_base_7(i,4)]);
end

betweenY= [x_min_7(:,2)./H;flipud(x_max_7(:,2))./H];
betweenX= [x_min_7(:,4)./Ub;flipud(x_max_7(:,4))./Ub];

figure(5)
fill(betweenX+7/2,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(x_base_7(:,4)./Ub + 7/2,x_base_7(:,2)./H,'k',...
    x_exp_7(:,2)+7/2,x_exp_7(:,1),'k.','MarkerSize',msz);

saveas(gcf,'images/backstep_vel_prof.png')
