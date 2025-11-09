% List of XML files
xmlFiles = {'1real_crossing_55_0.1.xml', '1real_crossing_55_0.05.xml', '1real_crossing_55_0.15.xml'};

allNumCars = cell(1, length(xmlFiles));
allTimes = cell(1, length(xmlFiles));

% Process each XML file
for i = 1:length(xmlFiles)
    [time, numCars] = processXmlFile(xmlFiles{i});
    allTimes{i} = time;
    allNumCars{i} = numCars;
end

% Reference time vector from first file
refTime = allTimes{1};
numFiles = length(xmlFiles);
numTimePoints = length(refTime);

numCarsMatrix = NaN(numFiles, numTimePoints);

% Align data and fill matrix
for i = 1:numFiles
    [~, idxInRef, idxInCurr] = intersect(refTime, allTimes{i});
    numCarsMatrix(i, idxInRef) = allNumCars{i}(idxInCurr);
end

% Calculate average number of cars ignoring NaNs
avgNumCars = nanmean(numCarsMatrix, 1);

% Plot average number of cars vs time
figure;
plot(refTime, avgNumCars, '-s', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Time (seconds)');
ylabel('Average Number of Cars');
title('Average Number of Cars Present vs Time across 3 XML Files');
grid on;

% Set X-axis ticks every 20 units
set(gca, 'XTick', min(refTime):20:max(refTime));

% Display average data in the command window
fprintf('\nTime vs Average Number of Cars\n');
fprintf('==============================\n');
fprintf('%10s %20s\n', 'Time', 'Average Cars');
fprintf('---------- --------------------\n');
for i = 1:length(refTime)
    fprintf('%10.3f %20.6f\n', refTime(i), avgNumCars(i));
end
fprintf('\n');

% === Generate SUMO-style XML file with averaged data ===
outputFilename = 'averaged_car_data_sumo.xml';
fid = fopen(outputFilename, 'w');
fprintf(fid, '<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid, '<states>\n');

for i = 1:length(refTime)
    fprintf(fid, '  <timestep time="%.2f" avgNumCars="%.6f"/>\n', refTime(i), avgNumCars(i));
end

fprintf(fid, '</states>\n');
fclose(fid);

fprintf('SUMO-style XML file "%s" has been created and saved in folder: %s\n', outputFilename, pwd);
