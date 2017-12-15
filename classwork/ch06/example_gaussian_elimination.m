% example gaussian elimiation

% classwork 2017-11-06
% gaussian elimination with backwards substitution 

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

[E1, x1]  = gaussian_elimination(aa);



% -----------------


bad_example_alt = [
    2   1  -1   1  ; 
    3  -1  -1   2  ; 
    1   1   0   3  ; 
   -1   2   3  -1  ;
];

good_example_alt = [
    1   1   0   3  ; 
    2   1  -1   1  ; 
    3  -1  -1   2  ; 
   -1   2   3  -1  ;
];


z0 = [1 3; 2 7];
% z0 = good_example_alt;
% z0 = bad_example_alt;

z1 = [z0 eye(size(z0, 1))];

[E2, x2] = gaussian_elimination(z1);

inv(z0)
x2



