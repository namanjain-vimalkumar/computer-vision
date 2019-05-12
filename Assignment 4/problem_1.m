% Ref: https://users.cecs.anu.edu.au/~hartley/Papers/triangulation/triangulation.pdf
clear

load('Data/pts_world.mat');
load('Data/pts_viewL.mat');
load('Data/pts_viewR.mat');

P
P_hat = get_world_points(pl, pr)


disp("Comparing with respect to ground truth: P");
ErrorMatrix = abs(P_hat - P)
E = sum(ErrorMatrix, 'all')
mean_by_axis = mean(ErrorMatrix)
mean = mean(ErrorMatrix, 'all')
std_deviation_by_axis = std(ErrorMatrix)
std_deviation = sum(std_deviation_by_axis, 'all')
MSE = sum((ErrorMatrix.^2),'all')/10




