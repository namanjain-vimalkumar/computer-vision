function output = pairwise_intersection(P1_L1, P1_L2, P2_L1, P2_L2, P3_L1, P3_L2)

    P1_L1_P = transpose(getMyPoints(P1_L1));
    P1_L2_P = transpose(getMyPoints(P1_L2));
    P1_X = round(find_intersection(P1_L1_P(:,1),P1_L1_P(:,2),P1_L2_P(:,1),P1_L2_P(:,2),0),2)
    
    P1_L1_Pr = [project_point(P1_L1_P(:,1)), project_point(P1_L1_P(:,2)), P1_X];
    P1_L2_Pr = [project_point(P1_L2_P(:,1)), project_point(P1_L2_P(:,2)), P1_X];
    
    P2_L1_P = transpose(getMyPoints(P2_L1));
    P2_L2_P = transpose(getMyPoints(P2_L2));
    P2_X = round(find_intersection(P2_L1_P(:,1),P2_L1_P(:,2),P2_L2_P(:,1),P2_L2_P(:,2),0),2)
    
    P2_L1_Pr = [project_point(P2_L1_P(:,1)), project_point(P2_L1_P(:,2)), P2_X];
    P2_L2_Pr = [project_point(P2_L2_P(:,1)), project_point(P2_L2_P(:,2)), P2_X];
    
    
    
    P3_L1_P = transpose(getMyPoints(P3_L1));
    P3_L2_P = transpose(getMyPoints(P3_L2));
    P3_X = round(find_intersection(P3_L1_P(:,1),P3_L1_P(:,2),P3_L2_P(:,1),P3_L2_P(:,2),0),2)
    
    P3_L1_Pr = [project_point(P3_L1_P(:,1)), project_point(P3_L1_P(:,2)), P3_X];
    P3_L2_Pr = [project_point(P3_L2_P(:,1)), project_point(P3_L2_P(:,2)), P3_X];
    
    
    lambda = (P3_X(3) - P1_X(3))/(P2_X(3) - P1_X(3));
    Z = [0/0; 0/0; 0/0];
    
    temp = round(((1-lambda)*P1_X) + ((lambda)*P2_X),2);
    if isequal(isnan(temp),isnan(Z)) || isequal(temp,P3_X)
        output = "Points are collinear";
    else
        output = "Points are not collinear";
    end 
    
    disp(output);
    
    subplot(2,2,1);
    plot3(P1_L1_P(1,:), P1_L1_P(2,:), P1_L1_P(3,:), "-o", P1_L2_P(1,:), P1_L2_P(2,:), P1_L2_P(3,:), "-o", P1_L1_Pr(1,:), P1_L1_Pr(2,:), P1_L1_Pr(3,:), "-o", P1_L2_Pr(1,:), P1_L2_Pr(2,:), P1_L2_Pr(3,:), "-o");
    legend({'L1', 'L2', 'L1 on Image Plane', 'L2 on Image Plane'}, 'Location', 'southwest');
    
    subplot(2,2,2);
    plot3(P2_L1_P(1,:), P2_L1_P(2,:), P2_L1_P(3,:), "-o", P2_L2_P(1,:), P2_L2_P(2,:), P2_L2_P(3,:), "-o", P2_L1_Pr(1,:), P2_L1_Pr(2,:), P2_L1_Pr(3,:), "-o", P2_L2_Pr(1,:), P2_L2_Pr(2,:), P2_L2_Pr(3,:), "-o");
    legend({'L3', 'L4', 'L3 on Image Plane', 'L4 on Image Plane'}, 'Location', 'southwest'); 
    
    subplot(2,2,3);
    plot3(P3_L1_P(1,:), P3_L1_P(2,:), P3_L1_P(3,:), "-o", P3_L2_P(1,:), P3_L2_P(2,:), P3_L2_P(3,:), "-o", P3_L1_Pr(1,:), P3_L1_Pr(2,:), P3_L1_Pr(3,:), "-o", P3_L2_Pr(1,:), P3_L2_Pr(2,:), P3_L2_Pr(3,:), "-o");
    legend({'L5', 'L6', 'L5 on Image Plane', 'L6 on Image Plane'}, 'Location', 'southwest');
    
    subplot(2,2,4);
    plot3(P1_L1_P(1,:), P1_L1_P(2,:), P1_L1_P(3,:), "-o", P1_L2_P(1,:), P1_L2_P(2,:), P1_L2_P(3,:), "-o", P1_L1_Pr(1,:), P1_L1_Pr(2,:), P1_L1_Pr(3,:), "-o", P1_L2_Pr(1,:), P1_L2_Pr(2,:), P1_L2_Pr(3,:), "-o", P2_L1_P(1,:), P2_L1_P(2,:), P2_L1_P(3,:), "-o", P2_L2_P(1,:), P2_L2_P(2,:), P2_L2_P(3,:), "-o", P2_L1_Pr(1,:), P2_L1_Pr(2,:), P2_L1_Pr(3,:), "-o", P2_L2_Pr(1,:), P2_L2_Pr(2,:), P2_L2_Pr(3,:), "-o", P3_L1_P(1,:), P3_L1_P(2,:), P3_L1_P(3,:), "-o", P3_L2_P(1,:), P3_L2_P(2,:), P3_L2_P(3,:), "-o", P3_L1_Pr(1,:), P3_L1_Pr(2,:), P3_L1_Pr(3,:), "-o", P3_L2_Pr(1,:), P3_L2_Pr(2,:), P3_L2_Pr(3,:), "-o");
    legend({'L1', 'L2', 'L1 on Image Plane', 'L2 on Image Plane', 'L3', 'L4', 'L3 on Image Plane', 'L4 on Image Plane', 'L5', 'L6', 'L5 on Image Plane', 'L6 on Image Plane'}, 'Location', 'southwest');