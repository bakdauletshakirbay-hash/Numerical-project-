function save_figure(name)
%% Save the current figure as figures/<name>.png next to the code files
figDir = fullfile(fileparts(mfilename('fullpath')), 'figures');
try
    if ~exist(figDir,'dir'), mkdir(figDir); end
    saveas(gcf, fullfile(figDir, [name '.png']));
catch err
    warning('Figure "%s" was not saved: %s', name, err.message);
end
end
