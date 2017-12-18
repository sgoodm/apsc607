% class 2017-11-13

clear;

A = [
   4 -1     1
  -1  4.25  2.75
   1  2.75  3.5
];


lx = [
   1     0     0
  -0.25  1     0
   0.25  0.75  1
];

dx = [4 4 1];


[L,D] = ldl(A);


[l,d] = LDLt_factorization(A);


