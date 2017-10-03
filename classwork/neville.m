%
% Neville Method interpolation implementation
%
% Args
%   
%
% Returns
%   out     
%
function [Q] = neville(xest, x, y, tol)
    
    Q = transpose(y);

    for i = 1:length(x)
        
        for j = 2:i
            
            ximinusj = x(i-j);
            xi = x(i);
            Qa = Q(i, j-1);
            Qb = Q(i-1, j-1);
            
            a = (xest - ximinusj) * Qa;
            b =  (xest - xi) * Qb;
            c = xi - ximinusj;

            Q(i+1, j+1) = (a.*b) ./ c;
  
        end

    end

end



