function y = LagrangeInterpolation(dataX,dataY,x)
%% Lagrange Interpolation Polynomial
n = length(dataX) - 1;
y = zeros(size(x));
for m = 1:length(x)
    P = 0;
    for k = 1:n+1
        L = 1;
        for i = 1:n+1
            if i ~= k
                L = L*(x(m) - dataX(i))/(dataX(k) - dataX(i));
            end
        end
        P = P + dataY(k)*L;
    end
    y(m) = P;
end
end
