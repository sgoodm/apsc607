% project 02
% composite midpoint rule for numerical intergration
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
function [val, h] = midpoint(f, n, rmin, rmax)
   
    h = (rmax-rmin) / (n+2);
    
    j = -1:n+1;
    xj = rmin + (j+1)*h;
    
    k = 2 * (0:n/2) + 2;
    val = 2*h * sum(f(xj(k)));  
    
end