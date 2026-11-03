function dy = natural_spline_deriv(dataX,dataY,x)
%% Derivative of the natural cubic spline (NEW, for Newton's method in Task 4)
%  On piece k:  S_k'(x) = bk + 2 ck (x-xk) + 3 dk (x-xk)^2.
%  Uses the lecture coefficients from natural_spline_coef and the same
%  piece selection (including extrapolation) as natural_spline.

[~,b,c,d] = natural_spline_coef(dataX,dataY);
dy = zeros(size(x));
for n = 1:length(x)
    k = spline_piece(dataX,x(n));
    xk = dataX(k);
    dy(n) = b(k) + 2*c(k)*(x(n)-xk) + 3*d(k)*(x(n)-xk)^2;
end
end
