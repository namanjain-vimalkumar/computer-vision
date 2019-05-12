function [pts] = extract_corners(img, THRESH)
    I = imread(img);
    BW = rgb2gray(I);
    [m,n] = size(BW);
    
    % 1. Compute x and y derivatives of an image
    [I_x, I_y] = imgradientxy(BW, 'sobel');
    
    % 2. Computer product of derivatives at each pixel
    I_x2 = I_x .* I_x;
    I_y2 = I_y .* I_y;
    I_xy = I_x .* I_y;
    
    % For each pixel
    H = zeros(m,n);
    for u = 3:m-3
        for v = 3:n-3
            
            % 3. Compute the sums of the products of derivatives at each pixel
            I_x2_mean = I_x2(u-2:u+2,v-2:v+2);
            S_x2 = mean(I_x2_mean, 'all');
            
            I_y2_mean = I_y2(u-2:u+2,v-2:v+2);
            S_y2 = mean(I_y2_mean, 'all');
            
            I_xy_mean = I_xy(u-2:u+2,v-2:v+2);
            S_xy = mean(I_xy_mean, 'all');
            
            % 4. Define at each pixel (x,y) the Matrix
            M = [S_x2, S_xy; S_xy, S_y2];
            
            % 5. Compute the response of the detector at each pixel
            H(u,v) = det(M) - (0.04 * (trace(M) ^ 2));
        end
    end
    
    % 6. Threshold on value of R or 'THRESH' points
    [R,C] = ndgrid(1:m,1:n);
    [temp,index] = sort(H(:),'descend');
    pt = [R(index),C(index)];
    pt = pt(1:THRESH, :);
    pts = [pt(:,2), pt(:,1)];
    
%     % Plotting with In-built Harris Detector
%     pts2 = corner(BW,'Harris',THRESH);
%     subplot(1,2,1);
%     imshow(I); hold on;
%     title('From built-in function');
%     scatter(pts2(:,1), pts2(:,2));
%     
%     % Plotting with Default Edge Detector
%     subplot(1,2,2);
%     imshow(I); hold on;
%     title('From Defualt function');
%     scatter(pts(:,1), pts(:,2));
    
end