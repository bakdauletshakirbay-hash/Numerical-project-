function [p,n,hist] = bisect(func,a,b,fa,fb,atol)
%% Bisection method (Lecture 3, slide 9)
%  Inputs : func - function handle f, with f(a)*f(b) < 0
%           a,b  - initial interval [a,b];  fa = f(a), fb = f(b)
%           atol - absolute tolerance: |x* - p| <= atol is guaranteed
%  Outputs: p    - approximate root
%           n    - number of iterations
%           hist - NEW: iteration table, one row per iteration:
%                  [k, a_k, b_k, p_k, f(p_k)]
%
%  MODIFICATIONS for this project: the lecture code is unchanged except
%  that (1) each iteration is stored in "hist" so that an iteration table
%  with residuals can be printed (Task 4), and (2) the iteration stops
%  early if f(p) is exactly zero (avoids a wrong interval update).

if (a >= b) | (fa*fb >= 0) | (atol <= 0)
    disp('something wrong with the input: quitting');
    p = NaN; n = NaN; hist = [];
    return
end

n = ceil( log2(b-a) - log2(2*atol) );   % a priori number of iterations
hist = zeros(n,5);
for k = 1:n
    p  = (a+b)/2;
    fp = feval(func,p);
    hist(k,:) = [k, a, b, p, fp];      % NEW: store iteration
    if fp == 0                          % NEW: exact root found
        hist = hist(1:k,:); n = k;
        return
    end
    if fa * fp < 0
        b  = p;
        fb = fp;
    else
        a  = p;
        fa = fp;
    end
end
p = (a+b)/2;
end
