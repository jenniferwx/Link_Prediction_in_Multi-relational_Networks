function Score = DiffusionMaps(Net,testID, diff_matrix, Dim)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the link prediction score using Diffusion Maps
% INPUT:
% diff_matrix: the diffusion matrix returned by "DiffuionProcess.m"
% testID: the IDs of the testing node pairs
% Dim: ithe dimesionality of the embedded space after embedding
% diffusion maps
% OUTPUT:
% Score: the link prediction scores of testing node pairs
% Xi Wang
% 11/25/2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Heterogeneous 
%            Networks, Lecture Notes in Social Networks, 2014.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numNodes = size(Net,1);
numTest = size(testing,1);
[D,V,K] = DMFeature(diff_matrix,Dim);
lambda = diag(D);
L = lambda(1:Dim,:) *ones(1,numNodes);
feature  = L'.*V(:,1:Dim);
Score = zeros(numTest,1);
D = pdist(feature);
Dist = sparse(squareform(D));
for i = 1:numTest
    Score(i,:) = Dist(testID(i,1),testID(i,2));
end
end