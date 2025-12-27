clear

%% Import
opts = fixedWidthImportOptions("NumVariables", 2);
opts.VariableWidths = [1,3];
opts.VariableNames = ["L1", "L2"];
opts.VariableTypes = ["string","double"];
input = readtable("01_input.txt", opts);

for i = 1:height(input)
    if input{i,1} == "L"
        mat(i) = - input{i,2};
    else
        mat(i) = input{i,2};
    end
end

mat = mat';

%% Answer 1

pos = 50;
count = 0;
for i = 1:height(mat)
    pos = pos + mat(i);
    if mod(pos,100) == 0
        count = count + 1;
    end
end
Part1 = count


%% Answer 2

pos = 50;
count = 0;
for i = 1:height(mat)
    for j = 1:abs(mat(i))
        pos = pos + (1 * sign(mat(i)));
        if mod(pos,100) == 0
            count = count + 1;
        end
    end
end
Part2 = count

