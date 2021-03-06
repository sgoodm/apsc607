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

%   name   func   a    b    a2   b2 
jobs = {...
    'a'    'a'    0    2    -2    3   ;
    'b'    'b'    0    2    -4    2   ;
};


% initialize true value output table
table_cols = {'Function', 'Symbolic', 'Numeric'};
[tcx, tcy] = size(table_cols);
true_values = array2table(zeros(0, tcy));
true_values.Properties.VariableNames = table_cols;

table_cols = {'Function', 'Method', 'N4', 'N8', 'H4', 'H8', 'nmin', 'errmin'};
[tcx, tcy] = size(table_cols);
result_values = array2table(zeros(0, tcy));
result_values.Properties.VariableNames = table_cols;


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


    % add output from task to table
    new_rows = {...
        unique_name, num2str(true_sym_val, 15), num2str(true_num_val, 15);
    };
    true_values = [true_values; new_rows];

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
    
    if unique_name == 'a'
        bint = 16;
        nlist = 0.5 .* 2.^(1:bint);
        nlist = nlist + 2.^(1:bint) ;
        nlist = sort(horzcat(2.^(1:bint), nlist(2:end)));
    else
        nlist = 2:2:3000;
    end

    [tval, th] = arrayfun(@(n) trapezoidal(fh, n, rmin, rmax), nlist);
    terr = abs(true_num_val - tval); 
        
    t_iter_4 = sum(terr > 1e-4)+1;
    t_iter_8 = sum(terr > 1e-8)+1;
    t_min_err = terr(length(terr));
    
    % add output from task to table
    new_rows = {...
        unique_name, 'trapezoidal', num2str(nlist(t_iter_4), 15), num2str(nlist(t_iter_8), 15), num2str(th(t_iter_4), 15), num2str(th(t_iter_8), 15), num2str(max(nlist)), num2str(t_min_err, 15);
    };
    result_values = [result_values; new_rows];

    % plot error
    figure()
    plot(nlist, terr, 'm');
    hold on;

    % ----------------------------------------
    % midpoint rule
    
    % uses same nlist as trapezoidal
    
    [mval, mh] = arrayfun(@(n) midpoint(fh, n, rmin, rmax), nlist);
    merr = abs(true_num_val - mval);

    m_iter_4 = sum(merr > 1e-4)+1;
    m_iter_8 = sum(merr > 1e-8)+1;
    m_min_err = merr(length(merr));
    
    % add output from task to table
    new_rows = {...
        unique_name, 'midpoint', num2str(nlist(m_iter_4), 15), num2str(nlist(m_iter_8), 15), num2str(mh(m_iter_4), 15), num2str(mh(m_iter_8), 15), num2str(max(nlist)), num2str(m_min_err, 15);
    };
    result_values = [result_values; new_rows];

    % plot error
    plot(nlist, merr, 'c');


    hlines = [refline([0 10^-4]), refline([0 10^-8])];
    for hline = hlines
        hline.Color = 'r';
        hline.LineStyle = ':';
    end
    
    set(gca, 'YScale', 'log');
    ylabel('Error (log scale)');
    xlabel('N');
    legend('Trapezoidal', 'Midpoint');
    title(['Function ' display_name ' - Composite Trapezoidal/Midpoint Error']);
    saveas(gcf, [pwd, '/output/', unique_name, '_trapezoidal_midpoint'], 'png');

    % ----------------------------------------
    % simpsons rules
    
    nlist = 2:2:3000;
    
    [sval, sh] = arrayfun(@(n) simpsons(fh, n, rmin, rmax), nlist);
    serr = abs(true_num_val - sval);

    s_iter_4 = sum(serr > 1e-4)+1;
    s_iter_8 = sum(serr > 1e-8)+1;
    s_min_err = serr(length(serr));
    
    % add output from task to table
    new_rows = {...
        unique_name, 'simpsons', num2str(nlist(s_iter_4), 15), num2str(nlist(s_iter_8), 15), num2str(sh(s_iter_4), 15), num2str(sh(s_iter_8), 15), num2str(max(nlist)), num2str(s_min_err, 15);
    };
    result_values = [result_values; new_rows];

    % plot error
    figure();
    plot(nlist, serr);
    
    hlines = [refline([0 10^-4]), refline([0 10^-8])];
    for hline = hlines
        hline.Color = 'r';
        hline.LineStyle = ':';
        uistack(hline, 'bottom');
    end
    
    set(gca, 'YScale', 'log');
    ylabel('Error (log scale)');
    xlabel('N');
    title(['Function ' display_name ' - Composite Simpsons Error']);
    saveas(gcf, [pwd, '/output/', unique_name, '_simpsons'], 'png');

 
    % ----------------------------------------
    % adaptive simpsons, tol=1e-4

    [a4val, a4out, h4out] = adaptive_simpsons(fh, rmin, rmax, 1E-4);
    a4err = abs(true_num_val - a4val);
    
    % distribution of h
    figure();
    histogram(h4out);
    xlabel('h')
    ylabel('frequency')
    xticks(unique(h4out, 'sorted'));
    xtickangle(45);
    title(['Function ' display_name ' - Distribution of h values @ 1e-4'])
    saveas(gcf, [pwd, '/output/', unique_name, '_adaptive_simpsons_4_hist'], 'png');
    
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
    
    % distribution of h
    figure();
    histogram(h8out);
    xlabel('h')
    ylabel('frequency')
    xticks(unique(h8out, 'sorted'));
    xtickangle(45);
    title(['Function ' display_name ' - Distribution of h values @ 1e-8'])
    saveas(gcf, [pwd, '/output/', unique_name, '_adaptive_simpsons_8_hist'], 'png');
    
    % plot adaptive h splits
    figure();
    fplot(fh, [rmin rmax]);
    hold on;
    s = stem(a8out, fh(a8out));
    xticks(rmin:0.5:rmax);
    set(s,'MarkerFaceColor','r','MarkerSize',0.001);
    title(['Function ' display_name ' - Adaptive Simpsons Rule @ 1e-8']);
    saveas(gcf, [pwd, '/output/', unique_name, '_adaptive_simpsons_8'], 'png');  
    
    % --------------------
   
    % add output from task to table
    new_rows = {...
        unique_name, 'adaptive', num2str(2*length(h4out)), num2str(2*length(h8out)), '-', '-','-', '-';
    };
    result_values = [result_values; new_rows];

    
end

writetable(true_values, [pwd, '/output/true_values_table.csv']);
writetable(result_values, [pwd, '/output/result_values_table.csv']);

