function [time, numCars] = processXmlFile(xmlFile)
    xmlDoc = xmlread(xmlFile);
    timesteps = xmlDoc.getElementsByTagName('timestep');
    numTimeSteps = timesteps.getLength;
    positionsMatrix = {};

    for i = 0:numTimeSteps-1
        timestep = timesteps.item(i);
        timeAttr = str2double(timestep.getAttribute('time'));
        if mod(timeAttr, 1) == 0
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

    numFilteredSteps = numel(positionsMatrix);
    maxCols = max(cellfun(@length, positionsMatrix));
    positionsMatrixUniform = NaN(numFilteredSteps, maxCols);

    for i = 1:numFilteredSteps
        rowData = positionsMatrix{i};
        positionsMatrixUniform(i, 1:numel(rowData)) = rowData;
    end

    time = positionsMatrixUniform(:,1);
    positions = positionsMatrixUniform(:,2:end);
    numCars = sum(~isnan(positions), 2);
end
