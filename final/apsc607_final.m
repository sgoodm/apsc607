%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for solving the BVP problem
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
close all;

% Initialize all the functions, boundary conditions and spatial grid for x.

px = @(x) -(0.5.*x.^2 + 0.1.*x);
qx = @(x) x.^2 - 3.*x;
rx = @(x) -5.*normpdf(x, 1, 0.1);

% Boundary conditions

aa = 0;
bb = 2;

alpha = 1;
beta = 0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Turn this in a for-loop to compare how the solution evolves depending on
% the amount of grid points N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set various grid sizes

% Initialize average result to get started to calculate the relative change
% in difference in result when grid size increases

N_var = [5, 10, 20 40 80 160 320];
% N_var = [5, 160];

% Start for-loop (I recommend first writing the solution without the
% for-loop.

% NOTES:
%
% you can comment out the "hold on" lines for the two figures in 
% the for loop if you only want to look at a single N value
%

for i = 1:length(N_var)
    N = N_var(i);
    % Spatial grid X, based on grid points N.

    h = (bb-aa)/(N);
    x = linspace(aa,bb,N);

    % Initialize functions A, B and C
    % Change into p(x),q(x),r(x) based on the notation of a linear system

    % pre calculate p,q,r values as vectors to pass to functions
    p = px(x);
    q = qx(x);
    r = rx(x);

    % Solve the equation using central difference scheme as introduced in the
    % book (where the A matrix is NxN, but there are N+2 points)

    [y,A] = cent_diff(h,p,q,r,N,alpha,beta);

    % Solve the equation using upwind difference scheme (where the A matrix is
    % NxN, but there are N+2 points) and the upwind scheme is only for the
    % first order derivative. For the second derivative use central difference.

    yup = upw_diff(h,p,q,r,N,alpha,beta);

    % Instead of using the NxN matrix, where the boundary conditions are
    % implemented in the b-vector, create a N+2xN+2 A-matrix where the first
    % and last row set the boundary conditions.

    y2 = cent_diff_v2(h,p,q,r,N,alpha,beta);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Bonus point section
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Adapt the central diff method to have different boundary conditions.
    % Now y'(0) = 0 and y'(2) = 0

    y3 = cent_diff_v3(h,p,q,r,N,0,0);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Figures to show the result
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Show the 3 methods at various grid sizes
    figure(1)
    plot(x,y',x,yup',x,y2')
    legend('y', 'yup', 'y2', 'Location', 'Best')
    hold on;

    
    % Compare the results with different boundary conditions
    figure(2)
    plot(x,y',x,y3')
    legend('y', 'y3', 'Location', 'Best')
    hold on;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate how much the result changes from small N to larger N
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Calculate absolute error using the sum/N (i.e. the average)
    % Remember the average for the new grid size
    y_err(i) = sum(y)/N;
    yup_err(i) = sum(yup)/N;
    y2_err(i) = sum(y2)/N;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% end for loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot how the error changes with increasing grid size

figure(3)
loglog(N_var,y_err,N_var,yup_err,N_var,y2_err)
