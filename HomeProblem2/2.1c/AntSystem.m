%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = length(cityLocation);
alpha = 1.0;        % To do: Set to appropriate value.
beta = 5.0;         % To do: Set to appropriate value.
rho = 0.5;          % To do: set to appropriate value.

% To do: Write the GetNearestNeighbourPathLength function
nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation);
tau0 = numberOfAnts/nearestNeighbourPathLength;

targetPathLength = 123.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0);
visibility = GetVisibility(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iIteration = 0;
bestPath = [];

while (iIteration <= 2000)
 iIteration = iIteration + 1;

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Generate paths:
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 pathCollection = [];
 pathLengthCollection = [];
 for k = 1:numberOfAnts
  path = GeneratePath(pheromoneLevel, visibility, alpha, beta);   % To do: Write the GeneratePath function (and any necessary functions called by GeneratePath).
  pathLength = GetPathLength(path,cityLocation);
  if (pathLength < minimumPathLength)
    minimumPathLength = pathLength;
    disp(sprintf('Iteration %d, ant %d: path length = %.5f',iIteration,k,minimumPathLength));
    PlotPath(connection,cityLocation,path);
    bestPath = path;
  end
  pathCollection = [pathCollection; path];           
  pathLengthCollection = [pathLengthCollection; pathLength];
 end

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Update pheromone levels
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);  % To do: write the ComputeDeltaPheromoneLevels function
 pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);          % To do: write the UpdatePheromoneLevels function
end






