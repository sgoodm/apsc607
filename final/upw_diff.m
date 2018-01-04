function [y] = upw_diff(h,p,q,r,N,alpha,beta)
%%% Upwind difference method A(NxN)
% INPUT:
% h = step size
% p,q,r functions based on linear differential equation y'' = py'+ qy + r
% N = amount of steps (and size of matrix)
% alpha : y(a) = alpha
% beta : y(b) = beta

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create diagonal elements 

% Diagonal

d = 2 * h^2 * q + 4 - 3*h*p;
A = diag(d);

% Diagonal - 1
for i = 2:N
    A(i, i-1) = -1;
end

% Diagonal + 1
for i = 1:N-1
    A(i, i+1) = -2 + 4*h*p(i);
end

% Diagonal + 2
for i = 1:N-2
    A(i, i+2) = -h*p(i);
end

% Solution vector b


b(1) = -2*h^2*r(1) + 1*alpha;
for i = 2:N-1
    b(i) = -2*h^2 * r(i);
end
b(N-1) = -2*h^2*r(N) + (2-4*h*p(N-1))*beta; 
b(N) = -2*h^2*r(N) + (h*p(N))*beta;

b=b';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve linear system

% Use your own developed Matlab code, or use the build in Matlab function
% (but less points will be given for using build-in Matlab)

% A1 = [A eye(size(A, 1))];
% [A2, x2] = gaussian_elimination(A1);

% Make the full length y solution by including the boundary values.
y = inv(A)*b;

end