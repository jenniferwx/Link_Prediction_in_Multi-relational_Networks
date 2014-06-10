function [diff_matrix,Score] = DiffusionProcess(A_matrix,alpha,NR_ITERATIONS,testID)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is implemented for applying diffusion maps on weighted affinity
% matrix.
% INPUT: 
% A_matrix: the affinity matrix (weighted)
% alpha: dampling factor for random walk
% NR_ITERATIONS: number of interations for random walk
% testID: the IDs for the testing node pairs
%% Update Scheme:
% Wt+1 =alpha*(Wt)*T +(1-alpha)*T
% OUTPUT:
% Score: the link prediction scores of the testing node pairs after diffusion process
% diff_matrix: the final diffusion matrix
% written by by Xi Wang
% 11/11/2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Heterogeneous 
%            Networks, Lecture Notes in Social Networks, 2014.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Diffusion Process starts here
if(~exist('alpha','var'))
    alpha = 0.85;
end
% Maximum number of iterations
if(~exist('NR_ITERATIONS','var'))
    NR_ITERATIONS = 10;
end

numNodes = size(A_matrix,1);

% Build transition matrix 
Trans_matrix = ICG_MatNormalizeRow(A_matrix);
curr_mat = Trans_matrix;

% Save ranking to define the stopping criterion
old_ranks = curr_mat;
D = sum(curr_mat,1); %sum(A_matrix,1)./sum(sum(A_matrix));

num_of_changed = zeros(1,NR_ITERATIONS);
I = (1-alpha)*sparse(1:numNodes,1:numNodes,D,numNodes,numNodes);

for iter_nr = 1 : NR_ITERATIONS
    % Update step
    curr_mat = alpha*curr_mat*Trans_matrix +I;
    num_of_changed(iter_nr) = sum(sum(curr_mat-old_ranks));
    old_ranks = curr_mat;
end
% Final step of full diffusion
diff_matrix = curr_mat; 

% Calculate the prediction scores for testing node pairs. Since the final
% diffusion matrix is not symmetric, the prediction score of node pair (A,B) 
% is calulate by the multiplication of the corresponding entries [A,B] and
% [B,A] in diff_matrix
test_id1 = (testID(:,1)-1)*numNodes + testID(:,2);
test_id2 = (testID(:,2)-1)*numNodes + testID(:,1);
Score = diff_matrix(test_id1).*diff_matrix(test_id2);  
end


