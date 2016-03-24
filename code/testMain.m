% Test your HMM model
clear all
close all

% Load parameters
load('./parameters.mat');

% Define the dictionary
dict = {'Beat3' 'Beat4' 'Circle' 'Eight' 'Infinity' 'Wave'}; 

% Load test data. Specify the folder
loc = './test/';
files = dir(loc);

% Remove first 2 row in this since they contain '.' and '..'
files = files(3:end);
nFiles = size(files,1);

for i = 1:nFiles
       
    % Load current file
    filename = strcat(loc,files(i).name);
    obsRaw = load(filename);
    
    % Truncate first column
    obsRaw = obsRaw(:,2:end);
    
    % Compute cluster assignment for obs
    obs = computeClusterAssignment(obsRaw, clusterCenters);
    
    % Compute likelihood
    [prediction,classProb] = hmmTest(obs, params);
    
    % Plot classProb
    bar(classProb)    

    % Display result
    disp(['True Label',files(i).name,' Predicted Label',dict(prediction)])
    set(gca, 'XTick', 1:6, 'XTickLabel', dict);
    title('Probabilities')
    disp('Hit enter to continue to next file')
    pause
end