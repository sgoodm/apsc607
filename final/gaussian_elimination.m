% classwork 2017-11-06
% gaussian elimination with backwards substitution 
% page 364

function [E, x] = gaussian_elimination(aa)

    [n,nj] = size(aa);

    possible = perms(1:n);
    [perm_n, perm_j] = size(possible);
    p = perm_n;

    valid = false;
    while ~valid && p > 0
        set = possible(p, :);
        next = true;
        i = 1;
        while next && i <= n
            if aa(set(i), i) == 0
                next = false;
            end
            i = i + 1;
        end
        if next
            valid = true;
        end
        p = p - 1;
    end

    if ~valid
        error('Could not find suitable matrix');
    end

    % final a
    a = [];
    for i = 1:length(set)
        row = set(i);
        a(i,:) = aa(row, :);
    end

    % modified
    E = a;
    for i = 1:n-1
       for j = i+1:n
           E(i,:) = E(i,1:nj);
           m = E(j,i) / E(i,i);
           E(j,:) = E(j,:) - m * E(i,:);
       end
    end

    if E(n,n) == 0
        error('no unique solution exists');
    end
    
    x = [];

    for k = 1:nj-n
        x(k,n) = E(n,n+k) / E(n,n);
        for i = n-1:-1:1
            j = i+1:n;
            x(k,i) = (E(i,n+k) - sum(E(i,j).*x(k,j))) / E(i,i);
        end
    end
    x = transpose(x);
    
 end





