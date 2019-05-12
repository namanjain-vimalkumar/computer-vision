function [disparity_map] = compute_corrs(img_left, img_right, method)

    WINDOW_SIZE = 5;
    THRESHOLD = 40;
    
    BW_LEFT = img_left;
    BW_RIGHT = img_right;
    
    % Step 1: 0 Pad images based on WINDOW_SIZE
    [m, n] = size(BW_LEFT);
    PAD_SIZE = round((WINDOW_SIZE - 1)/2);
    BW_LEFT = [zeros(m, PAD_SIZE), BW_LEFT, zeros(m, PAD_SIZE)];
    BW_LEFT = [zeros(PAD_SIZE, n+(2*PAD_SIZE)); BW_LEFT; zeros(PAD_SIZE, n+(2*PAD_SIZE))];
    BW_RIGHT = [zeros(m, PAD_SIZE), BW_RIGHT, zeros(m, PAD_SIZE)];
    BW_RIGHT = [zeros(PAD_SIZE, n+(2*PAD_SIZE)); BW_RIGHT; zeros(PAD_SIZE, n+(2*PAD_SIZE))];
    
    [m, n] = size(BW_LEFT);
    disparity_map = zeros(m,n);
    
    switch(method)
        case "ssd"
            disp("Performaing SSD");
            for i = 1+PAD_SIZE:m-PAD_SIZE
                for j = 1+PAD_SIZE+1:n-PAD_SIZE
                    patch = BW_LEFT(i-PAD_SIZE:i+PAD_SIZE, j-PAD_SIZE:j+PAD_SIZE);
                    strip = BW_RIGHT(i-PAD_SIZE:i+PAD_SIZE, :);
                    min_cost = Inf;
                    index = 0;
                    for k = 1+PAD_SIZE:n-PAD_SIZE
                        if abs(j-k) <= THRESHOLD
                            other_patch = strip(:, k-PAD_SIZE:k+PAD_SIZE);
                            cost = sum((other_patch - patch).^2,'all'); 
                            if cost < min_cost
                                min_cost = cost;
                                index = k;
                            end
                        end
                    end
                    disparity_map(i,j) = abs(j - index);     % LEFT - RIGHT
                end
            end
        case "cc"
            disp("Performaing CC");
            for i = 1+PAD_SIZE:m-PAD_SIZE
                for j = 1+PAD_SIZE+1:n-PAD_SIZE
                    patch = BW_LEFT(i-PAD_SIZE:i+PAD_SIZE, j-PAD_SIZE:j+PAD_SIZE);
                    patch_mean = mean(patch, 'all');
                    strip = BW_RIGHT(i-PAD_SIZE:i+PAD_SIZE, :);
                    max_cost = -Inf;
                    index = 0;
                    for k = 1+PAD_SIZE:n-PAD_SIZE
                        if abs(j-k) <= THRESHOLD
                            other_patch = strip(:, k-PAD_SIZE:k+PAD_SIZE);
                            other_patch_mean = mean(other_patch, 'all');
                            cost = sum((other_patch - other_patch_mean) .* (patch - patch_mean), 'all');
                            if cost > max_cost
                                max_cost = cost;
                                index = k;
                            end
                        end
                    end
                    disparity_map(i,j) = abs(j - index);     % LEFT - RIGHT
                end
            end
        case "ncc"
            disp("Performaing NCC");
            normalized_sum_left = double(0);
            normalized_sum_right = double(0);
            for i = 1+PAD_SIZE:m-PAD_SIZE
                for j = 1+PAD_SIZE+1:n-PAD_SIZE
                    patch = BW_LEFT(i-PAD_SIZE:i+PAD_SIZE, j-PAD_SIZE:j+PAD_SIZE);
                    normalized_sum_left = normalized_sum_left + double((BW_LEFT(i,j) - mean(patch, 'all')) .^ 2);
                    
                    other_patch = BW_RIGHT(i-PAD_SIZE:i+PAD_SIZE, j-PAD_SIZE:j+PAD_SIZE);
                    normalized_sum_right = normalized_sum_right + double((BW_RIGHT(i,j) - mean(other_patch, 'all')) .^ 2);
                end
            end
            
            normal = double(sqrt(normalized_sum_left) * sqrt(normalized_sum_right));
            
            for i = 1+PAD_SIZE:m-PAD_SIZE
                for j = 1+PAD_SIZE+1:n-PAD_SIZE
                    patch = BW_LEFT(i-PAD_SIZE:i+PAD_SIZE, j-PAD_SIZE:j+PAD_SIZE);
                    patch_mean = mean(patch, 'all');
                    strip = BW_RIGHT(i-PAD_SIZE:i+PAD_SIZE, :);
                    max_cost = -Inf;
                    index = 0;
                    for k = 1+PAD_SIZE:n-PAD_SIZE
                        if abs(j-k) <= THRESHOLD
                            other_patch = strip(:, k-PAD_SIZE:k+PAD_SIZE);
                            other_patch_mean = mean(other_patch, 'all');
                            cost = sum((other_patch - other_patch_mean) .* (patch - patch_mean), 'all')/normal;
                            if cost > max_cost
                                max_cost = cost;
                                index = k;
                            end
                        end
                    end
                    disparity_map(i,j) = abs(j - index);     % LEFT - RIGHT
                end
            end
        otherwise
            disp("Select a normal output");
    end
    
    % Remove Padding
    kernel = ones(WINDOW_SIZE, WINDOW_SIZE)./(WINDOW_SIZE.^2);
    % Convolution with window Size
    disparity_map = conv2(disparity_map, kernel);
    disparity_map = disparity_map(1+PAD_SIZE:m-PAD_SIZE, 1+PAD_SIZE:n-PAD_SIZE);
    
end