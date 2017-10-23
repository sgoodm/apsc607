% seth goodman
% apsc 607
% project 02

% clear workspace and figures
% clear;
% clf;
close all;

format long;

% define tolerances which will be used
tol_a = '1E-4';
tol_b = '1E-8';

% for task that needs to be run
% define the function name, range min, range max
% (functions which have multiple ranges will be used in multiple tasks)

%   name    func    a   b  
jobs = {...
    'a',    'a',    0,  2   ;
    'b',    'b',    0,  2   ;
};


% ----------------------------------------
% functions
%
% function names corresponsd to letter for each function
% on the assignment sheet (e.g. function a is 'fa')

syms x

sym_fa = exp(2*x) + sin(3*x);

sym_fb = 1 / (x+4);


% ----------------------------------------
% run

run_list = 1:size(jobs, 1);

for ix = run_list

    unique_name = char(jobs(ix, 1));
    name = char(jobs(ix, 2));
    display_name = upper(name);

    disp(['Running ', unique_name])

    % get range min and max for task
    rmin = jobs{ix, 3};
    rmax = jobs{ix, 4};

    % prepare functions
    sym_f_name = ['sym_f', name];
    fsym = eval(sym_f_name);     
    fh = matlabFunction(fsym);

    % check true value using symbol `int` function
    raw_sym_val = int(fsym, rmin, rmax);
    true_sym_val = double(raw_sym_val);

    % check true value using numerical `integral` function
    true_num_val = integral(fh, rmin, rmax);

    figure();
    fplot(fh, [rmin rmax]);

    title(['Function ' display_name ' - Actual Function']);
    saveas(gcf, [pwd, '/output/', unique_name, '_actual'], 'png');
    
    % ----------------------------------------
    
    nlist = 2:2:100000;

    % --------------------

    [tval, th] = arrayfun(@(n) trapezoidal(fh, n, rmin, rmax), nlist);
    terr = abs(true_num_val - tval);

    figure();
    plot(nlist, terr);
    set(gca, 'YScale', 'log');
    
    ylabel('Error (log scale)');
    xlabel('N');
    title(['Function ' display_name ' - Composite Trapezoidal Rule']);
    saveas(gcf, [pwd, '/output/', unique_name, '_trapezoidal'], 'png');

    % --------------------
    
    [mval, mh] = arrayfun(@(n) midpoint(fh, n, rmin, rmax), nlist);
    merr = abs(true_num_val - mval);

    figure();
    plot(nlist, merr);
    set(gca, 'YScale', 'log');
        
    ylabel('Error (log scale)');
    xlabel('N');
    title(['Function ' display_name ' - Composite Midpoint Rule']);
    saveas(gcf, [pwd, '/output/', unique_name, '_midpoint'], 'png');

    % --------------------
    
    [sval, sh] = arrayfun(@(n) simpsons(fh, n, rmin, rmax), nlist);
    serr = abs(true_num_val - sval);

    figure();
    plot(nlist, serr);
    set(gca, 'YScale', 'log');
    
    ylabel('Error (log scale)');
    xlabel('N');
    title(['Function ' display_name ' - Composite Simpsons Rule']);
    saveas(gcf, [pwd, '/output/', unique_name, '_simpsons'], 'png');

    % --------------------

    [aval, aout] = adaptive_simpsons(fh, rmin, rmax, 1E-4);
    aerr = abs(true_num_val - aval);
    
    figure();
    fplot(fh, [rmin rmax]);
    hold on;
    s = stem(aout, fh(aout));
    xticks(rmin:0.5:rmax);
    set(s,'MarkerFaceColor','r','MarkerSize',0.001);

    title(['Function ' display_name ' - Adaptive Simpsons Rule A']);
    saveas(gcf, [pwd, '/output/', unique_name, '_adaptive_simpsons_a'], 'png');

     % --------------------

    [aval, aout] = adaptive_simpsons(fh, rmin, rmax, 1E-8);
    aerr = abs(true_num_val - aval);
    
    figure();
    fplot(fh, [rmin rmax]);
    hold on;
    s = stem(aout, fh(aout));
    xticks(rmin:0.5:rmax);
    set(s,'MarkerFaceColor','r','MarkerSize',0.001);

    title(['Function ' display_name ' - Adaptive Simpsons Rule B']);
    saveas(gcf, [pwd, '/output/', unique_name, '_adaptive_simpsons_b'], 'png');

end


