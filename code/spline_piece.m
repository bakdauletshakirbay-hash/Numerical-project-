function k = spline_piece(dataX,xq)
%% Spline piece used at xq (end pieces are used for extrapolation)
n = length(dataX) - 1;
if xq < dataX(1)
    k = 1;
elseif xq > dataX(end)
    k = n;
else
    for j = 1:n
        if dataX(j) <= xq && dataX(j+1) >= xq
            k = j;
            break
        end
    end
end
end
