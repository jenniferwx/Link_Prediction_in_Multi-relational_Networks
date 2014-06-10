function Score = JC(testID,Net)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the prediction score using "Jaccard's coefficient(JC)"
% score(A,B) = (N(A)&&N(B))/(N(A)||N(B))
% N(A):neighbors of node A
% Input:
% 1)testID: the ID of the testing node pairs
% 2)Net: the adjacency matrix of the nentwork
% written by Xi Wang
% 06/05/2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_test = size(testID,1);
Score = zeros(num_test,1);
I = unique(testID(:,1));
Num = length(I);
for i = 1:Num 
    list = testID((testID(:,1)==I(i)),2); 
    list2 = find((testID(:,1)==I(i)));
    if(~isempty(list))
        tmp = repmat(Net(I(i),:),length(list),1);
        IDX = logical(tmp) & logical(Net(list,:));
        IDX2 = logical(tmp) | logical(Net(list,:));
        Score(list2,:) = sum(IDX,2)./sum(IDX2,2);
        id = find(sum(IDX2,2)==0);
        if(~isempty(id))
            Score(list2(id),:) = zeros(length(id),1);
        end
        clear IDX IDX2 id
    end
end
end
