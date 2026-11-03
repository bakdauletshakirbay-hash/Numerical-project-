function P = project_population(years, pop, name, figfile, fignum)
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
tt = 2021:0.01:2030;
figure(fignum); clf;
plot(years, pop/1e6, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5); hold on
plot(tt, model_eval(model, years, pop, tt)/1e6, 'k-', 'LineWidth', 2);
plot(tFut, P/1e6, 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
yl = ylim; plot([2026 2026], yl, ':', 'Color', [0.5 0.5 0.5]); ylim(yl);
hold off; grid on; xlim([2020.7 2030.3]);
xlabel('Year'); ylabel([name ' (millions)']);
title([name ' of Kazakhstan: data and projection']);
legend('Data 2021-2026', ['Model: ' model], 'Projection 2028, 2030', ...
       'End of data', 'Location','Best');
save_figure(figfile);
end
