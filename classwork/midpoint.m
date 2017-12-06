% project 02
% composite midpoint rule for numerical intergration
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
function [val, h] = midpoint(f, n, rmin, rmax)
   
    h = (rmax-rmin) / (n+2);
    j = -1:n+1;
    xj = rmin + (j+1)*h;
    k = 2 * (0:n/2) + 2;
    val = 2*h * sum(f(xj(k)));  
    
end