clear
filename = 'input.txt';
endRow = 8;
formatSpec = '%4s%4s%4s%4s%4s%4s%4s%4s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
initState = flipud(strtrim([dataArray{1:end-1}]))

opts = delimitedTextImportOptions("NumVariables", 4);
opts.DataLines = [11, Inf];
opts.Delimiter = [" ", "from ", "move ", "to "];
opts.VariableTypes = ["string", "double", "double", "double"];
opts.ConsecutiveDelimitersRule = "join";
actions = readtable("input.txt", opts);
actions = table2array(actions(:,2:4))

%%
state = initState;
for i = 1:length(actions)
    [stack,~] = size(state);
    voids = strlength(state)==0;
    source = state(:,actions(i,2));
    count = actions(i,1);
    start=stack-sum(voids(:,actions(i,2)));
    selection = flipud(state((start-count+1):start,actions(i,2)));
    state((start-count+1):start,actions(i,2))="";
    place = stack-sum(voids(:,actions(i,3)));
    state((place+1):(place+length(selection)),actions(i,3))=selection;
    state = fillmissing(state,'constant',"");
end
[stack,nStack] = size(state);
voids = strlength(state)==0;
topN = stack-sum(voids);
top='';
for i = 1:nStack
   top = [top char(state(topN(i),i))];
end
top9000 = top(isstrprop(top,'alpha'))

%% do exactly the same thing but take out the flip

clearvars -except initState actions % reset
state = initState;

for i = 1:length(actions)
    [stack,~] = size(state);
    voids = strlength(state)==0;
    source = state(:,actions(i,2));
    count = actions(i,1);
    start=stack-sum(voids(:,actions(i,2)));
    selection = state((start-count+1):start,actions(i,2)); % removed flip op
    state((start-count+1):start,actions(i,2))="";
    place = stack-sum(voids(:,actions(i,3)));
    state((place+1):(place+length(selection)),actions(i,3))=selection;
    state = fillmissing(state,'constant',"");
end
[stack,nStack] = size(state);
voids = strlength(state)==0;
topN = stack-sum(voids);
top='';
for i = 1:nStack
   top = [top char(state(topN(i),i))];
end

top9001 = top(isstrprop(top,'alpha'))
