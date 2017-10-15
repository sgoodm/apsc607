% class ?
% richardson's extrapolation



syms x
sym_f = x*exp(x);


f = matlabFunction(sym_f)
sym_f1 = diff(sym_f)

f1 = matlabFunction(sym_f1)

f = @(x) x*exp(x);
x0 = 2;

% second order
n1 = @(f, x0, h) (1/(2*h)) * (f(x0+h) - f(x0-h));

% fourth order
n2 = @(f, x0, h) n1(f, x0, h/2) + (1/3)*(n1(f, x0, h/2) - n1(f, x0, h));

% sixth order
n3 = @(f, x0, h) n2(f, x0, h/2) + (1/15)*(n2(f, x0, h/2) - n1(f, x0, h));


n1(f, x0, 0.05)
n2(f, x0, 0.1)
n3(f, x0, 0.2)



range = 0:h:2*pi;

slope = [];


count = length(range);
step_iter = 1:count; 
m = zeros(count, count);


for i=step_iter
   
    x0 = range(i);
    
    if x0 == min(range) || x0 == max(range)
        a = -3/(2*h);
        b = 4/(2*h);
        c = -1/(2*h);
        slope(i) = a * f(x0) + b * f(x0+h)  + c * f(x0+2*h);
    else
        a = -1/(2*h);
        b = 0;
        c = 1/(2*h);
        slope(i) = a * f(x0 - h) + b * f(x0) + c * f(x0 +h);
    end
    
    coef = [a b c];
    
    if i == 1
        col = 1;
    elseif i == count
        col = count - (length(coef)-1);
        coef = fliplr(coef);
    else 
        col = i - 1;
    end
    
    m(i, col:col+(length(coef)-1)) = coef;

           
end

true = f(range);

out = m * true.';


close all;
figure()
plot(range, true, 'r');
hold on;
plot(range, val, 'b');
plot(range, out, 'c--')
legend('Function', 'Slope Calc', 'Slope Matrix', 'Location', 'best');

