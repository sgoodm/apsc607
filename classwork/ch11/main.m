% ch 11

clear;
close all;

% syms x y yp
% sym_ypp = symfun(-2*yp/x + 2*y/x^2 + sin(log(x))/x^2, [x,y,yp]);
% ypp = matlabFunction(sym_ypp);

p = @(x) -2/x;
q = @(x) 2/x^2;
r = @(x)  sin(log(x))/x^2;

aa = 1;
bb = 2;

ya = 1;
yb = 2;


N = 9;
[x1, w] = finite_difference(p, q, r, aa, bb, ya, yb, N);


N = 10;
[x2, w1, w2] = linear_shooting(p, q, r, aa, bb, ya, yb, N);

