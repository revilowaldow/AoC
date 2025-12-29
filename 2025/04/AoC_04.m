clear

%% Import

input = char(strsplit(fileread("04_input.txt"),{'\r\n'})) == '@';

%% Answer 1

bordered = padarray(input,[1 1],0,'both');

accessible = 0;

for i = 2:(length(bordered)-1)
    for j = 2:(length(bordered)-1)
        if bordered(i,j)
            if sum(bordered(i-1:i+1,j-1:j+1),"all") < 5
                accessible = accessible + 1;
            end
        end
    end
end

Part1 = accessible


%% Answer 2

removed = 0;
removal = true;

while removal
    removal = false;
    for i = 2:(length(bordered)-1)
        for j = 2:(length(bordered)-1)
            if bordered(i,j)
                if sum(bordered(i-1:i+1,j-1:j+1),"all") < 5
                    removed = removed + 1;
                    bordered(i,j) = 0;
                    removal = true;
                end
            end
        end
    end
end

Part1 = removed
