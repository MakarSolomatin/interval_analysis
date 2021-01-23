pkg load interval;

addpath('./IntLinIncR2');
addpath('./IntLinIncR3');

A = [infsup(5, 7), infsup(6, 10);
     infsup(2, 4), infsup(1, 3);
     infsup(6, 8), infsup(3, 5)];
b = [infsup(2, 6); infsup(1, 5); infsup(3.4, 9)];

% 2 x 3 matrix
x = [0.5; 0.2; 0.3 ];
b = [infsup(4, 7); infsup(3.3, 5.7)];
infA = inf(A);
supA = sup(A);
infb = inf(b);
supb = sup(b);
[maxTol, argmaxTol] = tolsolvty(infA', supA', infb, supb);
cnd = mincond(A', 3);
c = 0.5 * (abs(supb) - abs(infb));
ive = sqrt(3) * maxTol * norm(argmaxTol) / norm(c) * cnd;
disp('2 x 3:');
disp('IVE = ');
disp(ive);
disp('Max tol = ');
disp(maxTol);
disp('Cond = ');
disp(cnd);
EqnTolR3(infA', supA', infb, supb, 1, 1);
rectangle('Position', [argmaxTol(1) - ive / 2, argmaxTol(2) - ive / 2, ive, ive], 'EdgeColor', 'b');
rectangle('Position', [argmaxTol(1) - 0.003, argmaxTol(2) - 0.003, 0.006, 0.006], 'FaceColor', 'r');
text(argmaxTol(1) + 0.01, argmaxTol(2) + 0.01, 'argmaxTol','FontSize', 10);
title('2 x 3');
xlabel('x_1');
ylabel('x_2');
print('-dpng', '-r300', '2x3.png');
