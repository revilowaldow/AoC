clear
input = readlines('03_input.txt')

%%

%padding = repmat('.',length(input)+2,length(input)+2)

outer = length(input)+2;

padrow = repmat('.',1,outer);

big = char(vertcat(padrow,pad(input,outer,"both",'.'),padrow));

symbols = unique(big);
symbols = symbols((symbols ~= '.') & ~isstrprop(symbols,'digit'));



numbers = regexp(string(big),'(\d+)','tokenExtents');

parts = [];
for i = 1:outer
    num = numbers(i);
    num = num{:};
    [minN, maxN] = size(num);
    if minN ~=0
        for j = 1:maxN
            coords = [num{j}];
            context = big(i-1:i+1,coords(1)-1:coords(2)+1);
            if any(contains(string(context),string(symbols)))
                parts = [parts; i coords];
            end
        end
    end
end
BOM=[];

for i = 1:length(parts)
    BOM = [BOM; str2double(big(parts(i,1),parts(i,2):parts(i,3)))];
end

Ans1 = sum(BOM)

%%
clear
% Lets try a cell aray and dictionaries instead
fid = fopen('03_input.txt', 'r');
data = textscan(fid, '%s', 'Delimiter', '\n');
data = data{1};
fclose(fid);

%%
curNum = '';
match = [];
total = 0;
gears = {};
result = containers.Map;

for lineNum = 1:numel(data)
    lineData = data{lineNum};
    for pos = 1:length(lineData)
        if regexp(lineData(pos), '\d')
            curNum = [curNum, lineData(pos)];
            for y = lineNum-1:lineNum+1
                if y >= 1 && y <= numel(data)
                    for x = pos-1:pos+1
                        if x >= 1 && x <= length(data{y})
                            if regexp(data{y}(x), '\*')
                                match = [y, x];
                            end
                        end
                    end
                end
            end
        else
            if ~isempty(match)
                gearKey = [num2str(match(1)), 'X', num2str(match(2))];
                if isKey(result, gearKey)
                    result(gearKey) = result(gearKey) * str2double(curNum);
                    gears{end+1} = gearKey;
                else
                    result(gearKey) = str2double(curNum);
                end
                match = [];
            end
            curNum = '';
            continue;
        end
    end
end

for gearIdx = 1:numel(gears)
    gear = gears{gearIdx};
    total = total + result(gear);
end

Ans2 = total
