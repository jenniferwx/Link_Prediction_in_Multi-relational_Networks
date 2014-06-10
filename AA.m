function Score = AA(testID,Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the link predict score using "Adamic/Adar(AA)" method
% score(A,B) = sum(1/log(|N(A)&&N(B)|))
% N(A) denotes the neighbors of node A
% % Input:
% 1)testID: the ID of the testing node pairs
% 2)Net: the adjacency matrix of the nentwork
% % Output:
% The prediction score of the testing nodes
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by Xi Wang
% 06/05/2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_test = size(testID,1);
Score = zeros(num_test,1);
I = unique(testID(:,1));
Num = length(I);
for i = 1:Num
    list = testID((testID(:,1)==I(i)),2); %index of links connecting node i
    list2 = find((testID(:,1)==I(i)));
    if(~isempty(list))
        tmp = repmat(Net(I(i),:),length(list),1);
        IDX = logical(tmp) & logical(Net(list,:));
        for j = 1:length(list2)
            ID = IDX(j,:);
            Score(list2(j),:) = sum(1./log(sum(Net(ID,:),2))); 
        end
    end
end
end
