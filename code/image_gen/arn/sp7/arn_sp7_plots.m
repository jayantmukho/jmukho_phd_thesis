clear variables
% The new defaults will not take effect if there are any open figures. To
% use them, we close all figures, and then repeat the first example.
close all;

% Defaults for this blog post
width = 8.5;     % Width in inches
height = 3;    % Height in inches
alw = 0.5;    % AxesLineWidth
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
lw=1.2;
msz=12;

Djet = .0508;
Ujet = 306;
%% Baseline
simData = dlmread('SARestart/flow.dat','\t',3,0);
k= find(simData(:,12));
simData = simData(k,:);
simData = simData(1:4680,:);

n = size(simData,1);

% Normalize Variables
simData(:,1:2) = simData(:,1:2)./Djet;
simData(:,5)= simData(:,5) ./ (simData(:,4) * Ujet);
simData(:,6)= simData(:,6) ./ (simData(:,4) * Ujet);
centerline_base = [];
x_base_4 = [];
x_base_8 = [];
x_base_12 = [];
x_base_16 = [];
eps = 1e-1;
for i=1:n
    if simData(i,2)==0 && simData(i,1)>=1 && simData(i,1)<=25
        centerline_base=[centerline_base; simData(i,:)];
        
    end
    if abs(simData(i,1)- 4) < eps && abs(simData(i,2))<=1.6;
        x_base_4= [x_base_4; simData(i,:)];
    elseif abs(simData(i,1)- 8) < eps && abs(simData(i,2))<=1.6;
        x_base_8= [x_base_8; simData(i,:)];
    elseif abs(simData(i,1)- 12) < .25 && abs(simData(i,2))<=1.6;
        x_base_12= [x_base_12; simData(i,:)];
    elseif abs(simData(i,1)- 16) < .6 && abs(simData(i,2))<=1.6;
        x_base_16= [x_base_16; simData(i,:)];
    end
end
centerline_base = sortrows(centerline_base,1);
x_base_4 = sortrows(x_base_4,2);
x_base_8 = sortrows(x_base_8,2);
x_base_12 = sortrows(x_base_12,2);
x_base_16 = sortrows(x_base_16,2);

%%
simData = dlmread('1c/flow.dat','\t',3,0);
k=find(simData(:,12));
simData = simData(k,:);
simData = simData(1:4680,:);

n = size(simData,1);
% Normalize Variables
simData(:,1:2) = simData(:,1:2)./Djet;
simData(:,5)= simData(:,5) ./ (simData(:,4) * Ujet);
simData(:,6)= simData(:,6) ./ (simData(:,4) * Ujet);
centerline_1c = [];
x_1c_4 = [];
x_1c_8 = [];
x_1c_12 = [];
x_1c_16 = [];
eps = 1e-1;
for i=1:n
    if simData(i,2)==0 && simData(i,1)>=1 && simData(i,1)<=25
        centerline_1c=[centerline_1c; simData(i,:)];
    end
    if abs(simData(i,1)- 4) < eps && abs(simData(i,2))<=1.6;
        x_1c_4= [x_1c_4; simData(i,:)];
    elseif abs(simData(i,1)- 8) < eps && abs(simData(i,2))<=1.6;
        x_1c_8= [x_1c_8; simData(i,:)];
    elseif abs(simData(i,1)- 12) < .25 && abs(simData(i,2))<=1.6;
        x_1c_12= [x_1c_12; simData(i,:)];
    elseif abs(simData(i,1)- 16) < .6 && abs(simData(i,2))<=1.6;
        x_1c_16= [x_1c_16; simData(i,:)];
    end
end
centerline_1c = sortrows(centerline_1c,1);
x_1c_4 = sortrows(x_1c_4,2);
x_1c_8 = sortrows(x_1c_8,2);
x_1c_12 = sortrows(x_1c_12,2);
x_1c_16 = sortrows(x_1c_16,2);

%% 2c
simData = dlmread('2c/flow.dat','\t',3,0);
k=find(simData(:,12));
simData = simData(k,:);
simData = simData(1:4680,:);

