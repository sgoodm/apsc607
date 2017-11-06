% classwork 2017-11-06
% runge-kutta methods 

bad_example = [
    2   1  -1   1   1; 
    3  -1  -1   2  -3; 
    1   1   0   3   4; 
   -1   2   3  -1   4;
];

good_example = [
    1   1   0   3   4; 
    2   1  -1   1   1; 
    3  -1  -1   2  -3; 
   -1   2   3  -1   4;
];

% initial augmented a
aa = good_example;
[n,nj] = size(augmented_a);

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
x(n) = E(n,n+1) / E(n,n);

for i = n-1:-1:1
    j = i+1:n;
    x(i) = (E(i,n+1) - sum(E(i,j).*x(j))) / E(i,i);
end
    






