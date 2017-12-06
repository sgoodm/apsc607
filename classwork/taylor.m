% project 03
% taylor method for initial value problems
%
% Args
%   flist       (cells)     cell array of function handles for derivatives, 
%                             in order. e.g., 
%                             {first derivative, second derivative, ...}
%   order       (int)       order of taylor method. sufficient derivatives 
%                               must be provide
%   a           (float)     lower bound
%   b           (float)     upper bound
%   h           (int)       step size
%   y0          (float)     initial value
%
% Returns
%   w        (vector)    vector of w values
%
function [w] = taylor(flist, order, a, b, h, y0)
    if length(flist) < order
        error("Insufficient derivatives for specified order");
    end
      
    t = a:h:b;
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