%% Task 2. Model validation and error analysis
[years, total, urban, rural] = population_data();
names = {'All population','Urban population','Rural population'};
data  = {total, urban, rural};

fprintf('\n================ TASK 2: back-testing ================\n');
summary = zeros(3,4);
for i = 1:3
    fprintf('\n%s\n', names{i});
    fprintf('%-11s %-7s %12s | %12s %12s %10s | %12s %12s %10s\n', ...
            'Data used','Target','Actual', ...
            'Lagrange','E_abs','E_rel','Spline','E_abs','E_rel');
    ErelL = zeros(1,3); ErelS = zeros(1,3);
    for m = 3:5
        dataX   = years(1:m);
        dataY   = data{i}(1:m);
        tTarget = years(m+1);
        Pactual = data{i}(m+1);

        PL = LagrangeInterpolation(dataX,dataY,tTarget);
        PS = natural_spline(dataX,dataY,tTarget);
        EabsL = abs(Pactual-PL);  ErelL(m-2) = EabsL/abs(Pactual);
        EabsS = abs(Pactual-PS);  ErelS(m-2) = EabsS/abs(Pactual);

        fprintf('%4d-%-6d %-7d %12.0f | %12.0f %12.0f %10.4e | %12.0f %12.0f %10.4e\n', ...
                years(1), years(m), tTarget, Pactual, ...
                PL, EabsL, ErelL(m-2), PS, EabsS, ErelS(m-2));
    end
    fprintf('%-28s   mean E_rel (Lagrange) = %.4e,  mean E_rel (Spline) = %.4e\n', ...
            '', mean(ErelL), mean(ErelS));
    summary(i,:) = [mean(ErelL), mean(ErelS), sum(ErelL < ErelS), sum(ErelS < ErelL)];
end

fprintf('\nSummary of back-testing (3 predictions per category)\n');
fprintf('%-18s %16s %16s %14s %14s\n','Category','mean Erel Lagr.', ...
        'mean Erel Spline','Lagrange wins','Spline wins');
for i = 1:3
    fprintf('%-18s %16.4e %16.4e %14d %14d\n', names{i}, summary(i,:));
end
fprintf('%-18s %16.4e %16.4e %14d %14d\n', 'Overall', mean(summary(:,1)), ...
        mean(summary(:,2)), sum(summary(:,3)), sum(summary(:,4)));
