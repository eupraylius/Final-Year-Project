% Average Throughput vs Vehicular Density
clc;
clear;
close all;

% Data
density = {'10-19','20-29','30-39','40-49','50-59', ...
           '60-69','70-79','80-89','90-99'};

throughput = [10.83, 10.57, 10.20, 10.58, 10.09, ...
              10.58, 10.74, 11.37, 10.02];

% Create figure
figure;

% Plot graph
plot(1:length(throughput), throughput, '-o', ...
    'Color', 'blue', ...
    'LineWidth', 3, ...
    'MarkerSize', 12, ...
    'MarkerFaceColor', 'blue');

hold on;

% Axis labels
xticks(1:length(density));
xticklabels(density);

ylim([9.5 12]);
yticks([9.5 10 10.5 11 11.5 12]);

% Titles and labels
title('Average Throughput vs Vehicular Density', ...
      'FontWeight', 'bold');

xlabel('Vehicle Density Range (Vehicles)', ...
       'FontWeight', 'bold');

ylabel('Average Throughput (Mbps)', ...
       'FontWeight', 'bold');

% Grid
grid on;

% Light gray background
set(gca, 'Color', [0.94 0.94 0.94]);

% Figure size
set(gcf, 'Position', [100 100 1000 500]);

hold off;
