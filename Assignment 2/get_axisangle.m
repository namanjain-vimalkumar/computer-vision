function [A, theta] = get_axisangle(R)
    
    % Find axis
    a = [];
    for i = 1:1:3
        if R(i,i) == 1
            flag = 1;
            for j = 1:1:3
                if i ~= j
                    if R(i,j) ~= 0 && R(j,i) ~= 0
                        flag = 0;
                    end
                end
            end
            if flag == 1
                a = i;
                break;
            end
        end
    end
    
    A = zeros(1,3);
    A(a) = 1;
    
    switch a
        case 1
            theta = atan(R(3,2)/R(2,2))*180/pi;
        case 2
            theta = atan(R(3,1)/R(1,1))*180/pi;
        case 3
            theta = atan(R(2,1)/R(1,1))*180/pi;
        otherwise
            theta = [];
    end
    
    