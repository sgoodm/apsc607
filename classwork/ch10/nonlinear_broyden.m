% class 2017-11-20
% nonlinear systems - broyden method
% page 650

function [x] = nonlinear_broyden(F, x0_vals, N, TOL)

    xvals = x0_vals;
    x = transpose(xvals);

    xargs = num2cell(xvals);

    J = jacobian(F);

    J0 = double(J(xargs{:}));
    F0 = double(F(xargs{:}));

    % -------------------------

    % save
    v = F0;

    A0 = J0;

    % A_inv = inv(A0);
    A0_id = [A0 eye(size(A0, 1))];
    [~,A] = gaussian_elimination(A0_id);

    s = -A*v;

    x = x + s;
    k = 2;
    
    norm_val = TOL + 1;
    while k <= N && norm_val > TOL

        xvals = x;
        xargs = num2cell(xvals);

        w = v;
        v = double(F(xargs{:}));

        y = v-w;

        z = -A*y;

        p = -transpose(s)*z;

        u = transpose(s) * A;
        u = transpose(u);

        A = A + (1/p) * (s+z) * transpose(u);

        s = -A*v;
        x = x + s;

        norm_val = norm(s);

        k = k+1;
        
    end
        
    if k > N
        disp("Warning: max iterations reached")
    end
    
end
