% Train your HMM model

clear all
close all

% Initialize your parameters like nClusters, nStates etc
init;

% Get the training filenames
loc = '../train/';
files = dir(loc);

% Remove first 2 filenames since they are '.' and '..'
files = files(3:end);

% Concatenate all matfiles
[allDataPoints,obsLength] = concatMatFiles(loc,files);

% Run Kmeans on all datapoints
disp('Clustering')
[idx,clusterCenters] = kmeans(allDataPoints,nClusters,'MaxIter',500);

% Decatenate the obtained idxs to respective observations
observations = decatMatFiles(idx,obsLength);

% Observe classwise kmeans clustering
plotHistogram(idx, obsLength, filesPerClass, nClasses)

% Save that file to prevent this computation again and again
save('observations.mat','observations');
close all

%% Expectation-Maximization
load('observations.mat');

% Initialize A,B & C
[Ainit,Binit,Cinit] = initHMMParams(nStates,nClusters);

% Compute optimal A,B and C
disp('Training model')
for class = 1:nClasses
    [A, B, C] = computeForwardBackwardAlgo(Ainit, Binit, Cinit, nStates, nClusters, observations, class, nClasses, filesPerClass);
    params(class).A = A;
    params(class).B = B;
    params(class).C = C;
end
save('parameters','params','clusterCenters');