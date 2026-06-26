% Average End-to-End Delay vs Vehicular Density
clc;
clear;
close all;

% Data
density = {'10-19','20-29','30-39','40-49','50-59', ...
           '60-69','70-79','80-89','90-99'};

delay = [54.6, 57.5, 56.4, 54.0, 52.0, ...
         57.4, 56.0, 53.2, 54.2];

% Plot
figure;

plot(1:length(delay), delay, '-s', ...
    'Color', 'red', ...
    'LineWidth', 3, ...
    'MarkerSize', 12, ...
    'MarkerFaceColor', 'red');

% Axes settings
xticks(1:length(density));
xticklabels(density);

ylim([50 60]);
yticks(50:2:60);

% Labels and title
title('Average End-to-End Delay vs Vehicular Density', ...
      'FontWeight', 'bold');

xlabel('Vehicle Density Range (Vehicles)', ...
       'FontWeight', 'bold');

ylabel('Average End-to-End Delay (ms)', ...
       'FontWeight', 'bold');

% Grid
grid on;

% Background color
set(gca, 'Color', [0.94 0.94 0.94]);

% Figure size
set(gcf, 'Position', [100 100 1000 500]);
