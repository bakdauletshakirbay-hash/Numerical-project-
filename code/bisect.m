function [p,n,hist] = bisect(func,a,b,fa,fb,atol)
%% Bisection method
%  hist stores [k, a, b, p, f(p)] for each iteration (added for the table)
if (a >= b) | (fa*fb >= 0) | (atol <= 0)
    disp('something wrong with the input: quitting');
    p = NaN; n = NaN; hist = [];
    return
end

n = ceil( log2(b-a) - log2(2*atol) );
hist = zeros(n,5);
for k = 1:n
    p  = (a+b)/2;
    fp = feval(func,p);
    hist(k,:) = [k, a, b, p, fp];
    if fp == 0
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
