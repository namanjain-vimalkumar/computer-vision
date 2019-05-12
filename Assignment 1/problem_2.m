function X = problem_2(type)

    I = imread('board.tif');

    Image = I(90:180, 200:300, :);
    switch type
        case 1
            [m,n,o] = size(I);
            sum_ = 0;
            I_G = zeros(m,n);
            for r = 1:m
                for c = 1:n
                    I_G(r,c) = double((I(r,c,1) + I(r,c,2) + I(r,c,3))/3);
                    sum_ = sum_ + I_G(r,c,1);
                end
            end
            
            G_B = zeros(m,n);
            M = sum_/(m*n);
            for r = 1:m
                for c = 1:n
                    G_B(r,c) = (I_G(r,c,1) >= M);
                end
            end
            
            res = zeros(m+6,n+6);
            avg_m = double(ones(7,7)/49);
            
            a = [zeros(3,n+3); zeros(m,3), I_G];
            
            w = double(ones(7,7)/49);
            [m,n] = size(I_G);
            res = zeros(m+7-1, n+7-1);
            [x,y] = size(res);
            
            for r = 1:x
                for c = 1:y
                    % Select l, r, t, b
                    sum_ = 0;
                    % Here see number of steps
                    for i = r-3:r+3
                        if i > 0 && i <= m
                            for j = c-3:c+3
                                if j > 0 && j <= n
                                    sum_ = sum_ + (I_G(i,j)*w(r-i+4,c-j+4)); 
                                end
                            end
                        end
                    end  
                    res(r,c) = sum_;
                end
            end
            
            
        case 2
            I_G = double((I(:,:,1) + I(:,:,2) + I(:,:,3))/3);
            M = mean(I_G, 'all');
            G_B = (I_G >= M);
            
            res = conv2(double(I_G), double(ones(7,7)/49));
            
        case 3
            I_G = rgb2gray(I);
            M = mean(I_G, 'all')/255;
            G_B = im2bw(I_G, M);
            imshow(G_B)
            
            res = conv2(double(I_G), double(ones(7,7)/49));
           
        otherwise
            X = "Wrong Type!";
    end
    
    imshow(Image), title("Crystal"); 
    figure;
    
    subplot(1,4,1), imshow(I), title("Actual Image");
    subplot(1,4,2), imshow(uint8(I_G)), title("Grayscale Image");
    subplot(1,4,3), imshow(G_B), title("Binary Image");
    subplot(1,4,4), imshow(uint8(res)), title("Smooth Image");