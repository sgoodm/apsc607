% LU factorization
% class 2017-11-13

function [l,u] = LU_factorization(A)

    if A(1,1) == 0
        error('Factorization impossible')
    end

    % condition
    % l(i,i) = 1;

    n = length(A);
    a = A;
    u(1,1) = a(1,1);
    l = diag(ones(1,n));

    for j = 2:n
        u(1,j) = a(1,j) / l(1,1);
        l(j,1) = a(j,1) / u(1,1);    
    end

    for i = 2:n-1
        k = 1:i-1;
        u(i,i) = a(i,i) - sum(l(i,k)*u(k,i)); 

        if u(i,i) == 0
            error('Factorization impossible')
        end

        for j = i+1:n
            u(i,j) = (1/l(i,i)) * ( a(i,j) - sum(l(i,k) * u(k,j)) );         
            l(j,i) = (1/u(i,i)) * ( a(j,i) - sum(l(j,k) * u(k,i)) );
        end
    end

    l(n,n) = 1;

    k = 1:n-1;
    u(n,n) = a(n,n) - sum(l(n,k) * u(k,n));

end

