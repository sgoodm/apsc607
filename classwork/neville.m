%
% Neville Method interpolation implementation
%
% Args
%   
%
% Returns
%   out     
%
function [out] = neville(x, y, tol)
    
    Q = transpose(y);

    for i = 1:length(x)

        j = 1;
        while Q < tol
            j = j + 1;
            Q(i,j) = (1 / (xi - xij)) * ((x - xij) * Qa - (x-xi) * Qb);
            
        end

    end

end