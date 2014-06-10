function Score = CN(testID,Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the link prediction score using "Common Neighbors(CN)"
% score(A,B) = N(A) && N(B)
% N(A) denotes the neighbors of node A
% Xi Wang
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
        Score(list2,:) = sum(IDX,2);
    end
end

end