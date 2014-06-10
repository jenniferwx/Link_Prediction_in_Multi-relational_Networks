function score = weighted_PageRank(G0,testID,p)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the link preidction score using PageRank method
% pagerank(G,p) uses the adjacency matrix G0 with a damping factory p, 
% (default is .85) to compute PageRank score of each nodes in the network
% testID is the IDs of the testing node pairs
% written by Xi Wang
% 03/2013
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Multi-relational Collaboration Networks, 
%            The 2013 IEEE/ACM International Conference on Advances in Social Networks Analysis and Mining 
%            (ASONAM), 2013. pp. 1445-1447
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if nargin < 3, p = .85; end
if(~exist('p','var'))
    p = 0.85; % the default damping factor p is 0.85
end

numNodes = size(G0,1);
% Get the unweighted network
G = double(G0 | sparse(numNodes,numNodes));

% calculate the weight for the nodes in the network
w = sum(G0,1)/sum(sum(G0));
% Eliminate any self-referential links
G = G - diag(diag(G));
  
% c = out-degree, r = in-degree
[n,n] = size(G);
c = sum(G,1);
r = sum(G,2);

% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);

% Solve (I - p*G*D)*x = e

e = ones(n,1);

G = p*G*D;
z = ((1-p)*(c~=0) + (c==0))/n;

PR = ones(n,1)/n;
PRprev = 1;

z0 = z.*w;
while sum(abs(PRprev-PR)) > 0.00001
    PRprev = PR;
%     x = G*x + e*(z*x);
    PR = G*PR + z0';
end

% Normalize so that sum(PR) == 1.
PR = PR/sum(PR);
% calculate the prediction score of given testing node pairs
score = PR(testID(:,1)*PR(testID(:,2)));
