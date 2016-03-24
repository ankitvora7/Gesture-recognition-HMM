function [A,B,C] = initHMMParams(nStates,nObs)

% Initialize HMM params
% % Initialize A
% a = 0.9*ones(1,nStates);
% A = diag(a);
% A(nStates,nStates) = 1;
% for i = 1:nStates-1
%     A(i,i+1) = 0.1;
% end

A = rand(nStates);
A = bsxfun(@rdivide,A,sum(A,2));

% Initialize B
B = rand(nStates,nObs);
sumB = sum(B);
B = bsxfun(@rdivide,B,sumB);

% B = ones(nStates,nObs);
% B = bsxfun(@rdivide,B,sum(B));

% Initialize C
C = rand(nStates,1);
C = C./sum(C);

% C = ones(nStates,1);
% C = bsxfun(@rdivide,C,sum(C));

end