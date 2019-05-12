function blend = blend_images(img1, img2, mask1)

    img1 = imread(img1);
    img2 = imread(img2);
    
    % 1. Find Gaussian pyramids GA and GB for images A and B
    %    - Smooth the image
    %    - Downsample the image
    
    GA = {};
    GB = {};
    g_mask = {};
    GA{1} = img1;
    GB{1} = img2;
    g_mask{1} = mask1;
    for i = 2:5
        GA{i} = generateMyGaussian(GA{i-1}, 3);
        GB{i} = generateMyGaussian(GB{i-1}, 3);
        g_mask{i} = generateMyGaussian(g_mask{i-1}, 1);
    end

    
    
    % 2. Find Laplasian pyramids LA and LB for images A and B
    %    L0 = G0 - G1

    for i = 1:4
        SA = stretchMe(GA{i+1}, 3);
        [m,n,l] = size(SA);
        LA{i} = uint8(GA{i}(1:m,1:n,:)) - uint8(SA);
        
        SB = stretchMe(GB{i+1}, 3);
        [m,n,l] = size(SB);
        LB{i} = uint8(GB{i}(1:m,1:n,:)) - uint8(SB);
    end
    
    SL = {};
    for i = 1:4
        [m,n,l] = size(LA{i});
        mask = zeros(m,n,3);
        mask(:,:,1) = g_mask{i}(1:m,1:n);
        mask(:,:,2) = g_mask{i}(1:m,1:n);
        mask(:,:,3) = g_mask{i}(1:m,1:n);
        SL{i} = (uint8(mask) .* LA{i}) + (uint8(1-mask) .* LB{i});
    end
    
    last_pyramid = 5;
    SG = {};
    [m,n,l] = size(GA{last_pyramid});
    mask = zeros(m,n,3);
    mask(:,:,1) = g_mask{last_pyramid}(1:m,1:n);
    mask(:,:,2) = g_mask{last_pyramid}(1:m,1:n);
    mask(:,:,3) = g_mask{last_pyramid}(1:m,1:n);
    SG{last_pyramid} = (uint8(mask) .* GA{last_pyramid}) + (uint8(1-mask) .* GB{last_pyramid});
    
    for i = fliplr(1:last_pyramid-1)
        SG_stretched = stretchMe(SG{i+1},3);
        [m,n,l] = size(SG_stretched);
        SG{i} = SG_stretched + SL{i}(1:m,1:n,:);
    end
    
    % Generating blended images
    for i = 1:last_pyramid
        subplot(1,last_pyramid, i);
        imshow(SG{i});
        title(strcat('Blended Image SL',string(i-1)));
    end

%     % Generating Gaussians graph
%     for i = 1:5
%         subplot(3,5,i)
%         imshow(GA{i})
%         title(strcat(strcat('G', string(i-1)), ' of Image 1'));
%         subplot(3,5,i+5)
%         imshow(GB{i})
%         title(strcat(strcat('G', string(i-1)), ' of Image 2'));
%         subplot(3,5,i+10)
%         imshow(g_mask{i})
%         title(strcat(strcat('G', string(i-1)), ' of Mask'));
%     end

%     % Generating Laplacians
%     for i = 1:4
%         subplot(2,5,i)
%         imshow(LA{i})
%         title(strcat(strcat('L', string(i-1)), ' of Image 1'));
%         subplot(2,5,i+5)
%         imshow(LB{i})
%         title(strcat(strcat('L', string(i-1)), ' of Image 2'));
%     end
    
    blend = SG;
end