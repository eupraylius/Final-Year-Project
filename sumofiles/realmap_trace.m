% Load the XML file
xmlFile = '1real_crossing_55_0.9.xml'; % Replace with your XML filename
xmlDoc = xmlread(xmlFile);

% Get all timestep elements
timesteps = xmlDoc.getElementsByTagName('timestep');
numTimeSteps = timesteps.getLength;
positionsMatrix = {}; % Initialize empty cell array

% Loop through timesteps
for i = 0:numTimeSteps-1
    timestep = timesteps.item(i);
    timeAttr = str2double(timestep.getAttribute('time')); % Convert time to numeric

    % Only process if time is a multiple of 50
    if mod(timeAttr, 1) == 0
        % Get edge elements within the timestep
        edges = timestep.getElementsByTagName('edge');

        posList = []; % Initialize position list for current timestep

        for j = 0:edges.getLength-1
            edge = edges.item(j);
            if strcmp(edge.getAttribute('id'), 'E1') % Check for edge "E1"

                % Get all lanes inside edge E1
                lanes = edge.getElementsByTagName('lane');

                for k = 0:lanes.getLength-1
                    lane = lanes.item(k);

                    % Get all vehicles inside the lane
                    vehicles = lane.getElementsByTagName('vehicle');

                    for m = 0:vehicles.getLength-1
                        vehicle = vehicles.item(m);
                        posAttr = str2double(vehicle.getAttribute('pos')); % Convert position to numeric
                        posList = [posList, posAttr]; % Append position
                    end
                end
            end
        end

        % Store in matrix
        positionsMatrix{end+1} = [timeAttr, posList]; % Time in first column, positions in the remaining columns
    end
end

% Convert cell array to numerical array (pad with NaN if needed for uniformity)
numFilteredSteps = numel(positionsMatrix);
maxCols = max(cellfun(@length, positionsMatrix)); % Find max number of positions across filtered timesteps
positionsMatrixUniform = NaN(numFilteredSteps, maxCols); % Initialize uniform matrix

for i = 1:numFilteredSteps
    rowData = positionsMatrix{i};
    positionsMatrixUniform(i, 1:numel(rowData)) = rowData;
end

% Display results
disp('Filtered Time vs Vehicle Positions Matrix (Time % 20 == 0):');
disp(positionsMatrixUniform);
car_position = positionsMatrixUniform;


% Assuming your matrix is stored in 'car_position'
% First column = time, remaining columns = car positions

% Extract time and positions
time = car_position(:,1);
positions = car_position(:,2:end);

% Count cars (non-NaN values) for each time step
numCars = zeros(size(car_position,1), 1); % Initialize counter array

for i = 1:size(positions,1)
    % Count non-NaN values in each row
    numCars(i) = sum(~isnan(positions(i,:)));
end

% Display results
fprintf('Time (s)\tNumber of Cars\n');
fprintf('--------\t--------------\n');
for i = 1:length(time)
    fprintf('%.1f\t\t%d\n', time(i), numCars(i));
end

% Plot number of cars vs time
figure;
plot(time, numCars, '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Time (seconds)');
ylabel('Number of Cars');
title('Number of Cars Present vs Time');
grid on;

% Set X-axis ticks every 60 seconds (for older MATLAB)
set(gca, 'XTick', min(time):20:max(time));

