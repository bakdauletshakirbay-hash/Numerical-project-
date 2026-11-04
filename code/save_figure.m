function save_figure(name)
%% Save the current figure as figures/<name>.png (300 dpi) inside the code folder
figDir = fullfile(fileparts(mfilename('fullpath')), 'figures');
try
    if ~exist(figDir,'dir'), mkdir(figDir); end
    print(gcf, fullfile(figDir, [name '.png']), '-dpng', '-r300');
catch err
    warning('Figure "%s" was not saved: %s', name, err.message);
end
end
