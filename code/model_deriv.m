function dy = model_deriv(model,dataX,dataY,x)
%% Derivative of Model 1 ('lagrange') or Model 2 ('spline') at x
switch lower(model)
    case 'lagrange'
        dy = LagrangeDerivative(dataX,dataY,x);
    case 'spline'
        dy = natural_spline_deriv(dataX,dataY,x);
    otherwise
        error('Unknown model "%s" (use ''lagrange'' or ''spline'')', model);
end
end
