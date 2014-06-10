function Score = weighted_AA(testID,Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predict the links according to "Adamic/Adar(AA)" on weighted networks
% Written by Xi Wang
% 06/05/2012
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Multi-relational 
%            Collaboration Networks, The 2013 IEEE/ACM International Conference on 
%            Advances in Social Networks Analysis and Mining(ASONAM), 2013. pp.1445-1447
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_test = size(testID,1);
Score = zeros(num_test,1);
I = unique(testID(:,1));
Num = length(I);
for i = 1:Num
    list = testID((testID(:,1)==I(i)),2); %index of links connecting node i
    list2 = find(testID(:,1)==I(i));
    if(~isempty(list))
        A = repmat(Net(I(i),:),length(list),1);
        B = Net(list,:);
        IDX = logical(A) & logical(B);
        for j = 1:length(list)
            ID = IDX(j,:);
            Score(list2(j),:) = sum(sum(A(j,IDX(j,:)) + B(j,IDX(j,:)))/log(1+sum(Net(ID,:),2)));
        end
    end
end

end