n = size(simData,1);
% Normalize Variables
simData(:,1:2) = simData(:,1:2)./Djet;
simData(:,5)= simData(:,5) ./ (simData(:,4) * Ujet);
simData(:,6)= simData(:,6) ./ (simData(:,4) * Ujet);
centerline_2c = [];
x_2c_4 = [];
x_2c_8 = [];
x_2c_12 = [];
x_2c_16 = [];
eps = 1e-1;
for i=1:n
    if simData(i,2)==0 && simData(i,1)>=1 && simData(i,1)<=25
        centerline_2c=[centerline_2c; simData(i,:)];
    end
    if abs(simData(i,1)- 4) < eps && abs(simData(i,2))<=1.6;
        x_2c_4= [x_2c_4; simData(i,:)];
    elseif abs(simData(i,1)- 8) < eps && abs(simData(i,2))<=1.6;
        x_2c_8= [x_2c_8; simData(i,:)];
    elseif abs(simData(i,1)- 12) < .25 && abs(simData(i,2))<=1.6;
        x_2c_12= [x_2c_12; simData(i,:)];
    elseif abs(simData(i,1)- 16) < .6 && abs(simData(i,2))<=1.6;
        x_2c_16= [x_2c_16; simData(i,:)];
    end
end
centerline_2c = sortrows(centerline_2c,1);
x_2c_4 = sortrows(x_2c_4,2);
x_2c_8 = sortrows(x_2c_8,2);
x_2c_12 = sortrows(x_2c_12,2);
x_2c_16 = sortrows(x_2c_16,2);

%% 3c
simData = dlmread('2c/flow.dat','\t',3,0);
k=find(simData(:,12));
simData = simData(k,:);
simData = simData(1:4680,:);

n = size(simData,1);
% Normalize Variables
simData(:,1:2) = simData(:,1:2)./Djet;
simData(:,5)= simData(:,5) ./ (simData(:,4) * Ujet);
simData(:,6)= simData(:,6) ./ (simData(:,4) * Ujet);
centerline_3c = [];
x_3c_4 = [];
x_3c_8 = [];
x_3c_12 = [];
x_3c_16 = [];
eps = 1e-1;
for i=1:n
    if simData(i,2)==0 && simData(i,1)>=1 && simData(i,1)<=25
        centerline_3c=[centerline_3c; simData(i,:)];
    end
    if abs(simData(i,1)- 4) < eps && abs(simData(i,2))<=1.6;
        x_3c_4= [x_3c_4; simData(i,:)];
    elseif abs(simData(i,1)- 8) < eps && abs(simData(i,2))<=1.6;
        x_3c_8= [x_3c_8; simData(i,:)];
    elseif abs(simData(i,1)- 12) < .25 && abs(simData(i,2))<=1.6;
        x_3c_12= [x_3c_12; simData(i,:)];
    elseif abs(simData(i,1)- 16) < .6 && abs(simData(i,2))<=1.6;
        x_3c_16= [x_3c_16; simData(i,:)];
    end
end
centerline_3c = sortrows(centerline_3c,1);
x_3c_4 = sortrows(x_3c_4,2);
x_3c_8 = sortrows(x_3c_8,2);
x_3c_12 = sortrows(x_3c_12,2);
x_3c_16 = sortrows(x_3c_16,2);

x_3c_4(:,5) = x_3c_4(:,5) + 0.025;
x_3c_8(:,5) = x_3c_8(:,5) + 0.025;
x_3c_12(:,5) = x_3c_12(:,5) + 0.025;
x_3c_16(:,5) = x_3c_16(:,5) + 0.025;

%% p1c1
simData = dlmread('p1c1/flow.dat','\t',3,0);
k=find(simData(:,12));
simData = simData(k,:);
simData = simData(1:4680,:);

