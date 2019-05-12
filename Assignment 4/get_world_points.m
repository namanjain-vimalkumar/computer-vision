function P_hat = get_world_points(pl, pr)
    
    F = findFundamentalMatrix(pl, pr);
    Pl = [eye(3), zeros(3,1)];
    [U,D,V] = svd(transpose(F));
    e2 = V(:,3);
    Cr = e2;
    Pr = [-findS(e2)*F, e2];
    
    Pl_pseudo = Pl'*inv(Pl*Pl');
    Pr_pseudo = Pr'*inv(Pr*Pr');
    
    temp = transpose(Pl_pseudo*transpose(pl) - Pr_pseudo*transpose(pr));
    lamdba = temp/[transpose(Cr), 1];
    
    P_hat = transpose(Pr_pseudo*transpose(pr)) + lamdba.*repmat(transpose([Cr; 1]), size(lamdba));
    
    P_hat = P_hat ./ P_hat(:,4);
    P_hat = P_hat(:,1:3);
end

% Ref http://www.maths.lth.se/media11/FMAN85/2018/forelas5.pdf

% Find F in transpose(x2)*F*(x1) = 0
% Here both x1 and x2 are homogenous points (x,y,z)
function F = findFundamentalMatrix(x1, x2)
    m = size(x1, 1);
    M = [];
    for i = 1:m
        A = x2(i,1) .* x1(i,:);
        B = x2(i,2) .* x1(i,:);
        C = x2(i,3) .* x1(i,:);
        M = [M; A, B, C];
    end
    [U,S,V] = svd(M);
    F = transpose(reshape(V(:, 9), 3,3));
end

function Y = findS(v)
    Y = [0, v(3), -v(2); -v(3), 0, v(1); v(2), -v(1), 0];
end