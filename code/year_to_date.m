function [yr,mo,mname] = year_to_date(t)
%% Convert a time t (in years) to a calendar year and month.
%  Data are given on January 1, so t = 2027.0 is Jan 1 2027 and the
%  fractional part of t is the fraction of the year that has passed.
%  Month m covers fractions [(m-1)/12, m/12).
names = {'January','February','March','April','May','June','July', ...
         'August','September','October','November','December'};
yr = floor(t);
mo = floor((t - yr)*12) + 1;
mname = names{mo};
end
