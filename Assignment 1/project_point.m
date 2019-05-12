function Q = project_point(P)
    % Using r = (1 - lambda)O + lambda(P)
    % O - Origin, Q - Respective Point on Image Plane, P - Given Point
    O = [0; 0; 0];
    lambda = 1/P(3);     % As Image Plane is z = 1 (Known Value)
    Q = (1-lambda)*O + lambda*P;
    