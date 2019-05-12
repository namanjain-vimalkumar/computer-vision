function [rectL, rectR] = rectify_images(imgL, imgR, Pl, Pr)
    imgL = rgb2gray(imread(imgL));
    imgR = rgb2gray(imread(imgR));
    [Kl, Rl, tl] = findCameraParameters(Pl);
    [Kr, Rr, tr] = findCameraParameters(Pr);
  
    
    e1 = (tl-tr)/2;             % baseline
    e2 = cross(Rl(3,:)',e1);    % baseline orthogal to y
    e3 = cross(e1,e2);          % orthogonal to x and y

    R = [e1'/norm(e1)           % New rotational matrix
         e2'/norm(e2)
         e3'/norm(e3)];
      
    Hl = Kr*R*inv(Kl); 
    Hr = Kl*(R)*inv(Kr);
    
    [m,n] = size(imgL);
    rectL = zeros(2*m,2*n);
    rectR = zeros(2*m,2*n);
    for i = 1:m
        for j = 1:n
            p = transpose([i,j,1]);
            p_dash = abs(Hl*p);
            p_dash = round(p_dash ./ p_dash(3));
            p_dash = p_dash + 1;
            rectL(p_dash(1), p_dash(2)) = imgL(i,j);
            
            p = transpose([i,j,1]);
            p_dash = abs(Hr*p);
            p_dash = ceil(p_dash ./ p_dash(3));
            p_dash = p_dash + 1;
            rectR(p_dash(1), p_dash(2)) = imgR(i,j);
        end
    end
end

% https://www.cs.auckland.ac.nz/~rklette/CCV-CIMAT/pdfs/B14-CameraCalibration.pdf
% http://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/FUSIELLO2/node5.html
% http://www.sci.utah.edu/~gerig/CS6320-S2012/Materials/CS6320-CV-F2012-Rectification.pdf