function class_20170911

    format long

    error_msgs = {
        'Value is NaN'
        'Value is complex'
        'Reached max iteration'
    };
    

    % -------------------------------------------
    % bisection
    
    tol = 0.00001;
    nmax = 30;
    
    i = 1;
    error = 0;
    
    a = 1;
    b = 2;
     
    while i <= nmax
              
        FA = f(a);
                
        p = (a+b)/2;
       
        FP = f(p);
        
        disp([
            'Iter' num2str(i) '- '...
            ' a = ' num2str(a,10)...
            ' b = ' num2str(b,10)...
            ' p = ' num2str(p,10)...
            ' FP = ' num2str(FP,6)
        ]);

        check = (b-a)/2; 
        
        if FP == 0 || check < tol
            break;
        end
        
        if FA * FP > 0
            a = p;
        else
            b = p;
        end
        
        if i == nmax
            error = 3;
            break;
        end

        i = i + 1;
    end  
    
    % check error status and display final outputs
    if error ~= 0
        disp(error_msgs(error));
    else
        disp('Successfully found value')
    end
    
    disp(['Ran ' num2str(i) ' iterations']);
    
    
    % -------------------------------------------
    % fixed point       

    tol = 0.000000001;
    nmax = 30;
    
    i = 1;
    error = 0;

    p0 = 1.5;
    disp(p0);
    
    % define function to use
    g = @g5;

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

    
    % -------------------------------------------
    % newton

    %
    
    
    % -------------------------------------------
    % secant

    %
    
    
    % -------------------------------------------
    % functions    

    f = @(x) x.^3 + 4*x.^2 -10;
    g1 = @(x) x - x.^3 - 4*x.^2 +10;
    g2 = @(x) sqrt(10/x - 4*x);
    g3 = @(x) 0.5 * sqrt(10 - x.^3);
    g4 = @(x) sqrt(10/(4+x));
    g5 = @(x) x -((x.^3 +4*x.^2-10)/(3*x.^2+8*x));

    
    a = @(x) exp(x) + 2.^x + 2*cos(x)-6;
    ap = @(x) exp(x) + (2.^x)*log(x) - 2*sin(x);

    

end



