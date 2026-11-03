function [p,n,hist] = newton(func,dfunc,p0,tol,N0)
%% Newton's method (Lecture 3, Algorithm 2.3, slide 28)
%  p_i = p_{i-1} - f(p_{i-1})/f'(p_{i-1}),  stop when |p - p0| < TOL.
%
%  Inputs : func  - function handle f
%           dfunc - function handle f'
%           p0    - initial approximation
%           tol   - tolerance TOL
%           N0    - maximum number of iterations
%  Outputs: p     - approximate root (NaN if the method failed)
%           n     - number of iterations used
%           hist  - iteration table, one row per iteration:
%                   [i, p_i, f(p_i), |p_i - p_{i-1}|]
%
%  The lecture gives this method as pseudocode only; this is a direct
%  MATLAB translation of Algorithm 2.3 plus storage of the iterations.

hist = zeros(0,4);
i = 1;                                  % Step 1
while i <= N0                           % Step 2
    fp0  = feval(func,p0);
    dfp0 = feval(dfunc,p0);
    if dfp0 == 0
        disp('Newton: zero derivative, method failed');
        p = NaN; n = i; return
    end
    p = p0 - fp0/dfp0;                  % Step 3: compute p_i
    hist(i,:) = [i, p, feval(func,p), abs(p - p0)];
    if abs(p - p0) < tol                % Step 4: procedure successful
        n = i;
        return
    end
    i  = i + 1;                         % Step 5
    p0 = p;                             % Step 6: update p0
end
fprintf('Newton: method failed after N0 = %d iterations\n', N0);   % Step 7
p = NaN; n = N0;
end
