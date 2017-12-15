% class 2017-11-20
% nonlinear systems - newton method
% page 641


clear;
clf;
close all;
format long;



x0_vals = [0.1 0.1 -0.1];

syms x1 x2 x3
f1 = symfun(3*x1 - cos(x2*x3) - 0.5, [x1 x2 x3]);
f2 = symfun(x1^2 - 81*(x2+0.1)^2 + sin(x3) + 1.06, [x1 x2 x3]);
f3 = symfun(exp(-x1*x2) + 20*x3 +(10*pi-3)/3, [x1 x2 x3]);
F = symfun(transpose([f1 f2 f3]), [x1 x2 x3]);




N = 200;
TOL = 1e-5;

x1 = nonlinear_newton(F, x0_vals, N, TOL);
x2 = nonlinear_broyden(F, x0_vals, N, TOL);


N = 100;
TOL = 1e-4;

x0_vals = [0 0 0];
x3 = nonlinear_steepest_descent(F, x0_vals, N, TOL);


% -------------------------
% manual method

% F = @(x1, x2, x3) [
%       (3*x1 - cos(x2*x3) - 0.5)
%       (x1^2 - 81*(x2+0.1)^2 + sin(x3) + 1.06)
%       (exp(-x1*x2) + 20*x3 +(10*pi-3)/3)
% ];
%
% J = @(x1, x2, x3) [
%       3               x3*sin(x2*x3)  x2*sin(x2*x3)
%       2*x1           -162*(x2+0.1)   cos(x3)
%      -x2*exp(-x1*x2) -x1*exp(-x1*x2) 20
% ];
%
% F0 = F(xargs{:});
% J0 = J(xargs{:});

% -------------------------


