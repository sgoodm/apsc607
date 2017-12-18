% class 2017-11-13

clear;

A = [
   1  1  0  3
   2  1 -1  1
   3 -1 -1  2
  -1  2  3 -1
];

b = [
 8
 7
 14
 7
];

[l,u] = LU_factorization(A);


