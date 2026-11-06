function save_figure(name)
%% Save the current figure as a PNG file
figDir = fullfile(fileparts(mfilename('fullpath')), 'figures');
try
    if ~exist(figDir,'dir'), mkdir(figDir); end
    print(gcf, fullfile(figDir, [name '.png']), '-dpng', '-r300');
catch err
    warning('Figure "%s" was not saved: %s', name, err.message);
end
end
