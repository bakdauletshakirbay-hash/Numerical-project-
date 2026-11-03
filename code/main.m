%% MATH 351 Group Project - population of Kazakhstan
clear; clc; close all;
cd(fileparts(mfilename('fullpath')));
resultsFile = fullfile(fileparts(pwd), 'results.txt');
if exist(resultsFile,'file'), delete(resultsFile); end
diary(resultsFile);

task1_interpolation
task2_backtesting
task3_sensitivity
task4_rootfinding
task6_rural
task7_urban

diary off
fprintf('\nDone. Output saved to results.txt and figures/ (next to the code folder).\n');
