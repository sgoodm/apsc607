% project 03
% trapezoidal with newtonian iteration method for initial value problem
%
% Args
%   fh          (function)  function handle for derivative
%   rmin        (float)     lower bound
%   rmax        (float)     upper bound
%   N           (int)       number of steps
%   y0          (float)     initial value
%
% Returns
%   t        (vector)    vector of t values
%   w        (vector)    vector of w values
%
function [t, w] = trapezoidal(fh, fph, rmin, rmax, h, y0, TOL, M)

    t = rmin:h:rmax;
    w(1) = y0;
    
    for i=1:length(t)-1
        k1 = w(i) + 0.5*h * fh(t(i), w(i));
        w0 = k1;
        j = 1;
        FLAG = 0;

        while FLAG == 0
            num = w0 - 0.5*h * fh(t(i)+h, w0) - k1;
            den = 1 - 0.5*h * fph(t(i)+h, w0);
            w(i+1) = w0 - num/den;

            if abs(w(i+1)-w0) < TOL
                FLAG = 1;
            else
                j = j+1;
                w0 = w(i+1);
                if j > M
                    error('Max iter');
                end
            end

        end
        
    end
end