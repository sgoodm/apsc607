% LDLt factorization
% class 2017-11-13

clear;

% function [] = LDLt_factorization(A)

A = [
   4 -1     1
  -1  4.25  2.75
   1  2.75  3.5
];

l = [
   1     0     0
  -0.25  1     0
   0.25  0.75  1
];

d = [4 4 1];

n = length(A);
a = A;
v = [];

for i = 1:n
    for j = 1:i-1
%         v(j) = l(i,j) * d(j);
        disp(l(i,j));
        disp(d(j));
    end    
    aaaa
    j = 1:i-1;
    d(i) = a(i,i) - sum(l(i,j)*v(j));
    
    for j= i+1:n
        k = 1:i-1;
      1:  l(j,I) = ( a(j,i) - sum(l(j,k)*v(k)) ) / d(i);
    end
    
end
