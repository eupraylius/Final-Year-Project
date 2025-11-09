xmlFile1 = '1real_crossing_55_0.9.xml';
xmlFile2 = '1real_crossing_55_0.1.xml';

[time1, numCars1] = processXmlFile(xmlFile1);
[time2, numCars2] = processXmlFile(xmlFile2);

figure;
plot(time1, numCars1, '-o', 'LineWidth', 2, 'MarkerSize', 6, 'color', 'r');
hold on;
plot(time2, numCars2, '-x', 'LineWidth', 2, 'MarkerSize', 6);
hold off;
xlabel('Time (seconds)');
ylabel('Number of Cars');
title('Number of Cars Present vs Time for Two XML Files');
legend('0.9', '0.1');
grid on;

set(gca, 'XTick', min([time1; time2]):20:max([time1; time2]));
