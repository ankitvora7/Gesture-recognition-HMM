function prob = computeForwardAlgo(obs, params)

% Compute log likelihood of P(O|params)
A = params.A;
B = params.B;
C = params.C;
nStates = size(A,1);
T = size(obs,1);

% Initialize alpha1
alpha = zeros(nStates,T);
alpha(:,1) = C.*B(:,obs(1));
ct = 1./sum(alpha(:,1));
alpha(:,1) = alpha(:,1).*ct;
allct = zeros(T,1);
allct(1) = ct;


for i = 1:T-1
    newObs = obs(i+1);
    alpha(:,i+1) = (alpha(:,i)'*A)'.*B(:,newObs);
    
    % Normalize to prevent underflow
    ct = 1./sum(alpha(:,i+1));
    alpha(:,i+1) = alpha(:,i+1).*ct;
    
    % Log Cts
    allct(i+1) = ct;
end
prob = -sum(log(allct));

end

