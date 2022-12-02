opts = delimitedTextImportOptions("NumVariables", 2);
opts.Delimiter = " ";
opts.VariableNames = ["Elf", "You"];
opts.VariableTypes = ["categorical", "categorical"];
opts = setvaropts(opts, ["Elf", "You"], "EmptyFieldRule", "auto");
input = readtable("input.txt", opts);

Played = renamecats(input.You, ["X", "Y", "Z"], ["1", "2", "3"]);
result = zeros([1, height(input)]);

for i = 1:height(input)

    switch input.Elf(i)
        case "A"

            switch input.You(i)
                case "X"
                    result(i) = 3;
                case "Y"
                    result(i) = 6;
                case "Z"
                    result(i) = 0;
            end

        case "B"

            switch input.You(i)
                case "X"
                    result(i) = 0;
                case "Y"
                    result(i) = 3;
                case "Z"
                    result(i) = 6;
            end

        case "C"

            switch input.You(i)
                case "X"
                    result(i) = 6;
                case "Y"
                    result(i) = 0;
                case "Z"
                    result(i) = 3;
            end

    end

end

TotalScore = sum(result) + sum(double(string(Played)))

PlayedCorrectly = renamecats(input.You, ["X", "Y", "Z"], ["0", "3", "6"]);
result = zeros([1, height(input)]);

for i = 1:height(input)

    switch input.Elf(i)
        case "A"

            switch input.You(i)
                case "X"
                    result(i) = 3;
                case "Y"
                    result(i) = 1;
                case "Z"
                    result(i) = 2;
            end

        case "B"

            switch input.You(i)
                case "X"
                    result(i) = 1;
                case "Y"
                    result(i) = 2;
                case "Z"
                    result(i) = 3;
            end

        case "C"

            switch input.You(i)
                case "X"
                    result(i) = 2;
                case "Y"
                    result(i) = 3;
                case "Z"
                    result(i) = 1;
            end

    end

end

TotalCorrectScore = sum(result) + sum(double(string(PlayedCorrectly)))
