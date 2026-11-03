%% Task 1. Interpolation and prediction
[years, total, urban, rural] = population_data();
names = {'All population','Urban population','Rural population'};
data  = {total, urban, rural};
files = {'task1_all','task1_urban','task1_rural'};

dataX = years(1:5);
tPred = 2026;
tPlot = 2021:0.01:2026;
if ~exist('figures','dir'), mkdir('figures'); end

fprintf('\n================ TASK 1: prediction of 2026 from 2021-2025 data ================\n');
fprintf('%-18s %-10s %14s %14s %14s %12s\n', ...
        'Category','Model','Predicted','Actual','Abs. error','Rel. error');
for i = 1:3
    dataY   = data{i}(1:5);
    Pactual = data{i}(6);

    PL = LagrangeInterpolation(dataX,dataY,tPred);
    PS = natural_spline(dataX,dataY,tPred);

    fprintf('%-18s %-10s %14.0f %14.0f %14.0f %12.4e\n', names{i}, 'Lagrange', ...
            PL, Pactual, abs(Pactual-PL), abs(Pactual-PL)/abs(Pactual));
    fprintf('%-18s %-10s %14.0f %14.0f %14.0f %12.4e\n', '', 'Spline', ...
            PS, Pactual, abs(Pactual-PS), abs(Pactual-PS)/abs(Pactual));

    yL = LagrangeInterpolation(dataX,dataY,tPlot);
    yS = natural_spline(dataX,dataY,tPlot);
    figure(i); clf;
    plot(dataX, dataY/1e6, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5); hold on
    plot(tPlot, yL/1e6, 'r--', 'LineWidth', 2);
    plot(tPlot, yS/1e6, 'k-',  'LineWidth', 2);
    plot(tPred, Pactual/1e6, 'p', 'MarkerSize', 14, ...
         'MarkerEdgeColor', [0 0.6 0], 'MarkerFaceColor', [0 0.8 0]);
    hold off; grid on
    xlabel('Year'); ylabel('Population (millions)');
    title([names{i} ' of Kazakhstan: interpolation models']);
    legend('Data 2021-2025','Model 1: Lagrange polynomial', ...
           'Model 2: natural cubic spline','Actual 2026', 'Location','best');
    xlim([2020.8 2026.2]);
    saveas(gcf, fullfile('figures',[files{i} '.png']));
end
