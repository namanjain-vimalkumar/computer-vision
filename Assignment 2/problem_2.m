P_W = [-1, -0.5, -1; -1, 0.5, -1; 1, 0.5, -1; 1, -0.5, -1; -1, -0.5, 1; -1, 0.5, 1; 1, 0.5, 1; 1, -0.5, 1; -1, 0, 1.5; 1, 0, 1.5;];

base = P_W.';
subplot(2,3,1)

plot3([base(1,1:4) base(1,1)], [base(2,1:4) base(2,1)], [base(3,1:4) base(3,1)],'-o', 'Color','r');
hold on
plot3([base(1,5:8) base(1,5)], [base(2,5:8) base(2,5)], [base(3,5:8) base(3,5)], '-o', 'Color','g');
plot3(base(1,9:10), base(2,9:10), base(3,9:10), '-o', 'Color','black');

plot3([base(1,1) base(1,5)], [base(2,1) base(2,5)], [base(3,1) base(3,5)], '-o', 'Color', 'b');
plot3([base(1,2) base(1,6)], [base(2,2) base(2,6)], [base(3,2) base(3,6)], '-o', 'Color', 'b');
plot3([base(1,3) base(1,7)], [base(2,3) base(2,7)], [base(3,3) base(3,7)], '-o', 'Color', 'b');
plot3([base(1,4) base(1,8)], [base(2,4) base(2,8)], [base(3,4) base(3,8)], '-o', 'Color', 'b');

plot3([base(1,5) base(1,9)], [base(2,5) base(2,9)], [base(3,5) base(3,9)], '-o', 'Color','black');
plot3([base(1,6) base(1,9)], [base(2,6) base(2,9)], [base(3,6) base(3,9)], '-o', 'Color','black');
plot3([base(1,7) base(1,10)], [base(2,7) base(2,10)], [base(3,7) base(3,10)], '-o', 'Color','black');
plot3([base(1,8) base(1,10)], [base(2,8) base(2,10)], [base(3,8) base(3,10)], '-o', 'Color','black');
title('Actual Wireframe');
hold off 

C = [10,10,0; -10,10,0; 0,0,10; 10,0,0; 10,10,10];
for i = 1:1:5
    
    p = [50,50,0]
    c = C(i,:);
    tx = atan2(norm(cross([1,0,0],(p-c))),dot([1,0,0],(p-c)));
    ty = atan2(norm(-cross([0,1,0],(p-c))),dot([0,1,0],(p-c))); 
    tz = atan2(norm(cross([0,0,1],(p-c))),dot([0,0,1],(p-c)));

    Rx = [1 0 0; 0 cos(tx) -sin(tx); 0 sin(tx) cos(tx)];
    Ry = [cos(ty) 0 sin(ty); 0 1 0; -sin(ty) 0 cos(ty)];
    Rz = [cos(tz) -sin(tz) 0; sin(tz) cos(tz) 0; 0 0 1];

    R = Rz*Ry*Rx; 
    
    subplot(2,3,i+1);
    hold on;
    X = project_points(P_W, R, C(i,:).').';
    plot([X(1,1:4) X(1,1)], [X(2,1:4) X(2,1)],'-o', 'Color','r');
    plot([X(1,5:8) X(1,5)], [X(2,5:8) X(2,5)], '-o', 'Color','g');
    plot(X(1,9:10), X(2,9:10), '-o', 'Color','black');

    plot([X(1,1) X(1,5)], [X(2,1) X(2,5)], '-o', 'Color', 'b');
    plot([X(1,2) X(1,6)], [X(2,2) X(2,6)], '-o', 'Color', 'b');
    plot([X(1,3) X(1,7)], [X(2,3) X(2,7)], '-o', 'Color', 'b');
    plot([X(1,4) X(1,8)], [X(2,4) X(2,8)], '-o', 'Color', 'b');

    plot([X(1,5) X(1,9)], [X(2,5) X(2,9)], '-o', 'Color','black');
    plot([X(1,6) X(1,9)], [X(2,6) X(2,9)], '-o', 'Color','black');
    plot([X(1,7) X(1,10)], [X(2,7) X(2,10)], '-o', 'Color','black');
    plot([X(1,8) X(1,10)], [X(2,8) X(2,10)], '-o', 'Color','black');
    title(strcat('Camera at ', mat2str(C(i,:))));
    hold off 
end
