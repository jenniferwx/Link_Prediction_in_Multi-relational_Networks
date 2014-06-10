function [Dist,Flow] = Dist_PropFlow(Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the link prediction score using 
% "inverse path distance" and "prop flow" methods on unweight/weighted networks
% Both methods are implemented using BFS algorithm in function <PathDistance>
% written by Xi Wang
% 02/08/2013
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Multi-relational 
%            Collaboration Networks, The 2013 IEEE/ACM International Conference on 
%            Advances in Social Networks Analysis and Mining(ASONAM), 2013. pp.1445-1447
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numNodes = size(Net,1);
Dist = zeros(numNodes,numNodes);
Flow = zeros(numNodes,numNodes);
for i = 1:numNodes
    [Dist(i,:) Flow(i,:)] = PathDistance(Net,i,'l',3);
end
end