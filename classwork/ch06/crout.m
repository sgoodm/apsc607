% crout (pg 422)


function [l,z,u,x] = crout(a)
    
    n = size(a,1);
    l(1,1) = a(1,1);
    u = eye(n);
    u(1,2) = a(1,2) / l(1,1);
    z(1) = a(1,n+1) / l(1,1);

    for i  = 2:n-1

        l(i,i-1) = a(i,i-1);
        l(i,i) = a(i,i) - l(i,i-1) * u(i-1,i);
        u(i,i+1) = a(i,i+1) / l(i,i);
        z(i) = (a(i,n+1) - l(i,i-1)*z(i-1)) / l(i,i);

    end

    l(n,n-1) = a(n,n-1); 
    l(n,n) = a(n,n) - l(n,n-1) * u(n-1,n);
    z(n) = (a(n,n+1) - l(n,n-1)*z(n-1)) / l(n,n);

    x(n) = z(n);
    for i=n-1:-1:1
        x(i) = z(i) - u(i,i+1) * x(i+1);
    end

end
