% cholesky (pg 418)
% factor the positive definite nxn matrix A into LLt, where L is lower triangular


function [l] = cholesky(a)
    n = size(a,1);
    l(1,1) = sqrt(a(1,1));
    for j = 2:n
        l(j,1) = a(j,1) / l(1,1);
    end
    
    for i = 2:n-1
        k = 1:i-1;
        l(i,i) = sqrt(a(i,i) - sum(l(i,k)^2));
    
        for j  = i+1:n
            k = 1:i-1;
            l(j,i) = (a(j,i) - sum( l(j,k)*l(i,k) ))/l(i,i);
        end

    end

    k = 1:n-1;
    l(n,n) = sqrt(a(n,n)-sum( l(n,k).^2 ));

end
