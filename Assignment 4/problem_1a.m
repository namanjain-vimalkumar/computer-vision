% Problem 1 a

load('Data/pts_world.mat');
load('Data/pts_viewL.mat');
load('Data/pts_viewR.mat');
[Kl, Tl, Kr, Tr] = compute_stereo_calib(P, pl, pr)

n_pl = transpose(Kl*Tl*transpose([P, ones(10,1)]));
pl
n_pl = n_pl ./ n_pl(:,3)

n_pr = transpose(Kr*Tr*transpose([P, ones(10,1)]));
pr
n_pr = n_pr ./ n_pr(:,3)

% clear