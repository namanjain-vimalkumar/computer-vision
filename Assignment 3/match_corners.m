function [mpts1, mpts2] = match_corners(img1, img2, pts1, pts2, WSIZE)
%     pts1 = extract_corners(img1, 30);
%     pts2 = extract_corners(img2, 30);
    
    I1 = imread(img1);
    I2 = imread(img2);
    
    BW1 = rgb2gray(I1);
    BW2 = rgb2gray(I2);
    
    w = floor(WSIZE/2);
    
    % Calculating denominators summation 
    df_sum = 0;
    for i = 1:size(pts1,1)
        i_x = pts1(i,1);
        i_y = pts1(i,2);
        f = BW1(i_y, i_x);
        f_dash = mean(BW1(i_y - w : i_y + w, i_x - w : i_x + w), 'all');
        df = double(f - f_dash);
        df_sum = df_sum + (df .^ 2);
    end
    
    dg_sum = 0;
    for i = 1:size(pts2,1)
        i_x = pts2(i,1);
        i_y = pts2(i,2);
        g = BW2(i_y, i_x);
        g_dash = mean(BW2(i_y - w : i_y + w, i_x - w : i_x + w), 'all');
        dg = double(g - g_dash);
        dg_sum = dg_sum + (dg .^ 2);
    end
    
    denominator = sqrt(df_sum * dg_sum);
        
    matches = [];
    for i = 1:size(pts1,1)
        i_x = pts1(i,1);
        i_y = pts1(i,2);
        f = BW1(i_y, i_x);
        f_dash = mean(BW1(i_y - w : i_y + w, i_x - w : i_x + w), 'all');
        df = double(f - f_dash);
        
        for j = 1:size(pts2,1)
            
            j_x = pts2(j,1);
            j_y = pts2(j,2);
            g = BW2(j_y, j_x);
            g_dash = mean(BW2(i_y - w : i_y + w, i_x - w : i_x + w), 'all');
            dg = double(g - g_dash);
            
            ncc = double(df*dg)/denominator;
            if ncc > 0              % As Corelation with positive resembles a match
                matches = [matches; [i_x, i_y, j_x, j_y, ncc]];
            end
        end
    end
    
    matches = sortrows(matches,5, 'descend');
    mpts1 = matches(:,1:2);
    mpts2 = matches(:,3:4);
    
%     imshow([I1, I2]); hold on;
%     [m,n,l] = size(I1);
%     for i = 1:size(mpts1, 1)
%         plot([mpts1(i,1), n+mpts2(i,1)], [mpts1(i,2), mpts2(i,2)]);
%     end
end