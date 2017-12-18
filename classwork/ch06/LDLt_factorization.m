% LDLt factorization
% class 2017-11-13
% page 417

function [L,D] = LDLt_factorization(A)
    n = size(A,1);
    L = zeros(n,n);

    v(1) = A(1,1);
    d(1) = v(1);
    L(2:n,1) = A(2:n,1) / v(1);  

    for i=2:n

        for j = 1:i-1
            v(j) = L(i,j) .* d(j);
        end
        j = 1:i-1;
        v(i) = A(i,i) - sum(L(i,j) * v(j)');
        d(i) = v(i);

        if (i < n)      
            j = i+1:n;
            k = 1:i-1;
            L(j,i) = (A(j,i) - L(j,k) * v(k)') / v(i);
        end
    end
    D = diag(d);
    L = L + eye(n);

end
