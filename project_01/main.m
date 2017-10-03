% seth goodman
% apsc 607
% project 01

% clear workspace and figures
clear;
clf;
close all;

format long;

% set to true/false or 1/0 to show/hide figure windows
hide_figures = 0;

% write (overwrite) CSV table
write_table = 0;

% verbose output
% bool val
% true displays additional steps/info from method functions, etc.
v = 0;

% maximum number of iterations to run
nmax = 300;

% define tolerances which will be used
tol_a_default = '1E-3';
tol_b_default = '1E-5';
tol_c_default = '1E-8';

tol_a_small = '1E-10';
tol_b_small = '1E-12';
tol_c_small = '1E-15';

% for task that needs to be run
% define the function name, range min, range max
% (functions which have multiple ranges will be used in multiple tasks)

%      name         func   rmin    rmax   p0
jobs = {...
    'a1',           'a',    1,      2,  1.65;
    'a1-default',   'a',    1,      2,  1;
    'a1-small',     'a',    1,      2,  1.65;
    'b1',           'b',    1.3,    2,  -999;
    'c1',           'c',    2,      3,  -999;
    'c2',           'c',    3,      4,  3.5;
    'c2-default',   'c',    3,      4,  3;
    'd1',           'd',    1,      2,  -999;
    'd2',           'd',    exp(1), 4,  -999;
    'e1',           'e',    0,      1,  0.5;
    'e1-default',   'e',    0,      1,  0;
    'e2',           'e',    3,      5,  -999;
    'f1',           'f',    0,      1,  -999;
    'f2',           'f',    3,      4,  -999;
    'f3',           'f',    6,      7,  -999;
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
fc_prime = @(x) 2*cos(2*x) - 4*x*sin(2*x) - 2*(x-2);

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


run_list = 1:length(jobs);
% run_list = 3;

for ix = run_list

    unique_name = char(jobs(ix, 1));
    name = char(jobs(ix, 2));
    display_name = upper(name);
    
    disp(['Running ', unique_name])
    
    tol_a = tol_a_default;
    tol_b = tol_b_default;
    tol_c = tol_c_default;

    if unique_name == "a1-small"
        tol_a = tol_a_small;
        tol_b = tol_b_small;
        tol_c = tol_c_small;  
    end
    

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
    % run methods
    
    % bisection
    [i1b, p1b, d1b, s1b, y1b, xp1b, xd1b] = bisection(fh, str2double(tol_a), nmax, rmin, rmax, v);
    [i2b, p2b, d2b, s2b, y2b, xp2b, xd2b] = bisection(fh, str2double(tol_b), nmax, rmin, rmax, v);
    [i3b, p3b, d3b, s3b, y3b, xp3b, xd3b] = bisection(fh, str2double(tol_c), nmax, rmin, rmax, v);

    % newton
    [i1n, p1n, d1n, s1n, y1n, xp1n, xd1n] = newton(fh, str2double(tol_a), nmax, newton_start, fh_prime, v);
    [i2n, p2n, d2n, s2n, y2n, xp2n, xd2n] = newton(fh, str2double(tol_b), nmax, newton_start, fh_prime, v);
    [i3n, p3n, d3n, s3n, y3n, xp3n, xd3n] = newton(fh, str2double(tol_c), nmax, newton_start, fh_prime, v);

    % secant
    [i1s, p1s, d1s, s1s, y1s, xp1s, xd1s] = secant(fh, str2double(tol_a), nmax, rmin, rmax, v);
    [i2s, p2s, d2s, s2s, y2s, xp2s, xd2s] = secant(fh, str2double(tol_b), nmax, rmin, rmax, v);
    [i3s, p3s, d3s, s3s, y3s, xp3s, xd3s] = secant(fh, str2double(tol_c), nmax, rmin, rmax, v);

    
    % ----------------------------------------
    % plot figures
    
    % actual/true function and root
    figure(figure_ix);
    
    fplot(fh, [rmin-2 rmax+2]);
    zval = fzero(fh, [rmin rmax]);
    hline = refline([0 0]);
    hline.Color = 'r';
    title(['Function ', display_name ,', ' num2str(rmin), ':', num2str(rmax), ' (root = ', num2str(zval, 10), ')']);
    saveas(gcf, [pwd, '/output/', unique_name, '_', 'actual'], 'png')

    
    % error comparison
    figure(figure_ix+1)
    
    eb = plot(y3b, max(1e-20, xd3b), 'b', 'Linewidth', 1);
    hold on
    en = plot(y3n, max(1e-20, xd3n), 'c', 'Linewidth', 1);
    es = plot(y3s, max(1e-20, xd3s), 'm', 'Linewidth', 1);

    hlines = [refline([0 str2double(tol_a)]), refline([0 str2double(tol_b)]), refline([0 str2double(tol_c)])];
    for hline = hlines
        hline.Color = 'r';
        hline.LineStyle = ':';
        uistack(hline, 'bottom');
    end
    
    legend([eb, en, es, hline], 'Bisection', 'Newton''s', 'Secant', [tol_a, ', ', tol_b, ', ', tol_c], 'Location', 'best');
    
    title([unique_name, ' - Error Comparison']);
    xlabel('Iterations');
    ylabel('Error (Log Scale)');
    set(gca, 'YScale', 'log')
    ylim([1E-15, 10])

    set(gcf, 'Position', [0, 1200, 1200, 500])
    saveas(gcf, [pwd, '/output/', unique_name, '_', 'error'], 'png')

    
    % bisection
    figure(figure_ix + 2);
    
    p1 = plot(y1b, xp1b, 'b', 'Linewidth', 1);
    hold on;
    p2 = plot(y2b, xp2b, 'c--', 'Linewidth', 1);
    p3 = plot(y3b, xp3b, 'mo', 'Linewidth', 1);
        
    hline = refline([0 zval]);
    hline.Color = 'r';
    hline.LineStyle = ':';
    uistack(hline, 'bottom');
    
    lgd = legend(...
        [p1, p2, p3], ...
        [tol_a, '   ', num2str(i1b), '   ', num2str(p1b, 8), '   ', num2str(d1b, 8)], ...
        [tol_b, '   ', num2str(i2b), '   ', num2str(p2b, 8), '   ', num2str(d2b, 8)], ...
        [tol_c, '   ', num2str(i3b), '   ', num2str(p3b, 8), '   ', num2str(d3b, 8)], ...
    'Location', 'best');
    lgd.Title.String = 'Plot   Tol  Iter      final p         final diff       ';

    title(['Function ', unique_name, ' - Bisection (Range = ', num2str(rmin), ':', num2str(rmax), ')']);
    xlabel('Iterations');
    ylabel('p Approximation');
    
    set(gcf, 'Position', [0, 800, 800, 500])
    saveas(gcf, [pwd, '/output/', unique_name, '_', 'bisetion'], 'png')
    
    
    % newton's
    figure(figure_ix + 3);
    
    p1 = plot(y1n, xp1n, 'b', 'Linewidth', 1);
    hold on;
    p2 = plot(y2n, xp2n, 'c--', 'Linewidth', 1);
    p3 = plot(y3n, xp3n, 'mo', 'Linewidth', 1);

    xlim([0, i3b])

    hline = refline([0 zval]);
    hline.Color = 'r';
    hline.LineStyle = ':';
    uistack(hline, 'bottom');
    
    lgd = legend(...
        [p1, p2, p3], ...
        [tol_a, '   ', num2str(i1n), '   ', num2str(p1n, 8), '   ', num2str(d1n, 8)], ...
        [tol_b, '   ', num2str(i2n), '   ', num2str(p2n, 8), '   ', num2str(d2n, 8)], ...
        [tol_c, '   ', num2str(i3n), '   ', num2str(p3n, 8), '   ', num2str(d3n, 8)], ...
    'Location', 'best');
    lgd.Title.String = 'Plot   Tol  Iter      final p         final diff       ';

    title(['Function ', unique_name, ' - Newton (Range = ', num2str(rmin), ':', num2str(rmax), ')']);
    xlabel('Iterations');
    ylabel('p Approximation');
    
    set(gcf, 'Position', [0, 800, 800, 500])
    saveas(gcf, [pwd, '/output/', unique_name, '_', 'newton'], 'png')

    
    % secant
    figure(figure_ix + 4);

    p1 = plot(y1s, xp1s, 'b', 'Linewidth', 1);
    hold on;
    p2 = plot(y2s, xp2s, 'c--', 'Linewidth', 1);
    p3 = plot(y3s, xp3s, 'mo', 'Linewidth', 1);
    
    xlim([0, i3b])

    hline = refline([0 zval]);
    hline.Color = 'r';
    hline.LineStyle = ':';
    uistack(hline, 'bottom');
    
    lgd = legend(...
        [p1, p2, p3], ...
        [tol_a, '   ', num2str(i1s), '   ', num2str(p1s, 8), '   ', num2str(d1s, 8)], ...
        [tol_b, '   ', num2str(i2s), '   ', num2str(p2s, 8), '   ', num2str(d2s, 8)], ...
        [tol_c, '   ', num2str(i3s), '   ', num2str(p3s, 8), '   ', num2str(d3s, 8)], ...
    'Location', 'best');
    lgd.Title.String = 'Plot   Tol  Iter      final p         final diff       ';

    title(['Function ', unique_name, ' - Secant (Range = ', num2str(rmin), ':', num2str(rmax), ')']);
    xlabel('Iterations');
    ylabel('p Approximation');
    
    set(gcf, 'Position', [0, 800, 800, 500])
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

% generate single true function plots across entire
% range for functions which have multiple ranges

figure(1);
fplot(fc, [2 4]);
hline = refline([0 0]);
hline.Color = 'r';
title('Function C');
saveas(gcf, [pwd, '/output/c_actual'], 'png')

figure(2);
fplot(fd, [1 4]);
hline = refline([0 0]);
hline.Color = 'r';
title('Function D');
saveas(gcf, [pwd, '/output/d_actual'], 'png')
    
figure(3);
fplot(fe, [0 4.5]);
hline = refline([0 0]);
hline.Color = 'r';
title('Function E');
saveas(gcf, [pwd, '/output/e_actual'], 'png')
    

figure(4);
fplot(ff, [0 7]);
hline = refline([0 0]);
hline.Color = 'r';
title('Function F');
saveas(gcf, [pwd, '/output/f_actual'], 'png')


if hide_figures
    close all;
end

disp(results);

if write_table
    writetable(results, [pwd, '/output/output_table.csv']);
end
