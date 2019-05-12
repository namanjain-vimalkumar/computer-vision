function [K, R, T] = findCameraParameters(P)
    % It finds the internal and external parameter of the projection matrix
    % 'P'. The internal parameters is the camera calibration matrix 'K' of
    % size 3x3 and external parameters(E) is the R[I| - C] of size 4x3, where
    % R is the Rotational matrix and C is the camera position. It uses RQ
    % Decomposition method to generate K and E matrix.
    
    % Ref: http://www.cim.mcgill.ca/~langer/558/19-cameracalibration.pdf
    
    % Type of Errors: 
    %   1 - Size of the projection matrix is not 4x3
    
    if size(P) ~= [3,4]
        err = 1;
        return;
    end
    
    err = 0;
    
    % 1. Normalize 'P' matrix by dividing with norm of [P31, P32, P33]
    P_dash = P(1:3, 1:3);
    
    % 2. Find Rotational angles with respect to each axis
    %       Let 'theta' be rotational angle with respect to X-axis,
    %       Let 'beta' be rotational angle with respect to Y-axis,
    %       Let 'gamma' be rotational angle with respect to Z-axis
    theta = atan(P(3,1)/P(3,2));
    R_X = [cos(theta), sin(theta), 0; -sin(theta), cos(theta), 0; 0, 0, 1];
    
    R_dash = P_dash*R_X;
    beta = atan(R_dash(3,2)/R_dash(3,3));
    R_Y = [1, 0, 0; 0, cos(beta), sin(beta); 0, -sin(beta), cos(beta)];
    
    R_dash = R_dash*R_Y;
    gamma = atan(R_dash(2,1)/R_dash(2,2));
    R_Z = [cos(gamma), 0, sin(gamma); 0, 1, 0; -sin(gamma), 0, cos(gamma)];
    
    R_dash = R_dash*R_Z;
    
    % To convert all diagonal elements to positive numbers
    I = (diag(R_dash) ./ abs(diag(R_dash))).*eye(3);
    
    K = R_dash*I;
    R = transpose(R_X*R_Y*R_Z);
    T = transpose(R)*inv(K)*P(:,4);
    
end