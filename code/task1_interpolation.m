%% Task 1. Interpolation and prediction
[years, total, urban, rural] = population_data();
names = {'All population','Urban population','Rural population'};
data  = {total, urban, rural};
files = {'task1_all','task1_urban','task1_rural'};
legLoc = {'northwest','northwest','northeast'};

dataX = years(1:5);
tPred = 2026;
tPlot = 2021:0.01:2026;
blue = [0 0.4470 0.7410];
red  = [0.8500 0.3250 0.0980];

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
    hS = plot(tPlot, yS/1e6, '-', 'Color', blue, 'LineWidth', 1.5); hold on
    hL = plot(tPlot, yL/1e6, '--', 'Color', red, 'LineWidth', 1.5);
    hD = plot(dataX, dataY/1e6, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'w');
    hA = plot(tPred, Pactual/1e6, 'kp', 'MarkerSize', 9, 'MarkerFaceColor', 'k');
    hold off
    xlim([2020.8 2026.2]); set(gca, 'XTick', 2021:2026);
    xlabel('Year'); ylabel([names{i} ' (millions)']);
    legend([hD hL hS hA], 'Data 2021-2025', 'Lagrange polynomial', ...
           'Natural cubic spline', 'Actual 2026', 'Location', legLoc{i});
    format_figure();
    save_figure(files{i});
end
