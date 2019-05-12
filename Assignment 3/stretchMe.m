function O = stretchMe(img, dim)
    if dim == 1
        [m,n] = size(img);

        O = zeros(2*m, 2*n);

        for i = 1:m
            for j = 1:n
                O((2*i)-1:(2*i),(2*j)-1:(2*j)) = img(i,j);
            end
        end
        
    else
        [m,n,l] = size(img);

        O = zeros(2*m, 2*n, 3);

        for i = 1:m
            for j = 1:n
                O((2*i)-1:(2*i),(2*j)-1:(2*j),1) = img(i,j,1);
                O((2*i)-1:(2*i),(2*j)-1:(2*j),2) = img(i,j,2);
                O((2*i)-1:(2*i),(2*j)-1:(2*j),3) = img(i,j,3);
            end
        end
        O = uint8(O);
    end
end