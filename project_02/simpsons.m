% project 02
% composite Simpson's rule for numerical intergration
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
function [val, h] = simpsons(f, n, rmin, rmax)

    h = (rmax-rmin)/ n;
    
    i = 0:n-1;
    
    x0 = rmin + i*h ;
    x1 = rmin + i*h + h/2;
    x2 = rmin + i*h + h;

    x = (h/6) * (f(x0) + 4*f(x1) + f(x2));
      
    val = sum(x);
    
end

