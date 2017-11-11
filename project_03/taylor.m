% project 03
% taylor method for initial value problem
%
% Args
%   flist       (cells)     cell array of function handles for derivatives, 
%                             in order. e.g., 
%                             {first derivative, second derivative, ...}
%   order       (int)       order of taylor method. sufficient derivatives 
%                               must be provide
%   rmin        (float)     lower bound
%   rmax        (float)     upper bound
%   N           (int)       number of steps
%   y0          (float)     initial value
%
% Returns
%   t        (vector)    vector of t values
%   w        (vector)    vector of w values
%
function [t, w] = taylor(flist, order, rmin, rmax, h, y0)
    if length(flist) < order
        error("Insufficient derivatives for specified order");
    end
      
    t = rmin:h:rmax;

    w(1) = y0;

    for i=1:length(t)-1
        T = 0;
        for j=1:order
            fh = flist{j};
            T = T + (h^(j-1)/factorial(j))*fh(t(i), w(i));
        end

        w(i+1) = w(i) + h * T;
    end
end