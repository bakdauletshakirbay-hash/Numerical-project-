function format_figure()
%% Figure style
set(gcf, 'Color', 'w', 'Units', 'centimeters', 'Position', [2 2 14 9], ...
         'PaperPositionMode', 'auto');
ax = gca;
set(ax, 'FontName', 'Times New Roman', 'FontSize', 11, 'LineWidth', 0.75, ...
        'Box', 'on', 'TickDir', 'in', 'XGrid', 'on', 'YGrid', 'on', ...
        'GridLineStyle', ':');
try
    set(ax, 'GridAlpha', 0.3);
catch
end
lg = findobj(gcf, 'Type', 'legend');
set(lg, 'FontName', 'Times New Roman', 'FontSize', 10, 'EdgeColor', [0.7 0.7 0.7]);
end
