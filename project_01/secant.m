% secant method
%
% Args
%   f           (function)  function to evaluate
%   tol         (float)     tolerance
%   nmax        (int)       maximum number of iterations to run
%   p0          (float)     minimum value in range
%   p1          (float)     maximum value in range
%   color       (str)       line color/style string for plots
%   linewidth   (float)     line width of plots
%   v           (bool)      verbose output (print statements which may be useful for examining specific results or debugging)
%
% Returns
%   i           (int)       number of iterations run
%   p           (float)     p val at last iteration run
%   diff        (float)     difference/error at final iteration
%   status      (int)       status code indicating success/error
%
function [i, p, diff, status] = secant(f, tol, nmax, p0, p1, ...
                                       color, linewidth, v)

    if nmax == 0
        nmax = 10^10;
    end

    error_msgs = {
        'Value is NaN'
        'Value is complex'
        'Reached max iteration'
    };

    i = 2;
    status = 0;

    while i <= (nmax+1)
        y(i-1) = i-1;

        q0 = f(p0);
        q1 = f(p1);

        p = p1 - q1*(p1-p0)/(q1-q0);

        out(p)

        if isnan(p)
            status = 1;
            break;

        elseif imag(p) ~= 0
            status = 2;
            break;
        end

        diff = abs(p-p1);

        xp(i-1) = p;
        xd(i-1) = diff;

        if diff < tol
            break;

        elseif i == nmax
            status = 3;
            break;
        end

        p0 = p1;
        q0 = q1;
        p1 = p;
        q1 = f(p);

        i = i + 1;
    end

    % check error status and display final outputs
    if status ~= 0 && v
        out(error_msgs(status));
    else
        out('Successfully found value');
        subplot(1,2,1);
        plot(y, xp, color, 'Linewidth', linewidth);
        hold on;
        subplot(1,2,2);
        plot(y, xd, color, 'Linewidth', linewidth);
        hold on;
    end

    out(['Ran ' num2str(i) ' iterations']);

    function out(val)
        if v, disp(val), end
    end

end
