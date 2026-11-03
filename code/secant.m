function [p,n,hist] = secant(func,p0,p1,tol,N0)
%% Secant method
%  hist stores [i, p, f(p), |p - p1|] for each iteration
hist = zeros(0,4);
q0 = feval(func,p0);
q1 = feval(func,p1);
i = 1;
while i <= N0
    if q1 == q0
        disp('Secant: f(p1) = f(p0), method failed');
        p = NaN; n = i; return
    end
    p = p1 - q1*(p1 - p0)/(q1 - q0);
    q = feval(func,p);
    hist(i,:) = [i, p, q, abs(p - p1)];
    if abs(p - p1) < tol
        n = i;
        return
    end
    i  = i + 1;
    p0 = p1; q0 = q1;
    p1 = p;  q1 = q;
end
fprintf('Secant: method failed after N0 = %d iterations\n', N0);
p = NaN; n = N0;
end
