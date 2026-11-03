function dy = model_deriv(model,dataX,dataY,x)
%% Derivative of one of the two numerical models at the point(s) x.
switch lower(model)
    case 'lagrange'
        dy = LagrangeDerivative(dataX,dataY,x);
    case 'spline'
        dy = natural_spline_deriv(dataX,dataY,x);
    otherwise
        error('Unknown model "%s" (use ''lagrange'' or ''spline'')', model);
end
end
