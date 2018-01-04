function [y] = cent_diff_v2(h,p,q,r,N,alpha,beta)
%%% Central difference method but for A(N+2xN+2) matrix
% INPUT:
% h = step size
% p,q,r functions based on linear differential equation y'' = py'+ qy + r
% N = amount of steps
% alpha : y(a) = alpha
% beta : y(b) = beta

p = horzcat([p(1)], p, [p(N)]);
q = horzcat([q(1)], q, [q(N)]);
r = horzcat([r(1)], r, [r(N)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create diagonal elements

% Diagonal

N = N+2;

d = 2 + h^2 * q;
A = diag(d);

% Diagonal - 1

for i = 2:N
    A(i, i-1) = -1 - 0.5*h*p(i);
end

% Diagonal + 1

for i = 1:N-1
    A(i, i+1) = -1 + 0.5*h*p(i);
end

% Solution vector b

for i = 1:N
    b(i) = -h^2 * r(i);
end

b=b';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve linear system

% Use your own developed Matlab code, or use the build in Matlab function
% (but less points will be given for using build-in Matlab)

% A1 = [A eye(size(A, 1))];
% [A2, x2] = gaussian_elimination(A1);

% Make the full length y solution by including the boundary values.
y = inv(A)*b;
y = y(2:N-1);

end

