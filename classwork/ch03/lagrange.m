% Lagrange interpolation implementation
%
% Args
%   f       function
%   x       value to approximate
%   nodes   nodes used to approximate
%
% Returns
%   out     approximation for input x
%
function [out] = lagrange(f, x, nodes)

    out = 0;

    for xk = nodes

        Lk =  1;
        for xi = nodes
            if xi ~= xk    
                Lk = Lk * (x-xi)/(xk-xi);
            end
        end

        fk = f(xk);
        out = out + fk * Lk;

    end

end

