clear
opts = delimitedTextImportOptions("NumVariables", 2);
opts.VariableTypes = ["string", "string"];
opts.Delimiter = [":"];
input = readmatrix("02_input.txt",opts)
clear opts
%%

input = input(:,2);

R = regexp(input,'\d+(?= r)','match');
G = regexp(input,'\d+(?= g)','match');
B = regexp(input,'\d+(?= b)','match');

cellf1 = @(x) max(str2double(x));

Rmax = cellfun(cellf1,R, 'UniformOutput', false);
Gmax = cellfun(cellf1,G, 'UniformOutput', false);
Bmax = cellfun(cellf1,B, 'UniformOutput', false);
Rmax = vertcat(Rmax{:});
Gmax = vertcat(Gmax{:});
Bmax = vertcat(Bmax{:});

Games = 1:length(input);

Ans1 = sum(Games(Rmax<=12 & Gmax<=13 & Bmax<=14))

%%

Ans2 = sum(Rmax.*Gmax.*Bmax)
