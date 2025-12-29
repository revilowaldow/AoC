clear

%% Import

input = readlines("05_input.txt");

%% Answer 1

ingredients = [];
limset = [];
fresh = [];
for i = 1:length(input)
    if contains(input{i},"-")
        limset = [limset; str2double(strsplit(input{i},'-'))];
    elseif input{i} ~= ""
        ingredients = [ingredients; str2double(input{i})];
    end
end

for i = 1:length(limset)
    for j = 1:length(ingredients)
        if ingredients(j) <= limset(i,2) && ingredients(j) >= limset(i,1)
            fresh = [fresh, ingredients(j)];
        end
    end
    clear range
end

Part1 = length(unique(fresh))


%% Answer 2

ingredients = [];
limset = [];
for i = 1:length(input)
    if contains(input{i},"-")
        limset = [limset; str2double(strsplit(input{i},'-'))];
    end
end

limset = sortrows(limset);
smush = [];

for i = 1:length(limset)
    lims = limset(i,:);
    if isempty(smush) || smush(end,2) + 1 < lims(1)
        smush = [smush; lims];
    else
        smush(end,2) = max(smush(end,2), lims(2));
    end
end

fresh = 0;

for i = 1:length(smush)
    fresh = fresh + smush(i,2) - smush(i,1) + 1;
end

Part2 = sprintf('%16.f', fresh)