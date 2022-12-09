clear
% input = [3,0,3,7,3;2,5,5,1,2;6,5,3,3,2;3,3,5,4,9;3,5,3,9,0] % Example
input = str2double(readmatrix('input.txt',fixedWidthImportOptions('VariableNames',cellstr(string(1:99)))))

%%

len = length(input);
treesVisible = false([len len 4]);
for i = 1:4 %directions
    for j = 1:len
        treesVisible([true; diff(cummax(input(:,j)),1)>0],j,i)=true;
    end
    treesVisible = rot90(treesVisible);
    input = rot90(input);
end
nVisibleTrees = sum(sum(any(treesVisible,3)))

%%

scores = zeros(len);
for k = 2:len-1
    for m = 2:len-1
        treeHeight = input(k,m);
        leftMax   = checkEdge(rot90(input(k,1:m-1),  1),treeHeight);
        rightMax  = checkEdge(rot90(input(k,m+1:len),3),treeHeight);
        topMax    = checkEdge(rot90(input(1:k-1,m),  2),treeHeight);
        bottomMax = checkEdge(      input(k+1:len,m)   ,treeHeight);
        scores(k,m)=prod([leftMax rightMax topMax bottomMax]);
    end
end
maxScore = max(max(scores))

%%

function maxHeight = checkEdge(direction,treeHeight)
if all(~(direction>=treeHeight))
    maxHeight = length(direction);
else
    maxHeight = find(direction>=treeHeight,1);
end
end