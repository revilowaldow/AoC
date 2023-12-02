clear
opts = delimitedTextImportOptions("NumVariables", 3);
opts.Delimiter = " ";
opts.VariableTypes = ["string", "string", "string"];
input = readtable("input.txt", opts)

%%
fileSizes = zeros([height(input) 1]);
dirSizes = table("/",0,'VariableNames', {'paths','sizes'});
for i = 1:height(input)
    switch input{i,1}
        case "$"
            switch input{i,2}
                case 'cd'
                    switch input{i,3}
                        case "/"
                            currentPath = "/";
                        case ".."
                            currentPath = regexprep(currentPath, '/[^/]*$', '');
                        case string(missing)
                            error("You must provide a directory to cd into")
                        otherwise
                            currentPath = strjoin([currentPath string(input{i,3})],"/");
                            if ~any(dirSizes.paths == currentPath)
                                dirSizes(height(dirSizes)+1,:) = table(currentPath,0);
                            end
                    end
                case 'ls'
                    %noop
                otherwise
                    error("Unrecognised command")
            end
        case "dir"
            %noop
        otherwise
            fileSizes(i) = double(input{i,1});
            if any(dirSizes.paths == currentPath)
                dirSizes{dirSizes.paths == currentPath,2} = dirSizes{dirSizes.paths == currentPath,2}+fileSizes(i);
            else
                dirSizes(height(dirSizes)+1,:) = table(currentPath,fileSizes(i));
            end
    end
end
dirSizes.depth = count(string(dirSizes.paths),"/");
dirSizes = sortrows(dirSizes,{'depth','paths'},{'descend','descend'});
for j = 1:height(dirSizes)
    dirSizes.sizes(j) = sum(dirSizes.sizes(~cellfun('isempty',regexp(dirSizes.paths,[char(dirSizes.paths(j)) '($|/[^/]*$)']))));
end

dirSizes
smallDirs = sum(table2array(dirSizes(dirSizes.sizes<=100000,2)))

%%

removedSize = min(dirSizes.sizes(dirSizes.sizes>=(30000000-(70000000-sum(fileSizes)))))