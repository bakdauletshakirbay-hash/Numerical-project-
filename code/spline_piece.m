function k = spline_piece(dataX,xq)
%% Index k of the cubic piece S_k used to evaluate the spline at xq.
%  Inside the data range this is the same search loop as in the lecture
%  (Lecture 4, slide 87). NEW: outside the range we use the nearest end
%  piece, i.e. the spline is extrapolated with S_1 (left) or S_n (right).
n = length(dataX) - 1;
if xq < dataX(1)
    k = 1;                 % extrapolate to the left with S_1
elseif xq > dataX(end)
    k = n;                 % extrapolate to the right with S_n
else
    for j = 1:n
        if dataX(j) <= xq && dataX(j+1) >= xq
            k = j;
            break
        end
    end
end
end
