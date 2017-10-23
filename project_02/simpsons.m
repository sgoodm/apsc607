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

    h = (rmax-rmin)/ (2*n);
    
    i = 1:n;
    
    x0 = rmin + (i-1)*2*h + 0*h;
    x1 = rmin + (i-1)*2*h + 1*h;
    x2 = rmin + (i-1)*2*h + 2*h;

    x = (h/3) * (f(x0) + 4*f(x1) + f(x2));
      
    val = sum(x);
    
end

