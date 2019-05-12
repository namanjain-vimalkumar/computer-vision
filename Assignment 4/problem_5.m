
load('Data/linefit.mat');

% Problem a) Find the best fit for xs, n_y1
Line1 = bestFitLS(xs, n_y1)
subplot(2,2,1)
scatter(xs, n_y1); hold on;
plot(xs, -((Line1(1)*xs)+Line1(3))/Line1(2));
title("Line 1 for xs, n _y1");
disp("-----------------------------------");

% Problem b) Find the best fit for xs, n_y2
Line2 = bestFitLS(xs, n_y2)
subplot(2,2,2)
scatter(xs, n_y2); hold on;
plot(xs, -((Line2(1)*xs)+Line2(3))/Line2(2));
title("Line 2 for xs, n _y2");
disp("-----------------------------------");

% Problem c) Find the best fit for xs, n_y2 for like RANSAC
Line3 = bestFitCustom(xs, n_y2, 0.05)
subplot(2,2,3)
scatter(xs, n_y2); hold on;
plot(xs, -((Line3(1)*xs)+Line3(3))/Line3(2));
title("Line 3 for xs, n _y2 using custom algorithm. Alpha = 0.05");
disp("-----------------------------------");

% Problem c) Find the best fit for xs, n_y2 for like RANSAC
Line4 = bestFitCustom(xs, n_y2, 0.1)
subplot(2,2,4)
scatter(xs, n_y2); hold on;
plot(xs, -((Line4(1)*xs)+Line4(3))/Line4(2));
title("Line 3 for xs, n _y2 using custom algorithm. Alpha = 0.1");
disp("-----------------------------------");

clear

function Line = bestFitLS(x, y)
    pts = transpose([x; y; ones(1, size(x, 2))]);
    [U,D,V] = svd(pts);
    Line = transpose(V(:,2));
end

function Line = bestFitCustom(x, y, Learning_Rate)
    
    n = max(size(x));
    outliers = [];
    n_inliers = 1;
    n_dash = 0;
    Line = bestFitLS(x,y);
    
    Points = [x; y; ones(1,n)];
    weight = 0;
    while(n_dash/n_inliers ~= 1)  
        
        distanceMatrix = abs(Line*Points/norm(Line(1:2)));
        distanceMean = mean(distanceMatrix);
        distanceStdDeviation = std(distanceMatrix);
        gardients = Learning_Rate*distanceStdDeviation;
        weight = weight + gardients;
        distanceInliers = distanceMean + weight;
        
        n_dash = n_inliers;
        XInliers = x(distanceMatrix < distanceInliers);
        YInliers = y(distanceMatrix < distanceInliers);
        n_inliers = max(size(XInliers));
        
        Line = bestFitLS(XInliers, YInliers);
        outliers = [x(distanceMatrix > distanceInliers); y(distanceMatrix > distanceInliers);];
    end
    disp("Outliers: ");
    disp(transpose(outliers));
end