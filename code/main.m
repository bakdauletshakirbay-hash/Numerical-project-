%% MATH 351 Group Project - population of Kazakhstan
clear; clc; close all;
cd(fileparts(mfilename('fullpath')));
if exist('results.txt','file'), delete('results.txt'); end
diary('results.txt');

task1_interpolation
task2_backtesting
task3_sensitivity
task4_rootfinding
task6_rural
task7_urban

diary off
fprintf('\nDone. Results saved to:\n  %s\n  %s\n', ...
        fullfile(pwd,'results.txt'), fullfile(pwd,'figures'));
