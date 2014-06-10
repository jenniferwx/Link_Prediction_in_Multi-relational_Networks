function Score = weighted_CN(testID,Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predict the links according to "Common Neighbors(CN)" on weighted network
% score(A,B) = \sum_z{w(A,z) + w(B,z)}
% where z in N(A) && N(B)
% Xi Wang
% 08/09/2012
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Multi-relational 
%            Collaboration Networks, The 2013 IEEE/ACM International Conference on 
%            Advances in Social Networks Analysis and Mining(ASONAM), 2013. pp.1445-1447
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Net is the new network structure deleting the testing links
num_test = size(testID,1);
Score = zeros(num_test,1);
I = unique(testID(:,1));
Num = length(I);
for i = 1:Num
    list = testID((testID(:,1)==I(i)),2); %index of links connecting node i
    list2 = (testID(:,1)==I(i));
    if(~isempty(list))
        A = repmat(Net(I(i),:),length(list),1);
        B = Net(list,:);
        IDX = logical(A) & logical(B);
        T = A+B;
        Tmp = zeros(size(A));
        Tmp(IDX) = T(IDX);
        Score(list2,:) = sum(Tmp,2);
    end
end
end