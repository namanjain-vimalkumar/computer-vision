RGB = imread('lines.jpg');

p = 18;                          % Edit this as threshold

I = rgb2gray(RGB);
[BW]=edge(I, 'canny');

T = -90:1:89;
rho_max = round(sqrt(sum(size(BW) .^ 2)));

R = -rho_max:1:rho_max;
Acc = zeros(max(size(R)), 180);

[m, n] = size(BW);

for x = 1:m
    for y = 1:n
        if(BW(x,y) == 1)
            for theta = -90:1:89
                theta_index = theta + 90 + 1;
                theta = theta * pi/180;             % Converting degrees to radians
                
                rho = round((x*cos(theta)) + (y*sin(theta)));
                rho_index = rho + rho_max + 1;
                
                Acc(rho_index, theta_index) = Acc(rho_index, theta_index) + 1;
            end
        end
    end
end

% houghpeaks
Acc_max = Acc;
peakValues = [];
for i = 1:1:p
   max_i = max(Acc_max, [], 'all') ;
   [rho, theta] = find(Acc_max == max_i(1));
   peakValues = [peakValues; rho(1), theta(1)];
   Acc_max(rho(1), theta(1)) = -1;
end

%houghlines

lines = houghlines(BW,T,R,peakValues);

lineValues = [];
for i = 1:1:p
    line.theta = peakValues(i,2) - 90 - 1;
    line.rho = peakValues(i,1) - rho_max - 1;
    line.point1 = [];
    line.point2 = [];
    line.last = [];
    lineValues = [lineValues; line];
end

for i = 1:1:m
    for j = 1:1:n
        if BW(i,j) == 1
            for k = 1:1:p
               theta =  lineValues(k).theta*pi/180;
               rho = round(i*cos(theta) + j*sin(theta));
               if rho == lineValues(k).rho
                    if isempty(lineValues(k).point1) == 1
                        lineValues(k).point1 = [i,j];
                        continue;
                    end
                    lineValues(k).point2 = lineValues(k).last;
                    lineValues(k).last = [i,j];
               end
            end
        end
    end
end

imshow(BW)
hold on
for k = 1:numel(lineValues)
    if isempty(lineValues(k).point1) == 0
        x1 = lineValues(k).point1(2);
        y1 = lineValues(k).point1(1);
        x2 = lineValues(k).point2(2);
        y2 = lineValues(k).point2(1);
        plot([x1 x2],[y1 y2],'Color','g','LineWidth', 4)
    end
end
hold off





