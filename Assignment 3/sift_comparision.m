function X = sift_comparision(img1, img2)
    I1 = imread(img1);
    I2 = imread(img2);

    BW1 = rgb2gray(I1);
    BW2 = rgb2gray(I2);
    
    [f1, d1] = vl_sift(single(BW1));
    [f2, d2] = vl_sift(single(BW2));

    [matches, score] = vl_ubcmatch (d1, d2);

    M1 = [f1(1, matches(1, :)); f1(2, matches(1, :)); ones(1, length(matches))];
    M2 = [f2(1, matches(2, :)); f2(2, matches(2, :)); ones(1, length(matches))];

    showMatchedFeatures(I1,I2,[M1(1:2, :)]',[M2(1:2, :)]','montage','PlotOptions',{'ro','g+','b-'} );
end