load('Sessions/leftCalibrationSession.mat');
leftCameraParams = calibrationSession.CameraParameters;
Kl = transpose(leftCameraParams.IntrinsicMatrix);

Rl = zeros(3,3);
for i = 1:3
    for j = 1:3
        Rl(i,j) = mean(leftCameraParams.RotationMatrices(i,j,1:12));
    end
end

tl = mean(leftCameraParams.TranslationVectors);

Pl = Kl*[Rl, transpose(tl)];

load('Sessions/rightCalibrationSession.mat');
rightCameraParams = calibrationSession.CameraParameters;

Kr = transpose(rightCameraParams.IntrinsicMatrix);

Rr = zeros(3,3);
for i = 1:3
    for j = 1:3
        Rr(i,j) = mean(rightCameraParams.RotationMatrices(i,j,1:12));
    end
end

tr = mean(rightCameraParams.TranslationVectors);

Pr = Kr*[Rr, transpose(tr)];

disp("For left Camera")
disp("Intrinsic")
disp(Kl)

disp("Extrinsic")
disp([Rl, transpose(tl)])

disp("Projective")
disp(Pl)

disp("For right Camera")
disp("Intrinsic")
disp(Kr)

disp("Extrinsic")
disp([Rr, transpose(tr)])

disp("Projective")
disp(Pr)
