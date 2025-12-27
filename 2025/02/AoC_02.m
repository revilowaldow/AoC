clear

%% Import

opts = delimitedTextImportOptions;
opts.LineEnding = ",";
opts.Delimiter = "-";
opts.VariableNames = ["ID1", "ID2"];
opts.VariableTypes = ["double","double"];
input = readmatrix("02_input.txt",opts)

%% Answer 1

suminvalid = 0;

for i = 1:height(input)
    ids = input(i,1):input(i,2);
    for j = ids
        sj = char(string(j));
        len = floor(length(sj) / 2);
        if string(sj(1:len)) == string(sj(len+1:end))
            suminvalid = suminvalid + j;
        end
    end
end

Part1 = sprintf('%16.f',suminvalid)

%% Answer 2

suminvalid = 0;

for i = 1:height(input)
    ids = input(i,1):input(i,2);
    for j = ids
        sj = char(string(j));
        len = length(sj);
        for seclen = 1:floor(len/2)
            if mod(len,seclen) == 0
                if string(repmat(sj(1:seclen), 1, len / seclen)) == string(sj)
                    suminvalid = suminvalid + j;
                    break % fuck this in particular
                end
            end
        end
    end
end

Part2 = sprintf('%16.f',suminvalid)

