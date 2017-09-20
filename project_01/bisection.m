% bisection method
%
% Args
%   f           (function)  function to evaluate
%   tol         (float)     tolerance
%   nmax        (int)       maximum number of iterations to run
%   a           (float)     minimum value in range
%   b           (float)     maximum value in range
%   color       (str)       line color/style string for plots
%   linewidth   (float)     line width of plots
%   v           (bool)      verbose output (print statements which may be useful for examining specific results or debugging)
%
% Returns
%   i           (int)       number of iterations run
%   p           (float)     p val at last iteration run
%   diff        (float)     different/error at final iteration
%   status      (int)       status code indicating success/error
%
function [i, p, diff, status] = bisection(f, tol, nmax, a, b, ...
                                          color, linewidth, v)

    if nmax == 0
        nmax = 10^10;
    end

    error_msgs = {
        'Value is NaN'
        'Value is complex'
        'Reached max iteration'
    };

    i = 1;
    status = 0;


    while i <= nmax
        y(i) = i;

        FA = f(a);

        p = (a+b)/2;

        FP = f(p);

        out([
            'Iter' num2str(i) '- '...
            ' a = ' num2str(a,10)...
            ' b = ' num2str(b,10)...
            ' p = ' num2str(p,10)...
            ' FP = ' num2str(FP,6)
        ]);

        if isnan(p)
            status = 1;
            break;

        elseif imag(p) ~= 0
            status = 2;
            break;
        end

        diff = (b-a)/2;

        xp(i) = p;
        xd(i) = diff;

        if FP == 0 || diff < tol
            break;

        elseif i == nmax
            status = 3;
            break;
        end

        if FA * FP > 0
            a = p;
        else
            b = p;
        end

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
