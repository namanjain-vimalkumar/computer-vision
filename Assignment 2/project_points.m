function P_C = project_points(P_W, R, t)

    % Given
    p = [50, 50, 0];                % Image Center
    M = diag([200, 200, 1, 1],0);   % Scaling 
    skew = 0;                       % Skew
    
    f = norm(p-t);
    
    K = [f, skew, p(1), 0; 0, f, p(2), 0; 0, 0, 1, 0]*M;
    R = [R, zeros(3,1); zeros(1,3), 1];
    T = [eye(3), -t; zeros(1,3), 1];
    
    P_W = [P_W, ones(10,1)];
    
    X = K*R*T*(P_W.');
    P_C = X(1:2,:).';
    
end