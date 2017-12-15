% class 2017-11-20
% nonlinear systems - newton method
% page 641

    
function [x] = nonlinear_newton(F, x0_vals, N, TOL)

    xvals = x0_vals;
    x = transpose(xvals);

    xargs = num2cell(xvals);

    J = jacobian(F);

    J0 = double(J(xargs{:}));
    F0 = double(F(xargs{:}));

    k = 1;

    tol_check = TOL + 1;
    while k<= N && tol_check > TOL

        Fx = double(F(xargs{:}));
        Jx = double(J(xargs{:}));

    %     Jx_inv = inv(Jx);
        Jx_id = [Jx eye(size(Jx, 1))];
        [~,Jx_inv] = gaussian_elimination(Jx_id);

        y = sum(-Fx .* Jx_inv, 2);

        x = x + y;

        tol_check = norm(y);

        k = k+1;
        
        xargs = num2cell(x);
    end

    if k > N
        disp("Warning: max iterations reached")
    end
    
end











