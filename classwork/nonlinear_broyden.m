% class 2017-11-20
% nonlinear systems - broyden method

x0_vals = [0.1 0.1 -0.1];

xvals = x0_vals;
x = transpose(xvals);

xargs = num2cell(xvals);

% -------------------------
% symbolic method

f1 = symfun( 3*x1 - cos(x2*x3) - 0.5, [x1,x2,x3]);
f2 = symfun(x1^2 - 81*(x2+0.1)^2 + sin(x3) + 1.06, [x1,x2,x3]);
f3 = symfun(exp(-x1*x2) + 20*x3 +(10*pi-3)/3, [x1,x2,x3]);

J = jacobian([f1 f2 f3], [x1 x2 x3]);

% F = @(x1,x2,x3) double([
%     f1(xargs{:})
%     f2(xargs{:})
%     f3(xargs{:})
% ]);

F = symfun(transpose([f1 f2 f3]), [x1 x2 x3]);

J0 = double(J(xargs{:}));
F0 = double(F(xargs{:}));


% -------------------------
% manual method

% F = @(x1, x2, x3) [
%       (3*x1 - cos(x2*x3) - 0.5)
%       (x1^2 - 81*(x2+0.1)^2 + sin(x3) + 1.06)
%       (exp(-x1*x2) + 20*x3 +(10*pi-3)/3)
% ];
% 
% J = @(x1, x2, x3) [
%       3               x3*sin(x2*x3)  x2*sin(x2*x3)
%       2*x1           -162*(x2+0.1)   cos(x3)
%      -x2*exp(-x1*x2) -x1*exp(-x1*x2) 20
% ];
% 
% F0 = F(xargs{:});
% J0 = J(xargs{:});

% -------------------------

% save
v = F0;

A0 = J0;

% use Gaussian elimiation
% A = gaussian(A0);
% alternative
A = inv(A0);


s = -A*v;

x = x + s;
k = 2;

N = 100;
TOL = 1e-4;

while k<= N
    
    
    xvals = x;
    xargs = num2cell(xvals);
    
    w = v;
    v = F(xargs{:});
    
    y = v-w;
    
    z = -A*y;
    
    p = -transpose(s)*z;
    
    u = transpose(s) * A;
    u = transpose(u);
    
    A = A + (1/p) * (s+z) * transpose(u);
    
    s = -A*v;
    x = x + s;
    
    complete = norm(s) < TOL;
    if complete
        break;
    end
    k = k+1;
end













