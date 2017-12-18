% class 2017-12-04
% finite difference methods for linear problems
% page 687


function [x, w] = finite_difference(p, q, r, aa, bb, ya, yb, N)

    h = (bb-aa)/(N+1);

    x = aa + h;
    a(1) = 2 + h^2 * q(x);
    b(1) = -1 + (h/2) * p(x);
    d(1) = -h^2 * r(x) + (1 + (h/2)*p(x)) * ya;

    for i = 2:N-1
        x = aa + i*h;
        a(i) = 2 + h^2 * q(x);
        b(i) = -1 + (h/2)*p(x);
        c(i) = -1 - (h/2)*p(x);
        d(i) = -h^2 * r(x);
    end

    x = bb - h;
    a(N) = 2 + h^2 * q(x);
    c(N) = -1 - (h/2)*p(x);
    d(N) = -h^2 * r(x) + (1 - (h/2)*p(x)) * yb;

    l(1) = a(1);
    u(1) = b(1)/a(1);
    z(1) = d(1)/l(1);

    for i = 2:N-1
        l(i) = a(i) - c(i)*u(i-1);
        u(i) = b(i)/l(i);
        z(i) = (d(i)-c(i)*z(i-1)) / l(i);
    end

    l(N) = a(N) - c(N)*u(N-1);
    z(N) = (d(N)-c(N)*z(N-1)) / l(N);

    % w indexing off in book, need to check
    w(0+1) = ya;
    w(N+1+1) = yb;
    w(N+1) = z(N);

    for i = N:-1:2
        w(i) = z(i-1) - u(i-1)*w(i+1);
    end

    for i = 0:N+1
        x(i+1) = aa + i*h;  
    end

end

