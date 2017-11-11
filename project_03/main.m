% seth goodman
% apsc 607
% project 03

% clear workspace and figures
% clear;
% clf;
close all;

format long;

% ----------------------------------------


%   func   a    b    h      y(0) 
jobs = {...
    'a'    0    1    0.1    exp(1) ;
    'b'    0    1    0.1    1/3    ;
};


% ----------------------------------------


fa = @(t,y) -9*y;

fb = @(t,y) -20 * (y-t^2) + 2*t;


% ----------------------------------------
% run


% fh = @(t,y) y - t.^2 + 1;
% rmin = 0;
% rmax = 2;
% N = 10;
% h = (rmax - rmin) / N;
% y0 = 0.5;


syms t y
sym_fh = 5 * exp(5*t) * (y-t)^2 + 1;
sym_fph = diff(sym_fh);

fh = matlabFunction(sym_fh);
fph = matlabFunction(sym_fph);

rmin = 0;
rmax = 1;
N = 5;
h = (rmax - rmin) / N;
y0 = -1;

[t1, w1] = taylor({fh}, 1, rmin, rmax, h, y0);

[t2, w2] = rungekutta(fh, rmin, rmax, h, y0);

TOL = 1e-6;
M = 10;
[t3, w3] = trapezoidal(fh, fph, rmin, rmax, h, y0, TOL, M);


