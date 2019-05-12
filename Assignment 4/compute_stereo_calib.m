function [Kl, Tl, Kr, Tr] = compute_stereo_calib(P, pl, pr) 
    
    [Pl, err] = computeCameraProjectionMatrix(P, pl);
    if err ~= 0
        disp('Left Camera Projection Matrix failed: '+string(err));
        return;
    end
    Pl
    
    [Kl, Rl, tl] = findCameraParameters(Pl);
    Kl(1,2) = 0;
    Tl = Rl*[-eye(3), tl];
    
    [Pr, err] = computeCameraProjectionMatrix(P, pr);
    if err ~= 0
        disp('Right Camera Projection Matrix failed: '+string(err));
        return;
    end
    Pr
    
    [Kr, Rr, tr] = findCameraParameters(Pr);
    Kr(1,2) = 0;
    Tr = Rr*[-eye(3), tr];
end