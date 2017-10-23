% project 02
% composite trapezoilal rule for numerical intergration
%
% Args
%   f           (function)  function to evaluate
%   n           (int)       n
%   rmin        (int)       rmin
%   rmax        (int)       rmax
%
% Returns
%   val         (float)     val
%   h           (float)     h
%
function [val, h] = trapezoidal(f, n, rmin, rmax)

    h = (rmax-rmin)/ n;
    j = 1:n-1;
    xj = rmin + j*h;
    val = (h/2) * (f(rmin) + 2 * sum(f(xj))  + f(rmax));
    
end







