% class 20171002
% Cubic Spline



xvals = [0, 1, 2, 3];
yvals = [1, exp(1), exp(2), exp(3)];


f = @(x) exp(x);

n = 3;


for i = 1:length(x)-1
    a(i) = f(x(i));
    h(i) = x(i+1) - x(i);
end

for i = 2:length(x)-1
   alpha_a = (3/h(i)) * (a(i+1)-a(i));
   alpha_b = (3/h(i-1)) * (a(i) - a(i-1));
   alpha(i) =  alpha_a - alpha_b;
end

l(1) = 1;
u(1) = 0;
z(1) = 0;

for i = 2:n
    l(i) = 2*(x(i+1)-x(i-1)) - h(i-1)*u(i-1);
    u(i) = h(i) / l(i);
    z(i) = (alpha(i) - h(i-1)*z(i-1)) / l(i);
end

l(n+1) = 1;
z(n+1) = 0;
c(n+1) = 0;

for j = n:-1:1
    c(j) = z(j) - u(j)*c(j+1);

    b(j) = (a(j+1)-a(j))/h(j) - h(j)*(c(j+1) + 2*c(j))/3;
    d(j) = (c(j+1)-c(j))/(3*h(j));
end





% [a, b, c, d] = cubic_spline(f, n, xvals);


disp([length(xvals), length(a), length(b), length(c), length(d)])


x = 1;
% S = a + b.*(x - xvals) + c .* (x - xvals).^2 + d .* (x - xvals).^3;



