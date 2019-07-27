function xgrid = plotpriorposteriordraws(posteriordraws, priordraws, x, farbe, newfigflag, muflag)
% PLOTPRIORPOSTERIORDRAWS ...
%
% plotpriorposteriordraws(posteriordraws, priordraws, x, farbe, newfigflag, muflag)
%   ...

%% VERSION INFO
% AUTHOR    : Elmar Mertens
% $DATE     : 01-May-2013 15:02:43 $
% $Revision : 1.00 $
% DEVELOPED : 7.14.0.739 (R2012a)
% FILENAME  : plotpriorposteriordraws.m

if nargin < 2
    priordraws = [];
end

if nargin < 3
    x = [];
end

if nargin < 4 || isempty(farbe)
    farbe = [0 0 1]; % blue
end

if nargin < 5 || isempty(newfigflag)
    newfigflag = true;
end

if nargin < 6 || isempty(muflag)
    muflag = true;
end

% if isempty(x)
%     [posteriorpdf, posteriorx] = ksdensity(posteriordraws);
%     if ~isempty(priordraws)
%         [priorpdf, priorx] = ksdensity(priordraws);
%     end
% else
%     [posteriorpdf, posteriorx] = ksdensity(posteriordraws, x);
%     if ~isempty(priordraws)
%         [priorpdf, priorx] = ksdensity(priordraws, x);
%     end
% end

if isempty(x)
    minmax = [min(posteriordraws) max(posteriordraws)];
    x = minmax(1) : (minmax(2) - minmax(1)) / 100 : minmax(2);
end
[posteriorpdf, posteriorx] = ksdensity(posteriordraws, x);
if ~isempty(priordraws)
    [priorpdf, priorx] = ksdensity(priordraws, x);
end

if newfigflag
    figure
end

hold on

plot(posteriorx, posteriorpdf, '-', 'linewidth', 2, 'color', farbe)
if ~isempty(priordraws)
    plot(priorx, priorpdf, '--', 'linewidth', 2, 'color', farbe)
end

if muflag
    YLIM = ylim;
    if ~newfigflag
        YLIM(2) = max(YLIM(2), choppy(1.1 * max(posteriorpdf),2));
        YLIM(1) = 0;
    end
    
    plotvertline(mean(posteriordraws), YLIM, '-', 'linewidth', 1, 'color', farbe);
    if ~isempty(priordraws)
        plotvertline(mean(priordraws), YLIM, '--', 'linewidth', 1, 'color', farbe);
    end
end

if ~isempty(x)
    xlim(x([1 end]))
end

if nargout > 0
    xgrid = x;
end
