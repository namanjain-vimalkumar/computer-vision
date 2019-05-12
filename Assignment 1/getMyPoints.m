function P = getMyPoints(L)
    P = [];
    for i = 0:1
        x_c = randi(10) + (i * 15);
        z_c = randi(10) - (i * 15);
        y_c = (0 - x_c*L(1) - z_c*L(3) - L(4))/L(2);
        X = [x_c, y_c, z_c, 1];
        if X*L == 0
            P = [P; x_c, y_c, z_c];
        end
    end
    
    if size(P,1) < 2
        for i = 0:1
            y_c = randi(10) + (i * 15);
            z_c = randi(10) - (i * 15);
            x_c = (0 - y_c*L(2) - z_c*L(3) - L(4))/L(1);
            X = [x_c, y_c, z_c, 1];
            if X*L == 0
                P = [P; x_c, y_c, z_c];
            end
        end
    end
    
    if size(P,1) < 2
        for i = 0:1
            x_c = randi(10) + (i * 15);
            y_c = randi(10) - (i * 15);
            x_c = (0 - x_c*L(1) - y_c*L(2) - L(4))/L(3);
            X = [x_c, y_c, z_c, 1];
            if X*L == 0
                P = [P; x_c, y_c, z_c];
            end
        end
    end
    