
function fixed_point(g)

    format long

    error_msgs = {
        'Value is NaN'
        'Value is complex'
        'Reached max iteration'
    };
    
    % -------------------------------------------
    % fixed point       

    tol = 0.000000001;
    nmax = 30;
    
    i = 1;
    error = 0;

    p0 = 1.5;
    disp(p0);
    

    while i <= nmax
              
        p = g(p0);
        disp(p)

        if isnan(p)
            error = 1;
            break;

        elseif imag(p) ~= 0
            error = 2;
            break;

        elseif abs(p-p0) < tol
            break;

        elseif i == nmax
            error = 3;
            break;
        end

        p0 = p;
        i = i + 1;
    end

    % check error status and display final outputs

    if error ~= 0
        disp(error_msgs(error));
    else
        disp('Successfully found value')
    end
    
    disp(['Ran ' num2str(i) ' iterations']);

end    