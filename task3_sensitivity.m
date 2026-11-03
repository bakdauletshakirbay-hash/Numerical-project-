%% Task 3. Sensitivity and stability of the numerical models
[years, total, urban, rural] = population_data();
names  = {'(a) All population','(b) Urban population','(c) Rural population'};
data   = {total, urban, rural};
factor = [1.005, 0.995, 1.005];
dataX  = years(1:5);
tPred  = 2026;
i2024  = find(dataX == 2024);
delta  = 0.005;

fprintf('\n================ TASK 3: sensitivity to a 0.5%% change in the 2024 value ================\n');
fprintf('%-22s %-9s %14s %14s %12s %12s\n', 'Experiment','Model', ...
        'P_original','P_perturbed','S','S / 0.005');
for i = 1:3
    dataY  = data{i}(1:5);
    dataYp = dataY;
    dataYp(i2024) = factor(i)*dataY(i2024);

    PL0 = LagrangeInterpolation(dataX,dataY ,tPred);
    PL1 = LagrangeInterpolation(dataX,dataYp,tPred);
    PS0 = natural_spline(dataX,dataY ,tPred);
    PS1 = natural_spline(dataX,dataYp,tPred);

    SL = abs(PL1-PL0)/abs(PL0);
    SS = abs(PS1-PS0)/abs(PS0);

    fprintf('%-22s %-9s %14.0f %14.0f %12.4e %12.3f\n', names{i}, 'Lagrange', PL0, PL1, SL, SL/delta);
    fprintf('%-22s %-9s %14.0f %14.0f %12.4e %12.3f\n', '',       'Spline',   PS0, PS1, SS, SS/delta);
    fprintf('%-22s S_Lagrange / S_Spline = %.2f\n', '', SL/SS);
end
fprintf('\nModel selected for Tasks 4, 6, 7: %s\n', selected_model());
