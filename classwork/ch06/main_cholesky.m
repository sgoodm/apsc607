

a = [
    4  -1 1
   -1   4.25   2.75
    1   2.75   3.5
];

[l] = cholesky(a);

l

l'

isequal(a, l*l')


