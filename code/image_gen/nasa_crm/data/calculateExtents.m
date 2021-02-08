function [xPoints, yPoints] = calculateExtents(minCD, maxCD, minCL, maxCL)

anchor = [.1;.2];

minmin = [minCD,minCL];
minmax = [minCD,maxCL];
maxmin = [maxCD,minCL];
maxmax = [maxCD,maxCL];

% dist(minmin,anchor)

distances = [dist(minmin,anchor), dist(minmax,anchor), dist(maxmin,anchor), dist(maxmax,anchor)];
[~,minLocs] = min(distances,[],2);
[~,maxLocs] = max(distances,[],2);

allData = cat(3,minmin,minmax);
allData = cat(3,allData,maxmin);
allData = cat(3,allData,maxmax);

for i =1:length(minLocs)
    xPointsMin(i) = allData(i,1,minLocs(i));
    yPointsMin(i) = allData(i,2,minLocs(i));
    xPointsMax(i) = allData(i,1,maxLocs(i));
    yPointsMax(i) = allData(i,2,maxLocs(i));
end

xPoints = [xPointsMin fliplr(xPointsMax)]';
yPoints = [yPointsMin fliplr(yPointsMax)]';
end