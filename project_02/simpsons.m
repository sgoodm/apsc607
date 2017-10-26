% project 02
% composite Simpson's rule for numerical intergration
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
function [val, h] = simpsons(f, n, rmin, rmax)

%     h = (rmax-rmin)/ n;
%     j = 0:n-1;
%     x0 = rmin + j*h ;
%     x1 = rmin + j*h + h/2;
%     x2 = rmin + j*h + h;
%     x = (h/6) * (f(x0) + 4*f(x1) + f(x2));
%     val = sum(x);
    
    h = (rmax-rmin)/ n;
    j = 1:n;
    xj = rmin + j*h;
    
    j1 = 1:((n/2)-1);
    x1 = f(xj(2*j1));
    j2 = 1:(n/2);
    x2 = f(xj(2*j2-1));
    val = (h/3) * (f(rmin) + 2*sum(x1) + 4*sum(x2) + f(rmax));
    
end

