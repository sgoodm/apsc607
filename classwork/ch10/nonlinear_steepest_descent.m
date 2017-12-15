% class 2017-11-27
% steepest descent
% page 658

function [x] = nonlinear_steepest_descent(F, x0_vals, N, TOL)

    xvals = x0_vals;
    x = transpose(xvals);

    J = jacobian(F);

    k = 1;

    complete = 0;
    tol_check = TOL + 1;

    while k <= N && tol_check > TOL && complete == 0

        xvals = x;
        xargs = num2cell(xvals);

        J1 = double(J(xargs{:}));
        F1 = double(F(xargs{:}));

        g1 = sum(F1.^2);
        z = 2 * transpose(J1) * F1;
        z0 = norm(z);

        if z0 == 0
            complete = 1;
            disp("Zero gradient");

        else
            z = z / z0;
            a1 = 0;

            a3 = 1;     
            args = num2cell(x - a3.*z);
            F2 = double(F(args{:}));
            g3 = sum(F2.^2);

            while g3 >= g1 && complete == 0
                a3 = a3/2;
                args = num2cell(x - a3.*z);
                F3 = double(F(args{:}));
                g3 = sum(F3.^2);

                if a3 < TOL/2
                    complete = 1;
                    disp("No likely improvement");
                end
            end   

            if complete == 0
                a2 = a3/2;
                args = num2cell(x - a2.*z);
                F4 = double(F(args{:}));
                g2 = sum(F4.^2);

                h1 = (g2-g1)/a2;
                h2 = (g3-g2)/(a3-a2);
                h3 = (h2-h1)/a3;

                a0 = 0.5 * (a2 - h1/h3);
                args = num2cell(x - a0.*z);
                F5 = double(F(args{:}));
                g0 = sum(F5.^2);


                a = a0;
                args = num2cell(x - a.*z);
                F6 = double(F(args{:}));
                g = sum(F6.^2);

                if g ~= min(g0, g3)
                    a = a3;
                    args = num2cell(x - a.*z);
                    F7 = double(F(args{:}));
                    g = sum(F7.^2);
                end

                x = x - a.*z;

                if abs(g-g1) < TOL
                    disp("Procedure was successful");
                    complete = 1;
                end

                k = k+1;

            end

        end


    end

    if k > N
        disp("Warning: max iterations reached")
    end

end





