clear
dirs = readlines('08_input.txt');
dirs = char(dirs(1))

opts = delimitedTextImportOptions("NumVariables", 3);
opts.DataLines = [3, Inf];
opts.Delimiter = [" ", "(", ")", ",", "="];
opts.VariableTypes = ["string", "string", "string"];
opts.ConsecutiveDelimitersRule = "join";
opts.ExtraColumnsRule = "ignore";
input = readmatrix("08_input.txt", opts)

%%
dirs = strrep(dirs, 'L', '2');
dirs = strrep(dirs, 'R', '3');

loc = "AAA";
circ = 0;
steps = 0;
while loc ~= "ZZZ"
    steps = steps + 1;
    circ = mod(circ, numel(dirs)) + 1;
    tup = input(input(:,1)==loc,:);
    loc = tup(1,str2double(dirs(circ)));
end

Ans1 = steps

%%

p2 = input(contains(input(:,1),regexpPattern('A$')),:);
lcms = zeros(1, length(p2));
circ = 0;
for i = 1:length(p2)
    loc = p2(i,1);
    steps = 0;
    while ~contains(loc,regexpPattern('Z$'))
        steps = steps + 1;
        circ = mod(circ, numel(dirs)) + 1;
        tup = input(input(:,1)==loc,:);
        loc = tup(1,str2double(dirs(circ)));
    end
    lcms(i)=steps;
end

Ans2 = lcm(sym(lcms))
