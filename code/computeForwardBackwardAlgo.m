function [Aopt, Bopt, Copt] = computeForwardBackwardAlgo(Ainit, Binit, Cinit, nStates, nClusters, observations, classNum, nClasses, filesPerClass)

% Compute Forward Backward Algo

fileRange = (classNum-1)*filesPerClass+1:classNum*filesPerClass;

% Start the algo
for files = 1:filesPerClass
    
    % Extract current files
    curFileNum = fileRange(files);
    
    A = Ainit;    
    B = Binit;
    C = Cinit;
    
    % Current observations
    obs = observations(curFileNum).samples;
    T = size(obs,1);
    
    % Forward algorithm
    for iter = 1:30
        
        
        % Initialize alpha1
        alpha = zeros(nStates,T);
        alpha(:,1) = C.*B(:,obs(1));
        ct = 1./sum(alpha(:,1));
        alpha(:,1) = ct.*alpha(:,1);
        allct = zeros(T,1);
        allct(1) = ct;


        for i = 1:T-1
            newObs = obs(i+1);
            alpha(:,i+1) = (alpha(:,i)'*A)'.*B(:,newObs);

            % Normalize to prevent underflow
            ct = 1./sum(alpha(:,i+1));
            alpha(:,i+1) = ct.*alpha(:,i+1);            

            % Log Cts
            allct(i+1) = ct;
        end

        % Backward algorithm
        beta = zeros(nStates,T);
        beta(:,end) = ones(nStates,1);
        cs = 1./sum(beta(:,end));
        beta(:,end) = cs.*beta(:,end);
        allcs = zeros(T,1);
        allcs(end) = cs;

        for i = T-1:-1:1
            newObs = obs(i+1);
            beta(:,i) = ((B(:,newObs).*beta(:,i+1))'*A')';

            % Normalize to prevent underflow
            cs = 1./sum(beta(:,i));
            beta(:,i) = beta(:,i).*cs;
            allcs(i) = cs;     
            
            % Compute eta
            eta(:,:,i) = (alpha(:,i)*(B(:,newObs).*beta(:,i+1))').*A;
            sumEta = sum(sum(eta(:,:,i)));
            eta(:,:,i) = eta(:,:,i)./sumEta;
                      
        end
    
    % Compute gamma
    gamma = alpha.*beta;
    sumGamma = sum(gamma);
    gamma = bsxfun(@rdivide,gamma,sumGamma); 
    
    % Update A,B and C
    C = gamma(:,1);
    
    for i = 1:nClusters
        [ind,~] = find(obs==i);
        if isempty(ind)
            continue
        end
        B(:,i) = sum(gamma(:,ind),2)./sum(gamma,2);
        B(:,i) = B(:,i)./sum(B(:,i));
    end

    A = sum(eta,3)./repmat(sum(gamma(:,1:end-1),2),[1 nStates]);
    if sum(sum(A,2))>nStates
        [rows,~] = find(sum(A,2)>1);
        A(rows,:) = bsxfun(@rdivide,A(rows,:),sum(A(rows,:),2));
    end
    
    % Save and plot log probability
    a(iter) = -sum(log(allct));
    plot(a)
    drawnow
    grid on 
    axis on
    
    end
    pause
    close all
    allA(:,:,files) = A;
    allB(:,:,files) = B;
    allC(:,files) = C;
end
Aopt = sum(allA,3)./filesPerClass;
Bopt = sum(allB,3)./filesPerClass;
Copt = sum(allC,2)./filesPerClass;

end

