% seth goodman
% apsc 607
% project 01

% clear workspace and figures
clear;
clf;
close all;

format long;

% set to true/false or 1/0 to show/hide figure windows
hide_figures = 1;

% verbose output 
% bool val
% true displays additional steps/info from method functions, etc.
v = 0;


% maximum number of iterations to run
nmax = 500;

% define tolerances which will be used
tol_a = '1E-3';
tol_b = '1E-5';
tol_c = '1E-8';

% for task that needs to be run
% define the function name, range min, range max
% (functions which have multiple ranges will be used in multiple tasks)
jobs = {...
    'a', 'a', 1, 2, -999;
    'b', 'b', 1.3, 2, -999;
    'c1', 'c', 2, 3, 2.37;
    'c2', 'c', 3, 4, -999;
    'd1', 'd', 1, 2, -999;
    'd2', 'd', exp(1), 4, -999;
    'e1', 'e', 0, 1, 0.5;
    'e2', 'e', 3, 5, -999;
    'f1', 'f', 0, 1, -999;
    'f2', 'f', 3, 4, -999;
    'f3', 'f', 6, 7, -999;
};


% ----------------------------------------
% functions
%
% function names corresponsd to letter for each function
% on the assignment sheet (e.g. function a is 'fa' and
% the derivative of function 'fa' is 'fa_prime'

fa = @(x) exp(x) + 2.^-x + 2*cos(x)-6;
fa_prime = @(x) exp(x) - (2.^-x)*log(2) - 2*sin(x);

fb = @(x) log(x-1) + cos(x-1);
fb_prime = @(x) 1/(x-1) + sin(1-x);

fc = @(x) 2*x*cos(2*x) - (x-2).^2;
fc_prime = @(x) 2*cos(2*x) - 2*x*sin(2*x) - 2*(x-2);

fd = @(x) (x-2).^2 - log(x);
fd_prime = @(x) 2*(x-2) - 1/x;

fe = @(x) exp(x) - 3*x.^2;
fe_prime = @(x) exp(x) - 6*x;

ff = @(x) sin(x) - exp(-x);
ff_prime = @(x) cos(x) + exp(-x);


% ----------------------------------------
% run

% initialize final output table
table_cols = {'Name', 'Function', 'Method', 'Tolerance', 'rmin', 'rmax', 'N', 'p', 'Max_Error', 'Status'};
[tcx, tcy] = size(table_cols);
results = array2table(zeros(0, tcy));
results.Properties.VariableNames = table_cols;

% use row size of 'jobs' to iterate over all tasks
[rows, cols] = size(jobs);

for ix = 1:tcy+1

    unique_name = char(jobs(ix, 1));
    name = char(jobs(ix, 2));
    display_name = upper(name);
    
    disp(['Running ', unique_name])
    
    % get the relevant functions for current task
    f_name = ['f', name];
    fprime_name = ['f', name, '_prime'];

    fh = eval(f_name);
    fh_prime = eval(fprime_name);

    % set figure numbers based on row
    % example: row 1 will start with figure 101,
    % row 8 will start with figure 801, etc.
    figure_ix = ix * 100;

    % get range min and max for task
    rmin = jobs{ix, 3};
    rmax = jobs{ix, 4};
    
    newton_start = jobs{ix, 5};
    if newton_start == -999
        newton_start = rmin; 
    end

    % ----------------------------------------

    % actual
    figure(figure_ix);
    fplot(fh, [rmin-2 rmax+2]);
    zval = fzero(fh, [rmin rmax]);
    hline = refline([0 0]);
    hline.Color = 'r';
    title(['Function ', display_name ,', ' num2str(rmin), ':', num2str(rmax), ' (root = ', num2str(zval, 10), ')']);
    saveas(gcf, [pwd, '/output/', unique_name, '_', 'actual'], 'png')
    
    % run bisection
    fig_num = figure_ix + 1;
    fig_b = figure(fig_num);
    [i1b, p1b, d1b, s1b] = bisection(fh, str2double(tol_a), nmax, rmin, rmax, 'b', 1, v);
    [i2b, p2b, d2b, s2b] = bisection(fh, str2double(tol_b), nmax, rmin, rmax, 'c--', 1, v);
    [i3b, p3b, d3b, s3b] = bisection(fh, str2double(tol_c), nmax, rmin, rmax, 'mo', 0.001, v);

    subplot(1,2,1);
    title('p');
    hline = refline([0 zval]);
    hline.Color = 'r';
    hline.LineStyle = ':';
    uistack(hline, 'bottom');
    subplot(1,2,2);
    title('error');

    lgd = legend(...
        [tol_a, '   ', num2str(i1b), '   ', num2str(p1b, 8), '   ', num2str(d1b, 8)], ...
        [tol_b, '   ', num2str(i2b), '   ', num2str(p2b, 8), '   ', num2str(d2b, 8)], ...
        [tol_c, '   ', num2str(i3b), '   ', num2str(p3b, 8), '   ', num2str(d3b, 8)], ...
    'Location', 'northeast');
    lgd.Title.String = 'Plot   Tol  Iter      final p         final diff       ';

    suptitle(['Function ', unique_name, ' - Bisection (Range = ', num2str(rmin), ':', num2str(rmax), ')']);

    set(gcf, 'Position', [0, 1200, 1200, 500])
    saveas(gcf, [pwd, '/output/', unique_name, '_', 'bisetion'], 'png')


    % run newton
    fig_num = figure_ix + 2;
    figure(fig_num);
    [i1n, p1n, d1n, s1n] = newton(fh, str2double(tol_a), nmax, newton_start, fh_prime, 'b', 1, v);
    [i2n, p2n, d2n, s2n] = newton(fh, str2double(tol_b), nmax, newton_start, fh_prime, 'c--', 1, v);
    [i3n, p3n, d3n, s3n] = newton(fh, str2double(tol_c), nmax, newton_start, fh_prime, 'mo', 0.001, v);

    subplot(1,2,1);
    title('p');
    hline = refline([0 zval]);
    hline.Color = 'r';
    hline.LineStyle = ':';
    uistack(hline, 'bottom');
    subplot(1,2,2);
    title('error');

    lgd = legend(...
        [tol_a, '   ', num2str(i1n), '   ', num2str(p1n, 8), '   ', num2str(d1n, 8)], ...
        [tol_b, '   ', num2str(i2n), '   ', num2str(p2n, 8), '   ', num2str(d2n, 8)], ...
        [tol_c, '   ', num2str(i3n), '   ', num2str(p3n, 8), '   ', num2str(d3n, 8)], ...
    'Location', 'northeast');
    lgd.Title.String = 'Plot   Tol  Iter      final p         final diff       ';

    suptitle(['Function ', unique_name, ' - Newton (Range = ', num2str(rmin), ':', num2str(rmax), ')']);
    set(gcf, 'Position', [0, 1200, 1200, 500])
    saveas(gcf, [pwd, '/output/', unique_name, '_', 'newton'], 'png')

    % run secant
    fig_num = figure_ix + 3;
    figure(fig_num);
    [i1s, p1s, d1s, s1s] = secant(fh, str2double(tol_a), nmax, rmin, rmax, 'b', 1, v);
    [i2s, p2s, d2s, s2s] = secant(fh, str2double(tol_b), nmax, rmin, rmax, 'c--', 1, v);
    [i3s, p3s, d3s, s3s] = secant(fh, str2double(tol_c), nmax, rmin, rmax, 'mo', 0.001, v);

    subplot(1,2,1);
    title('p');
    hline = refline([0 zval]);
    hline.Color = 'r';
    hline.LineStyle = ':';
    uistack(hline, 'bottom');
    subplot(1,2,2);
    title('error');

    lgd = legend(...
        [tol_a, '   ', num2str(i1s), '   ', num2str(p1s, 8), '   ', num2str(d1s, 8)], ...
        [tol_b, '   ', num2str(i2s), '   ', num2str(p2s, 8), '   ', num2str(d2s, 8)], ...
        [tol_c, '   ', num2str(i3s), '   ', num2str(p3s, 8), '   ', num2str(d3s, 8)], ...
    'Location', 'northeast');
    lgd.Title.String = 'Plot   Tol  Iter      final p         final diff       ';

    suptitle(['Function ', unique_name, ' - Secant (Range = ', num2str(rmin), ':', num2str(rmax), ')']);
    set(gcf, 'Position', [0, 1200, 1200, 500])
    saveas(gcf, [pwd, '/output/', unique_name, '_', 'secant'], 'png')

    % ----------------------------------------

    % add output from task to table
    new_rows = {...
        unique_name, display_name, 'bisection', tol_a, rmin, rmax, num2str(i1b), num2str(p1b, 8), num2str(d1b, 8), s1b;
        unique_name, display_name, 'bisection', tol_b, rmin, rmax, num2str(i2b), num2str(p2b, 8), num2str(d2b, 8), s2b;
        unique_name, display_name, 'bisection', tol_c, rmin, rmax, num2str(i3b), num2str(p3b, 8), num2str(d3b, 8), s3b;
        unique_name, display_name, 'newton', tol_a, rmin, rmax, num2str(i1n), num2str(p1n, 8), num2str(d1n, 8), s1n;
        unique_name, display_name, 'newton', tol_b, rmin, rmax, num2str(i2n), num2str(p2n, 8), num2str(d2n, 8), s2n;
        unique_name, display_name, 'newton', tol_c, rmin, rmax, num2str(i3n), num2str(p3n, 8), num2str(d3n, 8), s3n;
        unique_name, display_name, 'secant', tol_a, rmin, rmax, num2str(i1s), num2str(p1s, 8), num2str(d1s, 8), s1s;
        unique_name, display_name, 'secant', tol_b, rmin, rmax, num2str(i2s), num2str(p2s, 8), num2str(d2s, 8), s2s;
        unique_name, display_name, 'secant', tol_c, rmin, rmax, num2str(i3s), num2str(p3s, 8), num2str(d3s, 8), s3s;
    };
    results = [results; new_rows];

    if hide_figures
        close all;
    end

end

disp(results);
writetable(results, [pwd, '/output/output_table.csv']);


