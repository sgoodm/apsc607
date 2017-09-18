% newton method
%
% Args
%   f           (function)  function to evaluate
%   tol         (float)     tolerance
%   nmax        (int)       maximum number of iterations to run
%   p0          (float)     starting value
%   prime       (float)     derivate function for main function f
%   color       (str)       line color/style string for plots
%   linewidth   (float)     line width of plots
%
% Returns
%   i           (int)       number of iterations run
%   p           (float)     p val at last iteration run
%   diff        (float)     different/error at final iteration
%   status      (int)       status code indicating success/error
%
function [i, p, diff, status] = newton(f, tol, nmax, p0, fprime, ...
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
  
    out(p0)
    
    while i <= nmax
        y(i) = i;
        
        p = p0 - f(p0)/fprime(p0);
        
        out(p)
        
        if isnan(p)
            status = 1;
            break;

        elseif imag(p) ~= 0
            status = 2;
            break;
        end
                
        diff = abs(p-p0);
        
        xp(i) = p;
        xd(i) = diff;
        
        if diff < tol
            break;

        elseif i == nmax
            status = 3;
            break;
        end

        p0 = p;
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