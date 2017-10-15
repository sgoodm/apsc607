% class 20170925
% Lagrange interpolation

format long;

% ----------------------------------------
% inputs

% function
fa = @(x) 1./x;

% value to approximate
x = 3;

% list of nodes
nodes = [2, 2.75, 4];

% ----------------------------------------
% run

xvals = 2:.1:5;

i = 0;
for x = xvals
    i = i+1;
    out(i) = lagrange(fa, x, nodes);
    error(i) = abs(fa(x) - out(i));
end

xaxis_range = [min(xvals)*0.9, max(xvals)*1.1];

% true function
figure(1);
suptitle({'Lagrange Interpolation', '', ''});


subplot(2,1,1)
fplot(fa, xaxis_range, 'b--');
hold on

% plot estimation over range
plot(xvals, out, 'Linewidth', 2);

% nodes_y = fa(nodes);
% plot(nodes, nodes_y, 'mo');

for n = nodes
    h = line([n n], get(gca, 'ylim'));
    h.Color = 'm';
end

title('Approximation')

lgd = legend(...
    'actual', 'approximated', 'nodes', ...
    'Location', 'northeast');


% plot error over range
subplot(2,1,2);
plot(xvals, error);
hold on

ax = gca;
ax.XLim = xaxis_range;

for n = nodes
    h = line([n n], get(gca, 'ylim'));
    h.Color = 'm';
end

title('Error');

lgd = legend(...
    'error', 'nodes', ...
    'Location', 'northeast');

% ---------------

x = [1, 1.3, 1.6, 1.9, 2.2];
y = [0.7651977, 0.6200860, 0.4554022, 0.2818186, 0.1103623];
Q = neville(1.5, x, y, 1);


