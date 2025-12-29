clear

%% Import
input = string(strsplit(fileread("03_input.txt"),{'\r\n'}));


%% Answer 1

joltage = 0;

for i = 1:length(input)
    start = input{i}(1:end-1);
    d1 = char(max(start));
    back = input{i}(regexp(start, d1, 'once')+1:end);
    d2 = char(max(back));
    joltage = joltage + str2num([d1 d2]);
end

Part1 = joltage

%% Answer 2

joltage = 0;
cells = 12;

for i = 1:length(input)
    digits = [];
    lastpos = 0;
    for j = 1:cells
        sub = input{i}(lastpos+1:end-cells+j);
        digits = [digits char(max(sub))];
        lastpos = regexp(sub, digits(end), 'once') + lastpos;
    end
    joltage = joltage + str2num(digits);
end

Part2 = sprintf('%16.f',joltage)
