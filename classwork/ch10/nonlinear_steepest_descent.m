% class 2017-11-27
% steepest descent
% page 658


clear;
clf;
close all;
format long;

% -------------------------

x0_vals = [0 0 0];

xvals = x0_vals;
x = transpose(xvals);

xargs = num2cell(xvals);

% -------------------------
% symbolic method

syms x1 x2 x3
f1 = symfun(3*x1 - cos(x2*x3) - 0.5, [x1 x2 x3]);
f2 = symfun(x1^2 - 81*(x2+0.1)^2 + sin(x3) + 1.06, [x1 x2 x3]);
f3 = symfun(exp(-x1*x2) + 20*x3 +(10*pi-3)/3, [x1 x2 x3]);

J = jacobian([f1 f2 f3], [x1 x2 x3]);

F = symfun(transpose([f1 f2 f3]), [x1 x2 x3]);

% -------------------------

J0 = double(J(xargs{:}));
F0 = double(F(xargs{:}));

dg0 = 2 .* transpose(J0) .* F0;
g0 = sum(F0.^2);
z0 = norm(dg0);

% -------------------------

N = 100;
TOL = 1e-4;

k = 1;

while k <=  N


    g1 = ;
    z = ;
    z0 = ;

    if z0 = 0
        pass

    else

    end
end






