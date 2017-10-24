% seth goodman
% apsc 607
% project 02

% clear workspace and figures
% clear;
% clf;
close all;

format long;


% for task that needs to be run, define:
% display name, function name, range min, range max
% expanded range min and max (for visualizing broader function)
% nfactor, used when generating vector of n values for testing

%   name   func   a    b    a2   b2    nfactor
jobs = {...
    'a'    'a'    0    2    -2    3    16;
    'b'    'b'    0    2    -4    2    10;
};


% ----------------------------------------
% functions
%
% symbolic function definitions
% used for testing true integral values and creating
% normal function handles for testing integration rules
%
% function names corresponsd to letter for each function
% on the assignment sheet (e.g. function a is 'sym_fa')

syms x

sym_fa = exp(2*x) * sin(3*x);

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

    % plot function over range being examined
    figure();
    fplot(fh, [rmin rmax]);
    title(['Function ' display_name ' - Actual Function']);
    saveas(gcf, [pwd, '/output/', unique_name, '_actual'], 'png');

    % plot function over expanded range 
    % (used to determine if adaptive methods could be useful outside range
    % tested)
    figure();
    rmin_alt = jobs{ix, 5};
    rmax_alt = jobs{ix, 6};
    fplot(fh, [rmin_alt rmax_alt]);
    title(['Function ' display_name ' - Expanded Actual Function']);
    saveas(gcf, [pwd, '/output/', unique_name, '_expanded_actual'], 'png');
    
    % ----------------------------------------
    % trapezoidal rule
    
    % generate nlist based on a binary expansion for efficient sampling
    bint = jobs{ix, 7};
    nlist = 0.5 .* 2.^(1:bint);
    nlist = nlist + 2.^(1:bint) ;
    nlist = sort(horzcat(2.^(1:bint), nlist(2:end)));
    
    
    [tval, th] = arrayfun(@(n) trapezoidal(fh, n, rmin, rmax), nlist);
    terr = abs(true_num_val - tval); 
    
    nstep = nlist(2)-nlist(1);
    t_iter_8 = nlist(1) + nstep * (sum(terr > 1e-4)-1);
    t_iter_4 = nlist(1) + nstep * (sum(terr > 1e-8)-1);
    t_min_err = terr(length(terr));
    
    % plot error
    figure();
    plot(nlist, terr);
    set(gca, 'YScale', 'log');
    ylabel('Error (log scale)');
    xlabel('N');
    title(['Function ' display_name ' - Composite Trapezoidal Rule']);
    saveas(gcf, [pwd, '/output/', unique_name, '_trapezoidal'], 'png');

    % ----------------------------------------
    % midpoint rule
    
    % uses same nlist as trapezoidal
    
    [mval, mh] = arrayfun(@(n) midpoint(fh, n, rmin, rmax), nlist);
    merr = abs(true_num_val - mval);

    % plot error
    figure();
    plot(nlist, merr);
    set(gca, 'YScale', 'log');   
    ylabel('Error (log scale)');
    xlabel('N');
    title(['Function ' display_name ' - Composite Midpoint Rule']);
    saveas(gcf, [pwd, '/output/', unique_name, '_midpoint'], 'png');

    % ----------------------------------------
    % simpsons rules
    
    % uses different nlist due to effectiveness of simpsons rules
    nlist = 2:10:2000;
    
    [sval, sh] = arrayfun(@(n) simpsons(fh, n, rmin, rmax), nlist);
    serr = abs(true_num_val - sval);

    % plot error
    figure();
    plot(nlist, serr);
    set(gca, 'YScale', 'log');
    ylabel('Error (log scale)');
    xlabel('N');
    title(['Function ' display_name ' - Composite Simpsons Rule']);
    saveas(gcf, [pwd, '/output/', unique_name, '_simpsons'], 'png');

    % ----------------------------------------
    % adaptive simpsons, tol=1e-4

    [a4val, a4out, h4out] = adaptive_simpsons(fh, rmin, rmax, 1E-4);
    a4err = abs(true_num_val - a4val);
    
    % plot adaptive h splits
    figure();
    fplot(fh, [rmin rmax]);
    hold on;
    s = stem(a4out, fh(a4out));
    xticks(rmin:0.5:rmax);
    set(s,'MarkerFaceColor','r','MarkerSize',0.001);
    title(['Function ' display_name ' - Adaptive Simpsons Rule @ 1e-4']);
    saveas(gcf, [pwd, '/output/', unique_name, '_adaptive_simpsons_4'], 'png');

    % --------------------
    % adaptive simpsons, tol=1e-8

    [a8val, a8out, h8out] = adaptive_simpsons(fh, rmin, rmax, 1E-8);
    a8err = abs(true_num_val - a8val);
    
    % plot adaptive h splits
    figure();
    fplot(fh, [rmin rmax]);
    hold on;
    s = stem(a8out, fh(a8out));
    xticks(rmin:0.5:rmax);
    set(s,'MarkerFaceColor','r','MarkerSize',0.001);
    title(['Function ' display_name ' - Adaptive Simpsons Rule @ 1e-8']);
    saveas(gcf, [pwd, '/output/', unique_name, '_adaptive_simpsons_8'], 'png');

end

