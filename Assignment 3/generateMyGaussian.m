function O = generateMyGaussian(BW, type)

    % Find its smooth image
    filter = ones(3,3) / 9;
    if type == 1
        smooth_image = imfilter(BW, filter, 'conv');
        [m, n] = size(smooth_image);
    else
        smooth_image_R = imfilter(BW(:,:,1), filter, 'conv');
        smooth_image_G = imfilter(BW(:,:,2), filter, 'conv');
        smooth_image_B = imfilter(BW(:,:,3), filter, 'conv');
        [m, n] = size(smooth_image_R);
    end
    
    
    % Downsample the same  - Mean Pooling
    m = floor(m/2);
    n = floor(n/2);
    
    if type == 1
        O = zeros(m,n);
        for i = 1:m
            for j = 1:n
                O(i,j,1) = mean(smooth_image((2*i)-1:(2*i),(2*j)-1:(2*j)), 'all');
            end
        end
    else
        O = zeros(m,n,3);
        for i = 1:m
            for j = 1:n
                O(i,j,1) = mean(smooth_image_R((2*i)-1:(2*i),(2*j)-1:(2*j)), 'all');
                O(i,j,2) = mean(smooth_image_G((2*i)-1:(2*i),(2*j)-1:(2*j)), 'all');
                O(i,j,3) = mean(smooth_image_B((2*i)-1:(2*i),(2*j)-1:(2*j)), 'all');
            end
        end
        O = uint8(O);
    end
    
    
end