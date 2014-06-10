function Score = RA(testID,Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the link predict score using "Resource Allocation Index" method
% score(A,B) = sum(1/(|N(A)&&N(B)|))
% N(A) denotes the neighbors of node A
% testID: the ID of the testing node pairs
% Xi Wang
% 08/07/2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_test = size(testID,1);
Score = zeros(num_test,1);
I = unique(testID(:,1));
Num = length(I);
for i = 1:Num
    list = testID((testID(:,1)==I(i)),2); %index of links connecting node i
    list2 = find((testID(:,1)==I(i)));
    if(~isempty(list))
        A = repmat(Net(I(i),:),length(list),1);
        B = Net(list,:);
        IDX = logical(A) & logical(B);
        for j = 1:length(list)
            ID = find(IDX(j,:));
            if(~isempty(ID))
                Score(list2(j),:) = 1/sum(sum(Net(ID,:)));
            else
                Score(list2,:) = zeros(length(list2),1);
            end
        end
    end
    
end
