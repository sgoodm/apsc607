% project 03
% runge-kutta (order four) method for initial value problem
%
% Args
%   fh          (function)  function handle for derivative
%   rmin        (float)     lower bound
%   rmax        (float)     upper bound
%   N           (int)       number of steps
%   y0          (float)     initial value
%
% Returns
%   t        (vector)    vector of t values
%   w        (vector)    vector of w values
%
function [t, w] = rungekutta(fh, rmin, rmax, h, y0)

    t = rmin:h:rmax;
    w(1) = y0;

    for i=1:length(t)-1
        K1 = h * fh(t(i), w(i));
        K2 = h * fh(t(i) + h/2, w(i) + K1/2);
        K3 = h * fh(t(i) + h/2, w(i) + K2/2);
        K4 = h * fh(t(i) + h, w(i) + K3);

        w(i+1) = w(i) + (K1 + 2*K2 + 2*K3 + K4)/6;
    end
end







