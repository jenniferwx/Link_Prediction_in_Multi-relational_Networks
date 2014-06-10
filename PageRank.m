function score = PageRank(G,testID,p)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the link preidction score using PageRank method
% pagerank(G,p) uses the adjacency matrix G with a damping factory p, 
% (default is .85) to compute PageRank score of each nodes in the network
% testID is the IDs of the testing node pairs
% written by Xi Wang
% 03/2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(~exist('p','var'))
    p = 0.85; % the default damping factor p is 0.85
end
% Eliminate any self-referential links

G = G - diag(diag(G));
[n,n] = size(G);
c = sum(G,1);
r = sum(G,2);

% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);

e = ones(n,1);

G = p*G*D;
z = ((1-p)*(c~=0) + (c==0))/n;

PR = ones(n,1)/n;
PRprev = 1;

while sum(abs(PRprev-PR)) > 0.00001
    PRprev = PR;
    PR = G*PR + e*(z*PR);
end
% Normalize so that sum(PR) == 1.
PR = PR/sum(PR);
% calculate the prediction score of given testing node pairs
score = PR(testID(:,1)*PR(testID(:,2)));
