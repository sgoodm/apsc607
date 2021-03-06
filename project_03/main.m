% seth goodman
% apsc 607
% project 03

% clear workspace and figures
clear;
clf;
close all;

format long;


% set h values for testing
hlist = linspace(0.01, 0.1, 10);  

% define colormap for h value comparison plots
colors=hsv(length(hlist));

% plot colorbar for colormap
barsize = [500, 500, 800, 150];
plot_colorbar(barsize, 'Step Size Colormap', colors);
saveas(gcf, [pwd, '/output/colormap.png'], 'png');
   
% initialize true value output table
table_cols = {'Function', 'h', 't', 'true', 'euler', 'error1', 'rungekutta', 'error2', 'trapezoidal', 'error3'};
[tcx, tcy] = size(table_cols);
output = array2table(zeros(0, tcy));
output.Properties.VariableNames = table_cols;

% ----------------------------------------
% functions
%
% function definitions
% string used for symbolic to test true value
% ode handle and ode diff used for IVP method
%
% function names corresponsd to letter for each function
% on the assignment sheet (e.g. function "a" is `f_a`)

f_test = "5 * exp(5*t) * (y-t)^2 + 1";
fh_test = @(t, y) 5 * exp(5*t) * (y-t)^2 + 1;
fh_diff_test = @(t, y) -5*exp(5*t)*(2*t - 2*y);

f_a = "-9 * y";
fh_a = @(t, y) -9 * y;
fh_diff_a = @(t, y) -9;

f_b = "-20 * (y-t^2) + 2 * t";
fh_b = @(t, y) -20 * (y-t^2) + 2 * t;
fh_diff_b = @(t, y) -20;

% ----------------------------------------
% for task that needs to be run, define:
% function name, range min, range max, h, initial value

%   func   a    b    h      y(0) 
jobs = {
%     'test' 0    1    0.1    -1
    'a'    0    1    0.1    exp(1) 
    'b'    0    1    0.1     1/3   
};

% ----------------------------------------
% run

run_list = 1:size(jobs, 1);

hide_figures = 1;
run_hlist = 1;

