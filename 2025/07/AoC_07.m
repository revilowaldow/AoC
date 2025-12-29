clear

%% Import

input = char(strsplit(fileread("07_inputDemo.txt"),{'\r\n'}))

%% Answer 1

tachyons = input(1,:) == 'S'
spliters = input == '^'
splits = 0;

for i = 1:length(input)

    split = spliters(i,:) & tachyons;
    rowsplit = false(1,length(enter))
    for j = 1:length(enter)
        if enter(j)
            rowsplit(j)=true;
            enter(j)=false;
            enter(j+1)=true;
            enter(j-1)=true; % need to not check this again accidentally, do union/or of input less splits and out splits in new var
            splits = splits + 1; 
        end

    end


end