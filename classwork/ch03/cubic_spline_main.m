% class 20171002
% Cubic Spline

clear;
close all;

f = @(x) exp(x);
xvals = [0, 1, 2, 3];

[a, b, c, d] = cubic_spline(f, xvals);

a, b, c, d

% S = a + b.*(x - xvals) + c .* (x - xvals).^2 + d .* (x - xvals).^3;

S = [];
steps = [];
h = 0.1;
for i = 1:length(xvals)-1
    xval = xvals(i);
    x = xvals(i):h:xvals(i+1);
    Sx = a(i) + b(i).*(x - xval) + c(i) .* (x - xval).^2 + d(i) .* (x - xval).^3;
    S = horzcat(S, Sx);
    steps = horzcat(steps, x);
end

plot(steps, S)
hold 
fplot(f, [min(steps), max(steps)])
legend("y=S(x)", "y=f(x)", "Location", "Best")
