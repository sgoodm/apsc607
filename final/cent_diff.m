function [y,A] = cent_diff(h,p,q,r,N,alpha,beta)
%%% Central difference method
% INPUT:
% h = step size
% p,q,r functions based on linear differential equation y'' = py'+ qy + r
% N = amount of steps (and size of matrix)
% alpha : y(a) = alpha
% beta : y(b) = beta

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create diagonal elements

% Diagonal

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

b(1) = -h^2*r(1) + (1+0.5*h*p(1))*alpha;
for i = 2:N-1
    b(i) = -h^2 * r(i);
end
b(N) = -h^2*r(N) + (1-0.5*h*p(N))*beta;

b=b';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve linear system

% Use your own developed Matlab code, or use the build in Matlab function
% (but less points will be given for using build-in Matlab)

% A1 = [A eye(size(A, 1))];
% [A2, x2] = gaussian_elimination(A1);


% Make the full length y solution by including the boundary values.
y = inv(A) * b;

end

