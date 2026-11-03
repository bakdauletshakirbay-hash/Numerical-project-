%% MATH 351 Group Project, Fall 2026 - population of Kazakhstan
%  Runs all computational tasks. Results are printed to the Command
%  Window and also saved to results.txt; figures go to the folder figures/.
%  (Task 5 is a literature discussion and has no code.)

clear; clc; close all;
if exist('results.txt','file'), delete('results.txt'); end
diary('results.txt');

task1_interpolation
task2_backtesting
task3_sensitivity
task4_rootfinding
task6_rural
task7_urban

diary off
fprintf('\nDone. Output saved to results.txt, figures saved in figures/.\n');
