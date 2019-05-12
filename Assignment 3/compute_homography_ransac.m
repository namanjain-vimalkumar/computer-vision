function H = compute_homography_ransac(mpts1, mpts2, THRESH, img1, img2)
    H = [0,0];
% 1. while (Stop during a stopping condition - Say inliers = 0.7*n)
% 2.    Select 2 random points
% 3.    Find their line equation
%       New inliers = 0
% 4.    For each point, perform:
% 5.       d = abs(line.dot(point)/)
% 6.       Check if d is below threshold
% 7.          Increase counter for inliers and them to new inliers
% 8.    Compare size of new Inliers and old Inliers, if greater
% 9.       Old Inliers = new inliers.
    inliers = [];
    n = size(mpts1, 1);
    diff_m = [mpts1 - mpts2, ones(n,1)];
    m1 = [];
    m2 = [];
    
    margin = 10;
    mpts1 = [mpts1, ones(n, 1)];
    mpts2 = [mpts2, ones(n, 1)];
    % Finding inliers: Need to change the stopping creteria
    while(size(inliers,1) <= 0.35*n) 
        point_a = diff_m(randi(n-1),:);
        point_b = diff_m(randi(n-1),:);
        
        line = cross(point_a, point_b);
        deno = sqrt(sum(line(1:2) .^ 2));
        
        D = transpose(abs(line*transpose(diff_m))./deno);
        new_inliers = find(D <= margin);
        
        % Select 4 unique values and compute homography
        n_inliers = size(new_inliers, 1);
        if n_inliers >= 4
            unique_inliers_index = new_inliers(randperm(n_inliers, 4));
            s_mpts1 = [mpts1(unique_inliers_index,:), ones(4,1)];
            s_mpts2 = [mpts2(unique_inliers_index,:), ones(4,1)];
            H = compute_homography(s_mpts1, s_mpts2);

            A = mpts2 - convertToHomogenous(transpose(H*transpose(mpts1)));
            B = mpts1 - convertToHomogenous(transpose(inv(H)*transpose(mpts2)));
            d = findNorm(A) + findNorm(B);
            if THRESH == 0
                standard_deviation = std(d);
                THRESH = 2.5 * standard_deviation;
            end

            new_inliers = find(d <= THRESH);
            size(new_inliers)
            if(size(new_inliers, 1) >= size(inliers, 1))
                m1 = point_a;
                m2 = point_b;
                inliers = new_inliers; 
            end
        end
    end
    
    H = compute_homography(mpts1(inliers,:), mpts2(inliers,:));
    
%     I1 = imread(img1);
%     I2 = imread(img2);
%     m1 = mpts1(inliers,:);
%     m2 = mpts2(inliers,:);
%     imshow([I1, I2]); hold on;
%     [m,n,l] = size(I1);
%     for i = 1:size(m1, 1)
%         plot([m1(i,1), n+m2(i,1)], [m1(i,2), m2(i,2)]);
%     end
end