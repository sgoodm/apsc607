% project 03
% runge-kutta (order four) method for initial value problems
%
% Args
%   fh          (function)  function handle for derivative
%   a           (float)     lower bound
%   b           (float)     upper bound
%   h           (int)       step size
%   y0          (float)     initial value
%
% Returns
%   w        (vector)    vector of w values
%
function [w] = rungekutta(fh, a, b, h, y0)

    t = a:h:b;
    w(1) = y0;

    for i=1:length(t)-1
        K1 = h * fh(t(i), w(i));
        K2 = h * fh(t(i) + h/2, w(i) + K1/2);
        K3 = h * fh(t(i) + h/2, w(i) + K2/2);
        K4 = h * fh(t(i) + h, w(i) + K3);

        w(i+1) = w(i) + (K1 + 2*K2 + 2*K3 + K4)/6;
    end
end







