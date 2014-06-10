function [D,V,K] = DMFeature(Matrix,Dim)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is for constructing the feature space based on the
% diffusion matrix after t timpe step
% METHOD: eigen decomposition of the diffusion matrix
% INPUT:
% Matrix: diffusion matrix
% Dim: the final dimensionality of the feature space
% Written by Xi Wang
% 11/19/2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Heterogeneous 
%            Networks, Lecture Notes in Social Networks, 2014.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[V,D] = eigs(Matrix,Dim);
lambda = diag(D);
K = length(find(lambda>1));
% numNodes = size(Matrix,1);
% L = lambda(K,:) *ones(1,numNodes);
% feature  = L'.*V(:,K);
end