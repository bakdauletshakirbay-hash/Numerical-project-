function y = model_eval(model,dataX,dataY,x)
%% Evaluate Model 1 ('lagrange') or Model 2 ('spline') at x
switch lower(model)
    case 'lagrange'
        y = LagrangeInterpolation(dataX,dataY,x);
    case 'spline'
        y = natural_spline(dataX,dataY,x);
    otherwise
        error('Unknown model "%s" (use ''lagrange'' or ''spline'')', model);
end
end
