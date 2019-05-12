function [K, R, t] = findCameraParametersUsingRQ(P)
    Q = inv(P(1:3, 1:3));
    [R,Q] = qr(Q);

    R = inv(R);
    t = Q*P(1:3,4);
    K = inv(Q);
    K = K ./K(3,3);
end