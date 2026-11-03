function dy = LagrangeDerivative(dataX,dataY,x)
%% Derivative of the Lagrange Interpolation Polynomial (NEW, for Task 4)
%  P'(x) = sum_k f(x_k) L'_{n,k}(x), where by the product rule
%  L'_{n,k}(x) = sum_{j ~= k} [ 1/(x_k - x_j) * prod_{i ~= k, i ~= j} (x - x_i)/(x_k - x_i) ].
%
%  Needed only if Newton's method (Task 4) is applied to the Lagrange model.
%  Inputs/outputs as in LagrangeInterpolation.

n = length(dataX) - 1;
dy = zeros(size(x));
for m = 1:length(x)
    dP = 0;
    for k = 1:n+1
        dL = 0;
        for j = 1:n+1
            if j ~= k
                term = 1/(dataX(k) - dataX(j));
                for i = 1:n+1
                    if i ~= k && i ~= j
                        term = term*(x(m) - dataX(i))/(dataX(k) - dataX(i));
                    end
                end
                dL = dL + term;
            end
        end
        dP = dP + dataY(k)*dL;
    end
    dy(m) = dP;
end
end
