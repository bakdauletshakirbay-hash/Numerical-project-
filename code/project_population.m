function P = project_population(years, pop, name, figfile, fignum, legLoc)
%% Projection to 2028 and 2030 with the selected model (Tasks 6, 7)

model  = selected_model();
tFut   = [2028 2030];
P      = model_eval(model, years, pop, tFut);
if strcmpi(model,'spline'), other = 'lagrange'; else, other = 'spline'; end
Pother = model_eval(other, years, pop, tFut);

fprintf('\n================ %s: projection with the %s model (2021-2026 data) ================\n', ...
        upper(name), model);
fprintf('Observed yearly changes 2021->2026:');
fprintf(' %+.0f', diff(pop)); fprintf('\n');
fprintf('Observed change 2021->2026: %+.0f (%+.2f%%)\n', pop(end)-pop(1), 100*(pop(end)/pop(1)-1));
fprintf('%-6s %16s %22s %22s\n','Year', ['P (' model ')'], 'change vs 2026', ...
        ['(' other ', comparison)']);
for k = 1:numel(tFut)
    fprintf('%-6d %16.0f %12.0f (%+6.2f%%) %22.0f\n', tFut(k), P(k), ...
            P(k)-pop(end), 100*(P(k)/pop(end)-1), Pother(k));
end

fprintf('Model slope P''(2026) = %.0f people/year\n', model_deriv(model, years, pop, 2026));

%% Plot
blue = [0 0.4470 0.7410];
if strcmpi(model,'spline'), mlabel = 'Natural cubic spline'; else, mlabel = 'Lagrange polynomial'; end
tIn  = 2021:0.01:2026;                  % interpolation (inside the data)
tOut = 2026:0.01:2030;                  % extrapolation (projection)
figure(fignum); clf;
hI = plot(tIn,  model_eval(model, years, pop, tIn)/1e6,  '-',  'Color', blue, 'LineWidth', 1.5); hold on
hE = plot(tOut, model_eval(model, years, pop, tOut)/1e6, '--', 'Color', blue, 'LineWidth', 1.5);
hD = plot(years, pop/1e6, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'w');
hP = plot(tFut, P/1e6, 'ks', 'MarkerSize', 7, 'MarkerFaceColor', 'k');
hold off
xlim([2020.7 2030.3]); set(gca, 'XTick', 2021:2030);
xlabel('Year'); ylabel([name ' (millions)']);
legend([hD hI hE hP], 'Data 2021-2026', mlabel, 'Extrapolation', ...
       'Projection 2028, 2030', 'Location', legLoc);
format_figure();
save_figure(figfile);
end
