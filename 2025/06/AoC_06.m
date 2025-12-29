clear

%% Import

opts = delimitedTextImportOptions;
opts.Delimiter = " ";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";
input = readmatrix("06_inputDemo.txt", opts);
input(:,end) = []

%% Answer 1

addcols = input(:, strcmp(input(end,:), '+'));
addcols(end,:) = [];
added = sum(str2double(addcols),"all");

multcols = input(:, strcmp(input(end,:), '*'));
multcols(end,:) = [];
multiplied = sum(prod(str2double(multcols)));

Part1 = sprintf('%16.f', added + multiplied)


%% Answer 2

input2 = char(strsplit(fileread("06_input.txt"),{'\r\n'}))';

total = 0;

for i = 1:length(input2)
    if input2(i,end) == '+'
		mode = "add";
        working = [str2num(input2(i,1:end-1))];
	elseif input2(i,end) == '*'
		mode = "mult";
        working = [str2num(input2(i,1:end-1))];
	elseif isspace(input2(i,:))
        if mode == "mult"
            total = total + prod(working);
        else
            total = total + sum(working);
        end
    else
        working = [working str2num(input2(i,1:end-1))];
    end
end

if mode == "mult" %Could add a fake end row instead to simplify code
    total = total + prod(working);
else
    total = total + sum(working);
end

Part2 = sprintf('%16.f', total)