% project 03
% trapezoidal with newtonian iteration method for initial value problems
%
% Args
%   fh          (function)  function handle 
%   fh_diff     (function)  function handle for derivative
%   a           (float)     lower bound
%   b           (float)     upper bound
%   h           (int)       step size
%   y0          (float)     initial value
%
% Returns
%   w        (vector)    vector of w values
%
function [w] = trapezoidal(fh, fh_diff, a, b, h, y0, TOL, M)

    t = a:h:b;
    w(1) = y0;
    
    for i=1:length(t)-1
        k1 = w(i) + 0.5*h * fh(t(i), w(i));
        w0 = k1;
        j = 1;
        FLAG = 0;

        while FLAG == 0
            num = w0 - 0.5*h * fh(t(i)+h, w0) - k1;
            den = 1 - 0.5*h * fh_diff(t(i)+h, w0);
            w(i+1) = w0 - num/den;

            if abs(w(i+1)-w0) < TOL
                FLAG = 1;
            else
                j = j+1;
                w0 = w(i+1);
                if j > M
                    warning('Max iter reached');
                    FLAG = 1;
                end
            end

        end
        
    end
end