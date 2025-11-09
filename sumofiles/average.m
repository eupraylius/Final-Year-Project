function [time, numCars] = processXmlFile(xmlFile)
    % Read and parse the XML file for car positions over time
    xmlDoc = xmlread(xmlFile);
    timesteps = xmlDoc.getElementsByTagName('timestep');
    numTimeSteps = timesteps.getLength;
    positionsMatrix = {};

    for i = 0:numTimeSteps-1
        timestep = timesteps.item(i);
        timeAttr = str2double(timestep.getAttribute('time'));
        if mod(timeAttr, 1) == 0 % adjust if you want different time filtering
            edges = timestep.getElementsByTagName('edge');
            posList = [];
            for j = 0:edges.getLength-1
                edge = edges.item(j);
                if strcmp(edge.getAttribute('id'), 'E1')
                    lanes = edge.getElementsByTagName('lane');
                    for k = 0:lanes.getLength-1
                        lane = lanes.item(k);
                        vehicles = lane.getElementsByTagName('vehicle');
                        for m = 0:vehicles.getLength-1
                            vehicle = vehicles.item(m);
                            posAttr = str2double(vehicle.getAttribute('pos'));
                            posList = [posList, posAttr];
                        end
                    end
                end
            end
            positionsMatrix{end+1} = [timeAttr, posList];
        end
    end

    % Convert cell array to uniform numeric matrix with NaN padding
    numFilteredSteps = numel(positionsMatrix);
    maxCols = max(cellfun(@length, positionsMatrix));
    positionsMatrixUniform = NaN(numFilteredSteps, maxCols);

    for i = 1:numFilteredSteps
        rowData = positionsMatrix{i};
        positionsMatrixUniform(i, 1:numel(rowData)) = rowData;
    end

    % Extract time and count number of cars
    time = positionsMatrixUniform(:, 1);
    positions = positionsMatrixUniform(:, 2:end);
    numCars = sum(~isnan(positions), 2);
end


% Main script to process three XML files and plot their averaged data

xmlFiles = {'1real_crossing_55_0.9.xml', '1real_crossing_55_0.05.xml', '1real_crossing_55_0.15.xml'}; % Change filenames as needed

allNumCars = cell(1, length(xmlFiles));
allTimes = cell(1, length(xmlFiles));

% Process each XML file
for i = 1:length(xmlFiles)
    [time, numCars] = processXmlFile(xmlFiles{i});
    allTimes{i} = time;
    allNumCars{i} = numCars;
end

% Reference time vector from the first file
refTime = allTimes{1};
numFiles = length(xmlFiles);
numTimePoints = length(refTime);

numCarsMatrix = NaN(numFiles, numTimePoints);

% Align and store data from all files
for i = 1:numFiles
    [~, idxInRef, idxInCurr] = intersect(refTime, allTimes{i});
    numCarsMatrix(i, idxInRef) = allNumCars{i}(idxInCurr);
end

% Calculate average number of cars ignoring missing data (NaN)
avgNumCars = mean(numCarsMatrix, 1, 'omitnan');

% Plot the averaged results
figure;
plot(refTime, avgNumCars, '-s', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Time (seconds)');
ylabel('Average Number of Cars');
title('Average Number of Cars Present vs Time across 3 XML Files');
grid on;

% Set X-axis ticks every 20 units for clarity
set(gca, 'XTick', min(refTime):20:max(refTime));

% Display the average values in the command window
disp(table(refTime, avgNumCars', 'VariableNames', {'Time', 'AverageNumberOfCars'}));
