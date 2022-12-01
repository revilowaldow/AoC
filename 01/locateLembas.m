opts = delimitedTextImportOptions;
opts.EmptyLineRule = "read";
opts.VariableTypes = "double";
M = readmatrix("input.txt", opts);
index=find(~isnan(M));
idx=find(diff(index)~=1);
A=[idx(1);diff(idx);numel(index)-idx(end)];
B=mat2cell(M(~isnan(M)),A,1);
C=cellfun(@(x) sum(x(:)),B);
max(C)
D=sort(C);
sum(D(end-2:end))