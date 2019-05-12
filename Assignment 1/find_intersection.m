
function P = find_intersection(P11, P12, P21, P22, flag)
    % r = (1 - C1)P11 + (C1)P12 = (1 - C2)P21 + (C2)P22
    %   = P11 + C1(P12 - P11)   = P21 + C2(P22 - P21)
    %   => C1(P12 - P11) - C2(P22 - P21) + (P11 - P21)
    % is as X(C1) + Y(C2) + C = 0
    
    % L1, L2 - Actual Lines.
    % Q - Actual Point of intersection.
    % L3, L4 - Projected Lines.
    % P - Projected Point.
    
    X = P11 - P12;
    Y = P22 - P21;
    Z = P11 - P21;
    
    Q = linsolve([X,Y],Z);
    lambda = Q(1);
    phi = Q(2);
    
    P = round(P11 + lambda*(P12 - P11),2);
    
    Q = round(P21 + phi*(P22 - P21),2);
    
    if P == Q
        msg = "Lines do intersect";
    else
        msg = "Lines intersect at infinity";
        P = [1/0; 1/0; 1/0];
    end
    
    if flag == 1
        disp(msg);
    end
    
    % Actual Lines
    L1 = [P11, P12, P];
    L2 = [P21, P22, P];
    
    % Projected Point of intersection
    P = project_point(P);
    
    if flag == 1
        
        % Projected Points
        P11 = project_point(P11);
        P12 = project_point(P12);
        P21 = project_point(P21);
        P22 = project_point(P22);
        
        % Projected Lines
        L3 = [P11, P12, P];
        L4 = [P21, P22, P];
         
        plot3(L1(1,:), L1(2,:), L1(3,:), '-o', L2(1,:), L2(2,:), L2(3,:), '-o', L3(1,:), L3(2,:), L3(3,:), '-o', L4(1,:), L4(2,:), L4(3,:), '-o');
        legend({'L1', 'L2', 'L1 on Image Plane', 'L2 on Image Plane'}, 'Location', 'southwest');
    end
    
    