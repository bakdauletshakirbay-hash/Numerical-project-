function y = natural_spline(dataX,dataY,x)
%% Cubic Spline (Natual Boundary) Interpolation
%  On each sub-interval, generate four coefficients aj, bj, cj, and dj
%       Sj(x) = aj + bj(x-xj) + cj(x-xj)^2 + dj(x-xj)^3.
%
%  Inputs: dataX dataY are row vectors of same dimension.
%          x is the query point(s).
%  Output: y is the value of spline interpolation y=S(x) at query points x
%
%  Source: Lecture 4, slide 87.
%  MODIFICATION for this project: the lecture version only works for
%  dataX(1) <= x <= dataX(end); for x outside the data range the index k
%  is never set. Prediction (e.g. 2026 from 2021-2025 data) needs
%  extrapolation, so we extend the first cubic piece S_1 to the left and
%  the last cubic piece S_n to the right of the data.

%% Generate Spline Coefficient [ai,bi,ci,di] on each interval.
[a,b,c,d] = natural_spline_coef(dataX,dataY);

%% Evaluate the query points
y = zeros(size(x));
for n = 1:length(x)
    k = spline_piece(dataX,x(n));   % MODIFIED (see spline_piece.m)
    xk = dataX(k);
    y(n) = a(k) + b(k)*(x(n)-xk) + c(k)*(x(n)-xk)^2 + d(k)*(x(n)-xk)^3;
end
end