n = size(simData,1);
% Normalize Variables
simData(:,1:2) = simData(:,1:2)./Djet;
simData(:,5)= simData(:,5) ./ (simData(:,4) * Ujet);
simData(:,6)= simData(:,6) ./ (simData(:,4) * Ujet);
centerline_p1c1 = [];
x_p1c1_4 = [];
x_p1c1_8 = [];
x_p1c1_12 = [];
x_p1c1_16 = [];
eps = 1e-1;
for i=1:n
    if simData(i,2)==0 && simData(i,1)>=1 && simData(i,1)<=25
        centerline_p1c1=[centerline_p1c1; simData(i,:)];
    end
    if abs(simData(i,1)- 4) < eps && abs(simData(i,2))<=1.6;
        x_p1c1_4= [x_p1c1_4; simData(i,:)];
    elseif abs(simData(i,1)- 8) < eps && abs(simData(i,2))<=1.6;
        x_p1c1_8= [x_p1c1_8; simData(i,:)];
    elseif abs(simData(i,1)- 12) < .25 && abs(simData(i,2))<=1.6;
        x_p1c1_12= [x_p1c1_12; simData(i,:)];
    elseif abs(simData(i,1)- 16) < .6 && abs(simData(i,2))<=1.6;
        x_p1c1_16= [x_p1c1_16; simData(i,:)];
    end
end
centerline_p1c1 = sortrows(centerline_p1c1,1);
x_p1c1_4 = sortrows(x_p1c1_4,2);
x_p1c1_8 = sortrows(x_p1c1_8,2);
x_p1c1_12 = sortrows(x_p1c1_12,2);
x_p1c1_16 = sortrows(x_p1c1_16,2);

%% p1c2
simData = dlmread('p1c2/flow.dat','\t',3,0);
k=find(simData(:,12));
simData = simData(k,:);
simData = simData(1:4680,:);

n = size(simData,1);
% Normalize Variables
simData(:,1:2) = simData(:,1:2)./Djet;
simData(:,5)= simData(:,5) ./ (simData(:,4) * Ujet);
simData(:,6)= simData(:,6) ./ (simData(:,4) * Ujet);
centerline_p1c2 = [];
x_p1c2_4 = [];
x_p1c2_8 = [];
x_p1c2_12 = [];
x_p1c2_16 = [];
eps = 1e-1;
for i=1:n
    if simData(i,2)==0 && simData(i,1)>=1 && simData(i,1)<=25
        centerline_p1c2=[centerline_p1c2; simData(i,:)];
    end
    if abs(simData(i,1)- 4) < eps && abs(simData(i,2))<=1.6;
        x_p1c2_4= [x_p1c2_4; simData(i,:)];
    elseif abs(simData(i,1)- 8) < eps && abs(simData(i,2))<=1.6;
        x_p1c2_8= [x_p1c2_8; simData(i,:)];
    elseif abs(simData(i,1)- 12) < .25 && abs(simData(i,2))<=1.6;
        x_p1c2_12= [x_p1c2_12; simData(i,:)];
    elseif abs(simData(i,1)- 16) < .6 && abs(simData(i,2))<=1.6;
        x_p1c2_16= [x_p1c2_16; simData(i,:)];
    end
end
centerline_p1c2 = sortrows(centerline_p1c2,1);
x_p1c2_4 = sortrows(x_p1c2_4,2);
x_p1c2_8 = sortrows(x_p1c2_8,2);
x_p1c2_12 = sortrows(x_p1c2_12,2);
x_p1c2_16 = sortrows(x_p1c2_16,2);

%% Reading experimental file
opts = detectImportOptions('Tx_X_SP7_1ptn_Sym.dat');
expData = readmatrix('Tx_X_SP7_1ptn_Sym.dat',opts);
opts = detectImportOptions('Tx_X_SP7_1ptn_Sig.dat');
expErr = readmatrix('Tx_X_SP7_1ptn_Sig.dat',opts);
nExp = size(expData,1);

