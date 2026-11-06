function dy = natural_spline_deriv(dataX,dataY,x)
%% Derivative of the natural cubic spline
[~,b,c,d] = natural_spline_coef(dataX,dataY);
dy = zeros(size(x));
for n = 1:length(x)
    k = spline_piece(dataX,x(n));
    xk = dataX(k);
    dy(n) = b(k) + 2*c(k)*(x(n)-xk) + 3*d(k)*(x(n)-xk)^2;
end
end
