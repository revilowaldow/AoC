clear
opts = delimitedTextImportOptions("NumVariables", 21);
opts.Delimiter = " ";
opts.VariableTypes = ["string", repelem("double",20)];
opts.SelectedVariableNames = 2:21;
opts.DataLines = [1, 1];
seeds = table2array(readtable('05_input.txt',opts))'

opts = delimitedTextImportOptions("NumVariables", 3);
opts.Delimiter = " ";
opts.VariableTypes = ["double", "double", "double"];

maps.seed2soil = readMap(opts, [4,17]);
maps.soil2fertilizer = readMap(opts, [20,30]);
maps.fertilizer2water = readMap(opts, [33,66]);
maps.water2light = readMap(opts, [69,98]);
maps.light2temperature = readMap(opts, [101,143]);
maps.temperature2humidity = readMap(opts, [146,191]);
maps.humidity2location = readMap(opts, [194,213]);

maps

clear opts
%%

locations = zeros([length(seeds) 1]);
for i = 1:length(seeds)
    locations(i) = mapSeed2location(seeds(i),maps);
end

Ans1 = min(locations)


%%

seeds = sortrows(reshape(seeds,2,[])')
locations = zeros([length(seeds) 1]);
fullseeds = [];
for i = 1:length(seeds)
    fullseeds = [];
    %fullseeds = [fullseeds; (seeds(i,1):seeds(i,1)+seeds(i,2)-1)'];
    fullseeds = (seeds(i,1):seeds(i,1)+seeds(i,2)-1)';
    disp(i)
    %{
    for j = 1:length(fullseeds)
        temp = mapSeed2location(fullseeds(j),maps);
        smallestloc = inf;
        if temp<smallestloc
            smallestloc = temp;
        end
    end
    locations(i)=smallestloc;
    %}
    tic
    locations(i) = min(mapSeed2location(fullseeds,maps));
    toc
end

Ans2 = min(locations)


%{
smallestloc = inf;
for i = 1:length(fullseeds)
    temp = mapSeed2location(fullseeds(i),maps);
    if temp<smallestloc
        smallestloc = temp;
    end
end
%}

%min(mapSeed2location(fullseeds,maps))
%Ans2 = smallestloc


%%

function map = readMap(opts,DataLines)
opts.DataLines = DataLines;
map = sortrows(table2array(readtable('05_input.txt',opts)),2);
end


function out = mapSeed2location(seed,maps)
orderedMaps = {
    maps.seed2soil;
    maps.soil2fertilizer;
    maps.fertilizer2water;
    maps.water2light;
    maps.light2temperature;
    maps.temperature2humidity;
    maps.humidity2location
    };
out=seed;
for i = 1:length(orderedMaps)
    out = followMap(orderedMaps{i},out);
end
end





function out = followMap(map,in)

out = in;
for i = 1:length(map)
    if map(i,2)<=in & in<map(i,2)+map(i,3)-1
        out = map(i,1)+in-map(i,2);
    end
end

end












