%
% modified version of plot_colorbar function from:
%   https://www.mathworks.com/matlabcentral/fileexchange/19591-plot-colorbar?focused=5098177&tab=function
%
function h = plot_colorbar(size, title_string, cmap)



width = 1;

map = cmap;

h = image(repmat(cat(3, map(:,1)', map(:,2)', map(:,3)'), width, 1));

% Remove ticks we dont want.
set(gca, 'ytick', 0);

%ticks = get(gca, 'xtick');
set(gca, 'xtick', [1 10]);
set(gca, 'xticklabel', {'0.01','0.1'});
xlabel('h')
% Set up the axis
title(title_string)
axis equal
axis tight
axis xy
set(gcf, 'Position', size)
