% class ?
% richardson's extrapolation

format long;

syms x
sym_f = x*exp(x);

f = matlabFunction(sym_f);
sym_f1 = diff(sym_f);

f1 = matlabFunction(sym_f1);

% second order
n1 = @(f, x0, h) (1./(2.*h)) .* (f(x0+h) - f(x0-h));
% fourth order
n2 = @(f, x0, h) n1(f, x0, h./2) + (1./3).*(n1(f, x0, h./2) - n1(f, x0, h));
% sixth order
n3 = @(f, x0, h) n2(f, x0, h./2) + (1./15).*(n2(f, x0, h./2) - n2(f, x0, h));

h = 0.1;
range = 0:h:2*pi;

o2 = n1(f, range, h);
o4 = n2(f, range, h);
o6 = n3(f, range, h);

true_func = f(range);
true_diff = f1(range);

close all;
plot(range, true_func, 'r');
hold on;
plot(range, true_diff, 'g');
plot(range, o2, 'b--');
plot(range, o4, 'c--')
plot(range, o6, 'm--')
legend('True Func', 'True Diff', '2nd Order', '4th Order', '6th Order', 'Location', 'best');

figure()
plot(range, abs(true_diff-o2), 'b--');
hold on
plot(range, abs(true_diff-o4), 'c--')
plot(range, abs(true_diff-o6), 'm--')
legend('2nd Order Error', '4th Order Error', '6th Order Error', 'Location', 'best');
set(gca, 'YScale', 'log')




