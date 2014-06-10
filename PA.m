function Score = PA(testID,Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the link prediction score using "preferential attachment (PA)"
% score(A,B) = |Degree(A)|*|Degree(B)|
% where Degree(A) is the degree of node A
% % Input:
% 1)testID: the ID of the testing node pairs
% 2)Net: the adjacency matrix of the nentwork
% % Output:
% The prediction score of the testing nodes
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by Xi Wang
% 06/04/2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s_degree = sum(Net,2);
Score = s_degree(testID(:,1)).*s_degree(testID(:,2));

end