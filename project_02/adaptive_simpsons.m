% project 02
% adaptive composite Simpson's rule for numerical intergration
%
% Args
%   f           (function)  function to evaluate
%   rmin        (int)       rmin
%   rmax        (int)       rmax
%   tol         (float)     tol
%
% Returns
%   val         (float)     val
%   out         (float)     out
%
function [val, out] = adaptive_simpsons(f, rmin, rmax, tol)

    % initialize all starting values
    val = 0;
    i = 1;
    TOL(i) = 10 * tol;
    
    a(i) = rmin;
    h(i) = (rmax-rmin)/2;
        
    F0(i) = f(rmin);
    F1(i) = f(a+h(i));
    F2(i) = f(rmax);
    S(i) = h(i) * (F0(i) + 4*F1(i) + F2(i)) / 3;
    L(i) = 1;
    
    out = [];
    
    while i > 0
        % newleft half subinterval midpoint
        F1a = f(a(i)+h(i)/2);
        % new right half subinterval midpoint
        F1b = f(a(i)+3*h(i)/2);
        
        % halve h for subinterval
        S1 = (h(i)/2) * (F0(i) + 4*F1a + F1(i)) / 3;
        S2 = (h(i)/2) * (F1(i) + 4*F1b + F2(i)) / 3;
       
        % variables for current level
        v1 = a(i);
        v2 = F0(i);
        v3 = F1(i);
        v4 = F2(i);
        v5 = h(i);
        v6 = TOL(i);
        v7 = S(i);
        v8 = L(i);
        
        i = i-1;
        
        if abs(S1+S2-v7) < v6
            val = val + (S1+S2);
            out(length(out)+1) = v1;
            
        else
            i = i+1;
            a(i) = v1 + v5;
            F0(i) = v3;
            F1(i) = F1b;
            F2(i) = v4;
            h(i) = v5/2;
            TOL(i) = v6/2;
            S(i) = S2;
            L(i) = v8 + 1;

            i = i+1;
            a(i) = v1;
            F0(i) = v2;
            F1(i) = F1a;
            F2(i) = v3;
            h(i) = h(i-1);
            TOL(i) = TOL(i-1);
            S(i) = S1;
            L(i) = L(i-1);

        end

    end
    out(length(out)+1) = rmax;

end