centerline = [];
centerline_err=[];
x_4 = [];
err_4=[];
x_8 = [];
err_8 = [];
x_12 = [];
err_12 = [];
x_16 = [];
err_16 = [];
eps = 1e-2;
for i=1:nExp
    if abs(expData(i,2)-0)<eps
        centerline=[centerline; expData(i,:)];
        centerline_err = [centerline_err; expErr(i,:)];
    end
    if abs(expData(i,1)- 4) < eps && expData(i,2)>=0;
        x_4= [x_4; expData(i,:)];
        err_4 = [err_4; expErr(i,:)];
    elseif abs(expData(i,1)- 8) < eps && expData(i,2)>=0;
        x_8= [x_8; expData(i,:)];
        err_8 = [err_8; expErr(i,:)];
    elseif abs(expData(i,1)- 12) < eps && expData(i,2)>=0;
        x_12= [x_12; expData(i,:)];
        err_12 = [err_12; expErr(i,:)];
    elseif abs(expData(i,1)- 16) < eps && expData(i,2)>=0;
        x_16= [x_16; expData(i,:)];
        err_16 = [err_16; expErr(i,:)];
    end
end

%% Shade Plot
gray=1/255*[200,200,200];

x_min_4=x_1c_4;
x_max_4=x_1c_4;
x_min_8=x_1c_8;
x_max_8=x_1c_8;
x_min_12=x_1c_12;
x_max_12=x_1c_12;
x_min_16=x_1c_16;
x_max_16=x_1c_16;

for i=1:size(x_min_4,1)
    x_min_4(i,5) = min([x_1c_4(i,5),x_2c_4(i,5),x_3c_4(i,5),...
        x_p1c1_4(i,5),x_p1c2_4(i,5),x_base_4(i,5)]);
    x_max_4(i,5) = max([x_1c_4(i,5),x_2c_4(i,5),x_3c_4(i,5),...
        x_p1c1_4(i,5),x_p1c2_4(i,5),x_base_4(i,5)]);
end

