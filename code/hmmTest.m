function [prediction,classProb] = hmmTest(obs, params)

% Compute probabilities of the given observation given the classes and
% predict the correct class
nClasses = size(params,2); 

for j = 1:nClasses
    prob(j) = computeForwardAlgo(obs, params(j));
end
[~,prediction] = max(prob);
prob = 1./prob;
classProb = prob./sum(prob);

end

