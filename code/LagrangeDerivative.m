function dy = LagrangeDerivative(dataX,dataY,x)
%% Derivative of the Lagrange polynomial (for Newton's method)
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
