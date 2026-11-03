function [a,b,c,d] = natural_spline_coef(dataX,dataY)
%% Cubic Spline (Natual Boundary) Interpolation
%  On each sub-interval, generate four coefficients aj, bj, cj, and dj
%       Sj(x) = aj + bj(x-xj) + cj(x-xj)^2 + dj(x-xj)^3.
%
%  Inputs: dataX dataY are row vectors of same dimension.
%  Output: a is the collum vector that stores {aj} for j=1,2,...,n+1
%          b is the collum vector that stores {bj} for j=1,2,...,n+1
%          c is the collum vector that stores {cj} for j=1,2,...,n+1
%          d is the collum vector that stores {dj} for j=1,2,...,n+1
%
%  Source: Lecture 4, slide 86. Used WITHOUT modification.

%% Initialize h
n = length(dataX) - 1;
h = zeros(1,n);
for j = 1:n
    h(j) = dataX(j+1) - dataX(j);
end
%% Prepare for Matrix A
A = zeros(n+1,n+1);
A(1,1) = 1; A(n+1,n+1) = 1;
for j = 2:n
    A(j,j-1) = h(j-1);
    A(j,j+1) = h(j);
    A(j,j) = 2*(h(j-1)+h(j));
end
%% Prepare for vector bb
bb = zeros(n+1,1);
for j = 2:n
    bb(j) = 3/h(j)*(dataY(j+1)-dataY(j)) - 3/h(j-1)*(dataY(j)-dataY(j-1));
end
%% Solve A*c = bb
c = A\bb;
%% Find a,b,d.
a = reshape(dataY(1:n+1),n+1,1);
b = zeros(n,1);
d = zeros(n,1);
for j = 1:n
    b(j) = 1/h(j)*(a(j+1)-a(j)) - h(j)/3*(2*c(j)+c(j+1));
    d(j) = (c(j+1) - c(j))/(3*h(j));
end
%% Remove the last entries of a and c
a(n+1) = [];
c(n+1) = [];
end
