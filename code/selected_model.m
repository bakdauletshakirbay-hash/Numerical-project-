function model = selected_model()
%% Model selected by the group in Task 3, used in Tasks 4, 6 and 7.
%  Change to 'lagrange' here if the group decides otherwise; Tasks 4, 6
%  and 7 will then use the Lagrange polynomial automatically.
%
%  Reason for 'spline' (see output of task3_sensitivity.m and
%  task2_backtesting.m): the natural cubic spline has smaller back-testing
%  errors and is much less sensitive to a 0.5% change in one data value.
model = 'spline';
end
