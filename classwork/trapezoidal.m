% project 02
% composite trapezoilal rule for numerical intergration
%
% Args
%   f           (function)  function to evaluate
%   n           (int)       number of subintervals
%   rmin        (float)     lower bound
%   rmax        (float)     upper bound
%
% Returns
%   val         (float)     integral value
%   h           (float)     h value for given n
%
function [val, h] = trapezoidal(f, n, rmin, rmax)

    h = (rmax-rmin)/ n;
    j = 1:n-1;
    xj = rmin + j*h;
    val = (h/2) * (f(rmin) + 2 * sum(f(xj))  + f(rmax));
    
end







