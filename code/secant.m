function [p,n,hist] = secant(func,p0,p1,tol,N0)
%% Secant method (Lecture 3, slide 35)
%  p_{k+1} = p_k - f(p_k)(p_k - p_{k-1}) / (f(p_k) - f(p_{k-1})),
%  stop when |p - p1| < TOL (same stopping rule as Newton, Algorithm 2.3).
%
%  Inputs : func   - function handle f
%           p0, p1 - two initial approximations
%           tol    - tolerance TOL
%           N0     - maximum number of iterations
%  Outputs: p      - approximate root (NaN if the method failed)
%           n      - number of iterations used
%           hist   - iteration table, one row per iteration:
%                    [i, p_i, f(p_i), |p_i - p_{i-1}|]
%
%  The lecture gives the secant formula only; this implementation follows
%  the structure of the lecture algorithms (Newton, Alg. 2.3; False
%  Position, slide 41): q = f(p) is reused so only ONE new function
%  evaluation is needed per iteration.

hist = zeros(0,4);
q0 = feval(func,p0);
q1 = feval(func,p1);
i = 1;
while i <= N0
    if q1 == q0
        disp('Secant: f(p1) = f(p0), method failed');
        p = NaN; n = i; return
    end
    p = p1 - q1*(p1 - p0)/(q1 - q0);    % secant step
    q = feval(func,p);
    hist(i,:) = [i, p, q, abs(p - p1)];
    if abs(p - p1) < tol                 % procedure successful
        n = i;
        return
    end
    i  = i + 1;
    p0 = p1; q0 = q1;                    % shift the two most recent iterates
    p1 = p;  q1 = q;
end
fprintf('Secant: method failed after N0 = %d iterations\n', N0);
p = NaN; n = N0;
end
