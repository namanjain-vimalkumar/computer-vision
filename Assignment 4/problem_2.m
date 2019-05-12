imgL = rgb2gray(imread('Images/viewL.png'));
imgR = rgb2gray(imread('Images/viewR.png'));
load('Data/disparity.mat');

subplot(2,2,1)
imshow(uint8(L));
title("Ground Truth");

methods = ["ssd", "cc", "ncc"];
for i = 1:3
    getCorrs(methods(i), i, double(L));
end

function getCorrs(method, i, truth)
    [m, n] = size(truth);
    startTime = now;
    disp_map = compute_corrs(imgL, imgR, method);
    timeTaken = datestr(now - startTime, "HH:MM:SS.FFF");
    Error = sum(abs(truth-disp_map), 'all');
    MSE = sum((truth-disp_map).^2, 'all')/(m*n);
    disp("Time spent for " + (method) + " is: " + timeTaken + "in HH:MM:SS.FFF");
    disp("Error: " + string(Error));
    disp("Mean Squared Error: " + string(MSE));
    
    subplot(2, 2, i+1);
    imshow(uint8(disp_map));
    title("Depth Map using " + (method))
end





