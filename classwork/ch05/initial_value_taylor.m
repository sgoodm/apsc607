% class 2017-10-30
% 5.3 Higher-Order Taylor Methods

clear;

% y' = y - t^2 + 1
% 0 <= t <= 2
% y(0) = 0.5

N = 10;

rmin = 0;
rmax = 2;

h = (rmax - rmin) / N;

t = rmin:h:rmax;

y0 = 0.5;


% ----------------------------------------
% derivatives (symbolic)

syms tx y;
sym_yd1(tx,y) = y - tx.^2 + 1;

% ----------------------------------------
% derivatives (hand)

yd1 = @(t,y) y - t.^2 + 1;

% yd2 = yd1 - 2t 
yd2 = @(t,y) y - t.^2 + 1 - 2.*t;

% yd3 = yd1 - 2t - 2
yd3 = @(t,y) y - t.^2 + 1 - 2.*t - 2; 

% yd4 = yd1 - 2t - 2
yd4 = @(t,y) y - t.^2 + 1 - 2.*t - 2;

% ----------------------------------------

method = "hand";
order = 2;


for i=1:N
    
    if t(i) == rmin
        w(i) = y0;
        e(i) = 0;
    end
    
    if strcmp(method, "hand")
        % hand derivatives
        T = 0;
        for j=1:order
            f_name = ['yd', num2str(j)];
            fh = eval(f_name);
            T = T + (h^(j-1)/factorial(j))*fh(t(i), w(i));
        end
    
    elseif strcmp(method, "symbolic")
        % symbolic derivatives
        T = 0;
        for j=1:order

            sym_ydx = sym_yd1;
            for k=2:j
                sym_ydx = diff(sym_ydx);
            end
            fh = matlabFunction(sym_ydx);

            T = T + (h^(j-1)/factorial(j)) * fh(t(i), w(i));
        end
    end
    
    w(i+1) = w(i) + h * T;
        
end

