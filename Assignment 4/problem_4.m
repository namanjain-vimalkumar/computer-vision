problem_3

imgL = 'Images/officeL.png';
imgR = 'Images/officeR.png';

[rectL, rectR] = rectify_images(imgL, imgR, Pl, Pr);

% d_map = compute_corrs(rectL, rectR, "ssd");

[m,n] = size(rectL);

% cloud = zeros(m,n, round(max(max(d_map))));
% for i = 1:m
%    for j = i:n
%        cloud(i,j,round(d_map(i,j)+1)) = rectL(i,j);
%    end
% end

subplot(1,3,1)
imshow(uint8(rectL))
title('Rectified Left Image')
subplot(1,3,2)
imshow(uint8(rectR))
title('Rectified Right Image')
subplot(1,3,3)
title('Not implemented')
