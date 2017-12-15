% class 20171009

f = @(x) cos(x);

h = 0.1;

range = 0:h:2*pi;

slope = [];


count = length(range);
step_iter = 1:count; 
m = zeros(count, count);
p = 5;

for i=step_iter
   
    x0 = range(i);
    
    if x0 == min(range) || i + p > count
        a = -25/(12*h);
        b = 48/(12*h);
        c = -36/(12*h);
        d = 16/(12*h);
        e = -3/(12*h);
        slope(i) = a * f(x0) + b * f(x0+h) + c * f(x0+2*h) + d * f(x0+3*h) + e * f(x0+4*h);
    else
        a = 1/(12*h);
        b = -8/(12*h);
        c = 0;
        d = 8/(12*h);
        e = -1/(12*h);
        slope(i) = a * f(x0 - 2*h) + b * f(x0 - h) + c * f(x0) + d * f(x0 +h) + e * f(x0 +2*h);
    end
    
    coef = [a b c d e];
    
    if i == 1
        col = i;
    elseif i + length(coef) > count
        col = count - (length(coef));
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











