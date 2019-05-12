function H = compute_homography(mpts1, mpts2)
    % Steps:
    % mpts2 = H * mpts1
    %
    % 1. For each matching point, find x2_dash and y2_dash [mpts2_dash]
    %                             also construct A_i matrix (2*9) s.t
    %   A_i = [?x1, ?y1, ?1, 0, 0, 0, x2_dash*x1, x2_dash*x2, x2_dash;
    %           0,0,0, -x1, -y1, -1, y2_dash*x1, y2_dash*x2, y2_dash;]
    %                             Append this to A
    
    % 2. Obtain SVD of the matrix A with D is +ve diagonal matrix in
    %    descending order, then H is the last column of V
    %           A = UD(V.T)
    n = size(mpts1, 1);
   
    A = [];
    if n >= 4
        for i = 1:n
            
            z1 = mpts1(i,3);
            x1 = mpts1(i,1)/z1;
            y1 = mpts1(i,2)/z1;
            
            x2 = mpts2(i,1);
            y2 = mpts2(i,2);
            z2 = mpts2(i,3);
            
            x2_dash = (x2)/z2;
            y2_dash = (y2)/z2;
            
            Ai = [-x1, -y1, -1, 0, 0, 0, x2_dash*x1, x2_dash*y1, x2_dash;
                0, 0, 0, -x1, -y1, -1, y2_dash*x1, y2_dash*y1, y2_dash;];
            
            A = [A; Ai];
        end
        
        [U,D,V] = svd(A);
        h = V(:,9) ./ V(9,9);
        H = transpose(reshape(h,3,3));
    else
        disp("Error: Minimum 4 points to find homography matrix. Aborted");
    end
end