figure(4)
betweenX= [x_min_4(:,5);flipud(x_max_4(:,5))];
betweenY= [x_min_4(:,2);flipud(x_max_4(:,2))];
fill(betweenX+1,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(x_base_4(:,5)+1,x_base_4(:,2),'k');
errorbar(x_4(1:3:end,4)+1,x_4(1:3:end,2),err_4(1:3:end,4),'horizontal','k.','LineWidth',lw,'MarkerSize',msz);
xlabel('$\frac{u}{U_{jet}}+\frac{x}{4D_{jet}}$','FontSize',afz);
ylabel('$\frac{y}{D_{jet}}$','FontSize',afz);
% legend('Uncertainty estimates','Baseline','PIV','Location','southwest')

for i=1:size(x_min_8,1)
    x_min_8(i,5) = min([x_1c_8(i,5),x_2c_8(i,5),x_3c_8(i,5),...
        x_p1c1_8(i,5),x_p1c2_8(i,5),x_base_8(i,5)]);
    x_max_8(i,5) = max([x_1c_8(i,5),x_2c_8(i,5),x_3c_8(i,5),...
        x_p1c1_8(i,5),x_p1c2_8(i,5),x_base_8(i,5)]);
end

betweenX= [x_min_8(:,5);flipud(x_max_8(:,5))];
betweenY= [x_min_8(:,2);flipud(x_max_8(:,2))];
figure(4)
fill(betweenX+2,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(x_base_8(:,5)+2,x_base_8(:,2),'k','HandleVisibility','off');
errorbar(x_8(1:3:end,4)+2,x_8(1:3:end,2),err_8(1:3:end,4),'horizontal','k.','LineWidth',lw,'MarkerSize',msz,'HandleVisibility','off');


for i=1:size(x_min_12,1)
    x_min_12(i,5) = min([x_1c_12(i,5),x_2c_12(i,5),x_3c_12(i,5),...
        x_p1c1_12(i,5),x_p1c2_12(i,5),x_base_12(i,5)]);
    x_max_12(i,5) = max([x_1c_12(i,5),x_2c_12(i,5),x_3c_12(i,5),...
        x_p1c1_12(i,5),x_p1c2_12(i,5),x_base_12(i,5)]);
end

betweenX= [x_min_12(:,5);flipud(x_max_12(:,5))];
betweenY= [x_min_12(:,2);flipud(x_max_12(:,2))];
figure(4)
fill(betweenX+3,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(x_base_12(:,5)+3,x_base_12(:,2),'k','HandleVisibility','off');
errorbar(x_12(1:3:end,4)+3,x_12(1:3:end,2),err_12(1:3:end,4),'horizontal','k.','LineWidth',lw,'MarkerSize',msz,'HandleVisibility','off');

for i=1:size(x_min_16,1)
    x_min_16(i,5) = min([x_1c_16(i,5),x_2c_16(i,5),x_3c_16(i,5),...
        x_p1c1_16(i,5),x_p1c2_16(i,5),x_base_16(i,5)]);
    x_max_16(i,5) = max([x_1c_16(i,5),x_2c_16(i,5),x_3c_16(i,5),...
        x_p1c1_16(i,5),x_p1c2_16(i,5),x_base_16(i,5)]);
end

betweenX= [x_min_16(:,5);flipud(x_max_16(:,5))];
betweenY= [x_min_16(:,2);flipud(x_max_16(:,2))];
figure(4)
fill(betweenX+4,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(x_base_16(:,5)+4,x_base_16(:,2),'k','HandleVisibility','off');
errorbar(x_16(1:3:end,4)+4,x_16(1:3:end,2),err_16(1:3:end,4),'horizontal','k.','LineWidth',lw,'MarkerSize',msz,'HandleVisibility','off');
axis([.8,4.7,0,1.3])
saveas(gcf,'images/arn_sp7_vel_prof.png')

centerline_min = centerline_base;
centerline_max = centerline_base;
for i=1:size(centerline_min,1)
    centerline_min(i,5) = min([centerline_1c(i,5),centerline_2c(i,5),centerline_3c(i,5),...
        centerline_p1c1(i,5),centerline_p1c2(i,5),centerline_base(i,5)]);
    centerline_max(i,5) = max([centerline_1c(i,5),centerline_2c(i,5),centerline_3c(i,5),...
        centerline_p1c1(i,5),centerline_p1c2(i,5),centerline_base(i,5)]);
end
figure(5)
betweenX= [centerline_min(:,1);flipud(centerline_max(:,1))];
betweenY= [centerline_min(:,5);flipud(centerline_max(:,5))];
fill(betweenX,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(centerline_base(:,1),centerline_base(:,5),'k')
errorbar(centerline(1:3:end,1),centerline(1:3:end,4),centerline_err(1:3:end,4),'k.','LineWidth',lw,'MarkerSize',msz);
xlabel('$\frac{x}{D_{jet}}$','FontSize',afz);
ylabel('$\frac{u}{U_{jet}}$','FontSize',afz);
legend('Uncertainty estimates','Baseline','PIV')
axis([1,15,0,1.4])
saveas(gcf,'images/arn_sp7_center_vel.png')
%% TKE Plots
gray=1/255*[200,200,200];

x_min_4=x_1c_4;
x_max_4=x_1c_4;
x_min_8=x_1c_8;
x_max_8=x_1c_8;
x_min_12=x_1c_12;
x_max_12=x_1c_12;
x_min_16=x_1c_16;
x_max_16=x_1c_16;

for i=1:size(x_min_4,1)
    x_min_4(i,9) = min([x_1c_4(i,9),x_2c_4(i,9),x_3c_4(i,9),...
        x_p1c1_4(i,9),x_p1c2_4(i,9),x_base_4(i,9)]);
    x_max_4(i,9) = max([x_1c_4(i,9),x_2c_4(i,9),x_3c_4(i,9),...
        x_p1c1_4(i,9),x_p1c2_4(i,9),x_base_4(i,9)]);
end

figure(6)
betweenX= [x_min_4(:,9)/Ujet^2;flipud(x_max_4(:,9))/Ujet^2];
betweenY= [x_min_4(:,2);flipud(x_max_4(:,2))];
fill(betweenX+1/20,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA);
hold on
plot(x_base_4(:,9)/Ujet^2+1/20,x_base_4(:,2),'k');
errorbar(sum(x_4(1:3:end,7:9),2)/2+1/20,x_4(1:3:end,2),0.5*sum(err_4(1:3:end,7:9).^2,2).^.5,'horizontal','k.','LineWidth',lw,'MarkerSize',msz);
xlabel('$\frac{k}{U_{jet}^2}+\frac{x}{80D_{jet}}$','FontSize',afz);
ylabel('$\frac{y}{D_{jet}}$','FontSize',afz);
% legend('Uncertainty estimates','Baseline','PIV','Location','southwest')

for i=1:size(x_min_8,1)
    x_min_8(i,9) = min([x_1c_8(i,9),x_2c_8(i,9),x_3c_8(i,9),...
        x_p1c1_8(i,9),x_p1c2_8(i,9),x_base_8(i,9)]);
    x_max_8(i,9) = max([x_1c_8(i,9),x_2c_8(i,9),x_3c_8(i,9),...
        x_p1c1_8(i,9),x_p1c2_8(i,9),x_base_8(i,9)]);
end

betweenX= [x_min_8(:,9)/Ujet^2;flipud(x_max_8(:,9))/Ujet^2];
betweenY= [x_min_8(:,2);flipud(x_max_8(:,2))];
fill(betweenX+2/20,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(x_base_8(:,9)/Ujet^2+2/20,x_base_8(:,2),'k','HandleVisibility','off');
errorbar(sum(x_8(1:3:end,7:9),2)/2+2/20,x_8(1:3:end,2),0.5*sum(err_8(1:3:end,7:9).^2,2).^.5,'horizontal','k.','LineWidth',lw,'MarkerSize',msz,'HandleVisibility','off');


for i=1:size(x_min_12,1)
    x_min_12(i,9) = min([x_1c_12(i,9),x_2c_12(i,9),x_3c_12(i,9),...
        x_p1c1_12(i,9),x_p1c2_12(i,9),x_base_12(i,9)]);
    x_max_12(i,9) = max([x_1c_12(i,9),x_2c_12(i,9),x_3c_12(i,9),...
        x_p1c1_12(i,9),x_p1c2_12(i,9),x_base_12(i,9)]);
end

betweenX= [x_min_12(:,9)/Ujet^2;flipud(x_max_12(:,9))/Ujet^2];
betweenY= [x_min_12(:,2);flipud(x_max_12(:,2))];
fill(betweenX+3/20,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(x_base_12(:,9)/Ujet^2+3/20,x_base_12(:,2),'k','HandleVisibility','off');
errorbar(sum(x_12(1:3:end,7:9),2)/2+3/20,x_12(1:3:end,2),0.5*sum(err_12(1:3:end,7:9).^2,2).^.5,'horizontal','k.','LineWidth',lw,'MarkerSize',msz,'HandleVisibility','off');

for i=1:size(x_min_16,1)
    x_min_16(i,9) = min([x_1c_16(i,9),x_2c_16(i,9),x_3c_16(i,9),...
        x_p1c1_16(i,9),x_p1c2_16(i,9),x_base_16(i,9)]);
    x_max_16(i,9) = max([x_1c_16(i,9),x_2c_16(i,9),x_3c_16(i,9),...
        x_p1c1_16(i,9),x_p1c2_16(i,9),x_base_16(i,9)]);
end

betweenX= [x_min_16(:,9)/Ujet^2;flipud(x_max_16(:,9))/Ujet^2];
betweenY= [x_min_16(:,2);flipud(x_max_16(:,2))];
fill(betweenX+4/20,betweenY,'k','FaceAlpha',FA,'EdgeAlpha',EA,'HandleVisibility','off');
hold on
plot(x_base_16(:,9)/Ujet^2+4/20,x_base_16(:,2),'k','HandleVisibility','off');
errorbar(sum(x_16(1:3:end,7:9),2)/2+4/20,x_16(1:3:end,2),0.5*sum(err_16(1:3:end,7:9).^2,2).^.5,'horizontal','k.','LineWidth',lw,'MarkerSize',msz,'HandleVisibility','off');
axis([0.04,0.22,0,1.3])
saveas(gcf,'images/arn_sp7_k_prof.png')