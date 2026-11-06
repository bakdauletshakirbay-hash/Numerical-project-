function [p,n,hist] = newton(func,dfunc,p0,tol,N0)
%% Newton's method
hist = zeros(0,4);
i = 1;
while i <= N0
    fp0  = feval(func,p0);
    dfp0 = feval(dfunc,p0);
    if dfp0 == 0
        disp('Newton: zero derivative, method failed');
        p = NaN; n = i; return
    end
    p = p0 - fp0/dfp0;
    hist(i,:) = [i, p, feval(func,p), abs(p - p0)];
    if abs(p - p0) < tol
        n = i;
        return
    end
    i  = i + 1;
    p0 = p;
end
fprintf('Newton: method failed after N0 = %d iterations\n', N0);
p = NaN; n = N0;
end