for ix = run_list

    name = char(jobs(ix, 1));
    a = jobs{ix, 2};
    b = jobs{ix, 3};
    h_actual = jobs{ix, 4};
    y0 = jobs{ix, 5};
    
    disp(['Running ', name])

    fh = eval(['fh_', name]);
    fh_diff = eval(['fh_diff_', name]);

    f = eval(['f_', name]);
    syms y(t)
    sym_ode = eval(f);
    ode = diff(y,t) == sym_ode;
    cond = y(0) == y0;
    sym_ftrue = dsolve(ode, cond);
    fh_true = matlabFunction(sym_ftrue);
   
    figure()
    fplot(fh_true, [a b]);
    ylabel('y');
    xlabel('t');
    title(['True Function ' upper(name)])
    saveas(gcf, [pwd, '/output/', name, '_actual.png'], 'png');
    
    if run_hlist
        for hi = 1:length(hlist)
            h = hlist(hi);

            t = a:h:b;
            w0 = fh_true(t);

            w1 = taylor({fh}, 1, a, b, h, y0);
            e1 = abs(w0 - w1);

            w2 = rungekutta(fh, a, b, h, y0);
            e2 = abs(w0 - w2);

            TOL = 1e-6;
            M = 10;
            w3 = trapezoidal(fh, fh_diff, a, b, h, y0, TOL, M);    
            e3 = abs(w0 - w3);

            figure(ix*10+1)
            z = plot(t,w1, 'color', colors(hi,:));
            uistack(z, 'bottom');
            hold on

            figure(ix*10+2)     
            z = plot(t,e1, 'color', colors(hi,:));
            uistack(z, 'bottom');
            set(gca, 'YScale', 'log');
            hold on

            figure(ix*10+3)     
            z = plot(t,w2, 'color', colors(hi,:));
            uistack(z, 'bottom');
            hold on

            figure(ix*10+4)     
            z= plot(t,e2, 'color', colors(hi,:));
            uistack(z, 'bottom');
            set(gca, 'YScale', 'log');
            hold on

            figure(ix*10+5)     
            z = plot(t,w3, 'color', colors(hi,:));
            uistack(z, 'bottom');
            hold on

            figure(ix*10+6)     
            z = plot(t,e3, 'color', colors(hi,:));
            uistack(z, 'bottom');
            set(gca, 'YScale', 'log');
            hold on

        end

        figure(ix*10+1)
        ylabel('w');
        xlabel('t');
        title(['Euler (' upper(name) ') - Step Size Comparison (estimate)'])
        saveas(gcf, [pwd, '/output/', name, '_euler_h_val.png'], 'png');
        figure(ix*10+2)  
        ylabel('e');
        xlabel('t');
        ylim([1e-10 1]);
        title(['Euler (' upper(name) ') - Step Size Comparison (error)'])
        saveas(gcf, [pwd, '/output/', name, '_euler_h_err.png'], 'png');
        figure(ix*10+3)
        ylabel('w');
        xlabel('t');
        title(['Runge-Kutta (' upper(name) ') - Step Size Comparison (estimate)'])
        saveas(gcf, [pwd, '/output/', name, '_rk_h_val.png'], 'png');
        figure(ix*10+4)  
        ylabel('e');
        xlabel('t');
        ylim([1e-10 1]);
        title(['Runge-Kutta (' upper(name) ') - Step Size Comparison (error)'])
        saveas(gcf, [pwd, '/output/', name, '_rk_h_err.png'], 'png');
        figure(ix*10+5)
        ylabel('w');
        xlabel('t');
        title(['Implicit (' upper(name) ') - Step Size Comparison (estimate)'])
        saveas(gcf, [pwd, '/output/', name, '_implicit_h_val.png'], 'png');
        figure(ix*10+6)  
        ylabel('e');
        xlabel('t');
        ylim([1e-10 1]);
        title(['Implicit (' upper(name) ') - Step Size Comparison (error)'])
        saveas(gcf, [pwd, '/output/', name, '_implicit_h_err.png'], 'png');
    end

    h = h_actual;
    t = a:h:b;
    w0 = fh_true(t);

    w1 = taylor({fh}, 1, a, b, h, y0);
    e1 = abs(w0 - w1);

    w2 = rungekutta(fh, a, b, h, y0);
    e2 = abs(w0 - w2);

    TOL = 1e-6;
    M = 10;
    w3 = trapezoidal(fh, fh_diff, a, b, h, y0, TOL, M);    
    e3 = abs(w0 - w3);

    
    figure();
    fplot(fh_true, [a b], 'k');
    hold on
    plot(t, w1, 'b-o');
    plot(t, w2, 'm-o');
    plot(t, w3, 'r-o');

    ylabel('w');
    xlabel('t');
    legend('True', 'Euler', 'Runge-Kutta', 'Implicit Trapezoidal', 'Location', 'north');
    title(['Function ' upper(name) ' - Approximation']);
    saveas(gcf, [pwd, '/output/', name, '_compare_val.png'], 'png');

    
    figure();
    plot(t, e1, 'b-o');
    hold on
    plot(t, e2, 'm-o');
    plot(t, e3, 'r-o');
    set(gca, 'YScale', 'log');

    ylabel('e');
    xlabel('t');
    legend('Euler', 'Runge-Kutta', 'Implicit Trapezoidal', 'Location', 'south');
    title(['Function ' upper(name) ' - Error']);
    saveas(gcf, [pwd, '/output/', name, '_compare_err.png'], 'png');
    
    % add output from task to table
    for j = 1:length(t)
        new_rows = {...
            name, num2str(h, 3), num2str(t(j), 3), num2str(w0(j), 8), ...
            num2str(w1(j), 8), num2str(e1(j), 8), ...
            num2str(w2(j), 8), num2str(e2(j), 8), ...
            num2str(w3(j), 8), num2str(e3(j), 8);
        };
        output = [output; new_rows];
    end
    
end

if hide_figures
    close all;
end

writetable(output, [pwd, '/output/output_table.csv']);
