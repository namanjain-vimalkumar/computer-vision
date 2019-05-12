function X = MySolve(n)
    switch n
        case 1
            P = [-1,-1,2; -1,-1,3; 0,-1,2;0,-1,3;1,-1,2;1,-1,3];
            P = transpose(P)
            X = [project_point(P(:,1)), project_point(P(:,2)), project_point(P(:,3)), project_point(P(:,4)), project_point(P(:,5)), project_point(P(:,6))];
            
        case 2
            L1 = transpose([-1, -1, 2; -1, -1, 3]);
            L2 = transpose([0, -1, 2; 0, -1, 3]);
            X = find_intersection(L1(:,1), L1(:,2), L2(:,1), L2(:,2), 1);
            
        case 3
            L1 = transpose([-1, -1, 2; -1, -1, 3]);
            L2 = transpose([0, -1, 2; 0, -1, 3]);
            L3 = transpose([1, -1, 2; 1, -1, 3]);
%             X = find_intersection(L1(:,1), L1(:,2), L2(:,1), L2(:,2), 1);
%             X = find_intersection(L2(:,1), L2(:,2), L3(:,1), L3(:,2), 1);
            X = find_intersection(L3(:,1), L3(:,2), L1(:,1), L1(:,2), 1);
            
        case 4
            P1_L1 = [1; 0; 0; -1];
            P1_L2 = [1; 0; 0; 0];
            P2_L1 = [3; 0; 2; -1];
            P2_L2 = [3; 0; 2; -2];
            P3_L1 = [5; 0; -2; -1];
            P3_L2 = [5; 0; -2; -2];
            
            X = pairwise_intersection(P1_L1, P1_L2, P2_L1, P2_L2, P3_L1, P3_L2);
    end
