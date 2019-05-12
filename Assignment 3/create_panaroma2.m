function panaroma = create_panaroma2(img_left, img_right, use_sift, use_ransac, pts1, pts2)

    THRESH_HOMOGRAPHY = 2000;
    THRESH_CORNERS = 5;
    WINDOW_SIZE = 5;
%     pts1 = extract_corners(img_left, THRESH_CORNERS);
%     pts2 = extract_corners(img_right, THRESH_CORNERS);
    
    [mpts1, mpts2] = match_corners(img_left, img_right, pts1, pts2, WINDOW_SIZE);
    
    if use_ransac == 1
        H = compute_homography_ransac(mpts1, mpts2, THRESH_HOMOGRAPHY);
        
        img_left = imread(img_left);
        [l_m,l_n,l] = size(img_left);
        
        img_right = imread(img_right);
        [r_m, r_n, l] = size(img_right);
        
        
        img_1 = zeros(l_m + r_m, l_n + r_n, 3);
        img_2 = zeros(l_m + r_m, l_n + r_n, 3);
        
%         for i = 1:l_m
%             for j = 1:l_n
%                 img_1(i,j,:) = img_left(i,j,:);
%             end
%         end
        disp("4");
        
        img_1(1:l_m, 1:l_n, :) = img_left(:,:,:);
        
        disp("5");
        for i = 1:r_m
            for j = 1:r_n
                [i,j,1];
                H_points = convertToHomogenous(transpose(inv(H)*[i;j;1]));
                H_p = round(H_points, 0)
                img_2(H_p(1),H_p(2),:) = img_right(i,j,:);
            end
        end
        
%         mpts2 = [mpts2, ones(size(mpts2,1),1)];
%         z = inv(H)*transpose(mpts2);
%         z = [mpts1, convertToHomogenous(transpose(z))]
%         disp("6");
%         size(img_1)
%         subplot(1,2,1)
%         imshow(uint8(img_1));
%         
%         subplot(1,2,2)
%         imshow(img_2);
%         
        
        
    end
    panaroma = 1;
end