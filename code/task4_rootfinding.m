%% Task 4. Population threshold and root-finding methods
[years, total, ~, ~] = population_data();
model = selected_model();
dataX = years(3:6);
dataY = total(3:6);
target = 20.7e6;

F  = @(t) model_eval (model,dataX,dataY,t) - target;
dF = @(t) model_deriv(model,dataX,dataY,t);

TOL = 1e-6;
N0  = 100;
a = 2026; b = 2027;
s0 = 2026; s1 = 2027;
p0 = 2026;

fprintf('\n================ TASK 4: when does the total population reach 20.7 million? ================\n');
fprintf('Model: %s built on 2023-2026 data,  F(t) = P(t) - 20,700,000\n', model);
fprintf('F(%d) = %.2f,  F(%d) = %.2f\n', a, F(a), b, F(b));
fprintf('Stopping tolerance TOL = %.0e years for all three methods\n', TOL);

%% Bisection
[pB,nB,hB] = bisect(F,a,b,F(a),F(b),TOL);
fprintf('\n(a) Bisection method, initial interval [%d, %d]\n', a, b);
fprintf('%4s %16s %16s %16s %16s\n','k','a_k','b_k','p_k','F(p_k)');
fprintf('%4d %16.8f %16.8f %16.8f %16.4f\n', hB');
fprintf('Final approximation p = %.8f, F(p) = %.4f\n', pB, F(pB));
fprintf('Iterations: %d\n', nB);

%% Secant
[pS,nS,hS] = secant(F,s0,s1,TOL,N0);
fprintf('\n(b) Secant method, initial approximations p0 = %d, p1 = %d\n', s0, s1);
fprintf('%4s %16s %16s %16s\n','i','p_i','F(p_i)','|p_i - p_{i-1}|');
fprintf('%4d %16.8f %16.4e %16.4e\n', hS');
fprintf('Iterations: %d\n', nS);

%% Newton
[pN,nN,hN] = newton(F,dF,p0,TOL,N0);
fprintf('\n(c) Newton''s method, initial approximation p0 = %d\n', p0);
fprintf('%4s %16s %16s %16s\n','i','p_i','F(p_i)','|p_i - p_{i-1}|');
fprintf('%4d %16.8f %16.4e %16.4e\n', hN');
fprintf('Iterations: %d\n', nN);

%% Comparison
fprintf('\n%-10s %12s %10s %18s %14s %22s\n','Method','root t*','iterations', ...
        'F evaluations','F'' evaluations','predicted date');
methods = {'Bisection','Secant','Newton'};
roots   = [pB pS pN];
iters   = [nB nS nN];
fevals  = [nB+2, nS+2, nN];
dfevals = [0 0 nN];
for k = 1:3
    [yr,mo,mname] = year_to_date(roots(k));
    fprintf('%-10s %12.6f %10d %18d %14d %15s %d\n', methods{k}, roots(k), ...
            iters(k), fevals(k), dfevals(k), mname, yr);
end
fprintf('Max difference between the three roots: %.2e years\n', max(roots)-min(roots));

%% Plot
tt = 2023:0.01:2028;
figure(4); clf;
plot(dataX, dataY/1e6, 'bo', 'MarkerSize', 8, 'LineWidth', 1.5); hold on
plot(tt, model_eval(model,dataX,dataY,tt)/1e6, 'k-', 'LineWidth', 2);
plot([tt(1) tt(end)], [target target]/1e6, 'r--', 'LineWidth', 1.5);
plot(pN, target/1e6, 'p', 'MarkerSize', 14, ...
     'MarkerEdgeColor', [0 0.6 0], 'MarkerFaceColor', [0 0.8 0]);
hold off; grid on
xlabel('Year'); ylabel('Total population (millions)');
title('Total population model (2023-2026 data) and the 20.7 million threshold');
legend('Data 2023-2026', ['Model: ' model], '20.7 million', 'Root t^*', 'Location','NorthWest');
save_figure('task4_threshold');
