function [yr,mo,mname] = year_to_date(t)
%% Convert t (years, data on January 1) to year and month
names = {'January','February','March','April','May','June','July', ...
         'August','September','October','November','December'};
yr = floor(t);
mo = floor((t - yr)*12) + 1;
mname = names{mo};
end
