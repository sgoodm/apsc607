% Neville Method interpolation implementation
% pg 123
%
% Args
%   
%
% Returns
%   out     
%
function [Q] = neville(xest, x, y)
    
    Q = transpose(y);
    n = length(x);

    for i = 2:n      
        for j = 2:i         
            a = (xest - x(i-j+1)) * Q(i, j-1);
            b = (xest - x(i)) * Q(i-1, j-1);
            c = x(i) - x(i-j+1);

            Q(i, j) = (a-b) / c;
        end
    end

end



