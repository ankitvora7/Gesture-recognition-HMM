function obs = computeClusterAssignment(obsRaw, clusterCenters)

% Compute the cluster assignment of the observations given
obs = knnsearch(clusterCenters,obsRaw);


end

