function [P, err] = computeCameraProjectionMatrix(X, x)
    % It computes a 4x3 matrix which consists of intrinsic and extrensic
    % properties of the camera. Intrensic being the camera calibration
    % matrix and the location of the camera. This is given by the equation
    % x = PX where 'x' points are homogenous image points (wx, wy, w) and
    % 'X' are the inhomogenous world points (X, Y, Z);
    
    % Note: We need atleast 6 points as it generates a 4x3 matrix
    % Ref: http://www.cim.mcgill.ca/~langer/558/19-cameracalibration.pdf
    
    % Type of Errors: 
    %   1 - Row size of X and x do not match
    %   2 - Image Points not in correct format 
    %   3 - World Points not in correct format  
    %   4 - Minimum 6 points not given    
    
    
    P = [];
    if size(x,1) ~= size(X, 1)
        err = 1;
        return
    end
    if size(x,2) ~= 3
        err = 2;
        return;
    end
    if size(X,2) ~= 3
        err = 3;
        return;
    end
    if size(x,1) > 5 && size(X,1) > 5
        
        % 1. Convert matrix 'X' to homogenous. Since 3D Image, append 1s
        X = [X, ones(size(X,1),1)];
        
        % 2. Convert matrix 'x' to homogenous. Since 2D, divide by z index
        x = x ./ x(:,3);
        
        % 3. Compute matrix A, whose SVD would generate a 'P' valued vector
        %   A = [X, Y, Z, 1, 0, 0, 0, 0, -x1.X, -x1.Y, -x1.Z, -x1;
        %        0, 0, 0, 0, X, Y, Z, 1, -y1.X, -y1.Y, -y1.Z, -y1]
        %   for all points in x
        A = [];
        for i = 1:size(x, 1)
            Ai = [X(i,:), 0, 0, 0, 0, X(i,:) .* -x(i,1);
                    0, 0, 0, 0, X(i,:), X(i,:) .* -x(i,2)];
            A = [A; Ai];
        end
        [U,D,V] = svd(A);
        err = 0;
        P = transpose(reshape(V(:,12), 4, 3));
    else
        err = 4;
    end
end