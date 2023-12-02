clear
opts = delimitedTextImportOptions("NumVariables", 4);
opts.Delimiter = [",", "-"];
opts.VariableTypes = ["double", "double", "double", "double"];
input = readtable("input.txt", opts);
input = table2array(input);

%%

nPairs=length(input);
contained=false([nPairs 1]);
for i= 1:nPairs
    contained(i)= ((input(i,1)<=input(i,3))&(input(i,4)<=input(i,2)))|((input(i,3)<=input(i,1))&(input(i,2)<=input(i,4)));
end
nContained = sum(contained)

%%

ranges=cell([nPairs 4]);
for j = 1:nPairs
    ranges{j,1}=input(j,1):input(j,2);
    ranges{j,2}=input(j,3):input(j,4);
    ranges{j,3}=intersect(ranges{j,1},ranges{j,2});
    ranges{j,4}=~isempty(ranges{j,3});
end
nOverlap=sum([ranges{:,4}])