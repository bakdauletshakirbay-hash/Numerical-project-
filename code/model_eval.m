function y = model_eval(model,dataX,dataY,x)
%% Evaluate one of the two numerical models at the point(s) x.
%  model = 'lagrange'  -> Model 1, Lagrange interpolation polynomial
%  model = 'spline'    -> Model 2, natural cubic spline interpolation
switch lower(model)
    case 'lagrange'
        y = LagrangeInterpolation(dataX,dataY,x);
    case 'spline'
        y = natural_spline(dataX,dataY,x);
    otherwise
        error('Unknown model "%s" (use ''lagrange'' or ''spline'')', model);
end
end
