clear
opts = delimitedTextImportOptions("NumVariables", 2);
%opts.DataLines = [1, Inf];
opts.Delimiter = " ";
opts.ConsecutiveDelimitersRule = "join";
opts.VariableTypes = ["double", "double"];
x01_input = readtable("01_input.txt", opts);

Ans1 = sum(abs(sort(x01_input.Var1)-sort(x01_input.Var2)))

similarity = 0;
for i=1:height(x01_input)
    similarity = similarity + (x01_input.Var1(i) * sum(x01_input.Var1(i)==x01_input.Var2));
end

Ans2 = similarity
