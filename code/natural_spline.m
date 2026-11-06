function y = natural_spline(dataX,dataY,x)
%% Natural cubic spline interpolation

[a,b,c,d] = natural_spline_coef(dataX,dataY);

y = zeros(size(x));
for n = 1:length(x)
    k = spline_piece(dataX,x(n));
    xk = dataX(k);
    y(n) = a(k) + b(k)*(x(n)-xk) + c(k)*(x(n)-xk)^2 + d(k)*(x(n)-xk)^3;
end
end
