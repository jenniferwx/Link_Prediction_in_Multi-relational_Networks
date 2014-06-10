function Score = weighted_JC(testID,Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predict the links according to "Jaccard's coefficient(JC)" on weighted networks
% Xi Wang
% 08/09/2012
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Multi-relational 
%            Collaboration Networks, The 2013 IEEE/ACM International Conference on 
%            Advances in Social Networks Analysis and Mining(ASONAM), 2013. pp.1445-1447
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        Tmp1 = zeros(size(A));
        Tmp1(IDX) = T(IDX);
        Tmp2 = sum(T,2);
        Score(list2,:) = sum(Tmp1,2)./Tmp2;
    end
end
a = isnan(Score);
Score(a) = 0;
end
