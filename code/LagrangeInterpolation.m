function y = LagrangeInterpolation(dataX,dataY,x)
%% Lagrange Interpolation Polynomial (Lecture 4, Theorem 3.2, slides 18-19)
%  P(x) = sum_{k=0}^{n} f(x_k) L_{n,k}(x),
%  L_{n,k}(x) = prod_{i ~= k} (x - x_i)/(x_k - x_i).
%
%  Inputs: dataX dataY are row vectors of same dimension (n+1 nodes).
%          x is the query point(s).
%  Output: y is the value of the interpolating polynomial y=P(x) at x.
%
%  The function name and calling form are the ones used in the lecture
%  driver (Lecture 4, slide 106). The code itself is not in the slides,
%  so it is written directly from the formula above.

n = length(dataX) - 1;
y = zeros(size(x));
for m = 1:length(x)
    P = 0;
    for k = 1:n+1
        % Lagrange basis polynomial L_{n,k} evaluated at x(m)
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
