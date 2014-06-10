function Score = weighted_PA(testID,Net)
%% predict the links according to "preferential attachment (PA)"
% score(A,B) = |tau(A)|*|tau(B)|
% tau(A) is the degree of node A
% Xi Wang
% 06/04/2012
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Multi-relational 
%            Collaboration Networks, The 2013 IEEE/ACM International Conference on 
%            Advances in Social Networks Analysis and Mining(ASONAM), 2013. pp.1445-1447
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s_degree = sum(Net,2);
Score = s_degree(testID(:,1)).*s_degree(testID(:,2));

end

