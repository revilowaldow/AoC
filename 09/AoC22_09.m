clear
%profile on

if true %use example
    direction = categorical(["R"; "U"; "L"; "D"; "R"; "D"; "L"; "R"]);
    count = [4;4;3;1;4;1;5;2];
    input = table(direction,count,'VariableNames',{'direction','count'}) %#ok<NOPTS>

    grid = 10;
else
    opts = delimitedTextImportOptions("NumVariables", 2);
    opts.Delimiter = " ";
    opts.VariableNames = ["direction", "count"];
    opts.VariableTypes = ["categorical", "double"];
    input = readtable("input.txt", opts); %#ok<NASGU,NOPTS>

    grid=1000;
end

%%

%grid=max(groupsummary(input,"direction","sum").sum_count)*2; %set a massive grid to avoid having to expand the array dynamically



positions = zeros([grid+1 grid+1 2]);
positions((grid/2)+1,(grid/2)+1,:) = 1;

hYPosOld = (grid/2)+1;
hXPosOld = hYPosOld;
tYPosOld = hYPosOld;
tXPosOld = hYPosOld;

tailPath = false([grid+1 grid+1]);
tailPath((grid/2)+1,(grid/2)+1) = true;


for i = 1:height(input)

    for j = 1:input.count(i,1)
        %   [hYPosOld, hXPosOld] = ind2sub(size(positions),find(positions(:,:,1)));
        %   [tYPosOld, tXPosOld] = ind2sub(size(positions),find(positions(:,:,2)));

        switch input.direction(i,1)
            case "U"
                hYPos = hYPosOld+1;
                hXPos = hXPosOld;
            case "D"
                hYPos = hYPosOld-1;
                hXPos = hXPosOld;
            case "L"
                hYPos = hYPosOld;
                hXPos = hXPosOld-1;
            case "R"
                hYPos = hYPosOld;
                hXPos = hXPosOld+1;
            otherwise
                error("You must specify a direction to move the rope.")
        end
        positions(hYPosOld,hXPosOld,1) = 0;
        positions(hYPos,hXPos,1) = 1;


        if ~((abs(diff([hYPos tYPosOld]))<2)&&(abs(diff([hXPos tXPosOld]))<2))
            hYPos-tYPosOld
            hXPos-tXPosOld


            if (hYPos==tYPosOld)||(hXPos==tXPosOld) %Inline movement
                % going the wrong way!
                if abs(hYPos-tYPosOld)>abs(hXPos-tXPosOld) % should I move LR or UD
                    tYPos=tYPosOld-(1*sign(tYPosOld-hYPos)) % move UD
                else
                    tXPos=tXPosOld-(1*sign(tXPosOld-hXPos)) %move LR
                end
            else %diagonal movement (i.e. both)



                tYPos=tYPosOld-(1*sign(hYPos-tYPosOld))
                tXPos=tXPosOld-(1*sign(hXPos-tXPosOld))
            end


            positions(tYPosOld,tXPosOld,2) = 0;


            tYPosOld=tYPos;
            tXPosOld=tXPos;
        else
            tYPos = tYPosOld;
            tXPos = tXPosOld;
        end

        %positions(tYPosOld,tXPosOld,2) = 0;
        positions(tYPos,tXPos,2) = 1



        hXPosOld = hXPos;
        hYPosOld = hYPos;
        tailPath(tYPos,tXPos) = true;
    end
end

posVisited = sum(sum(tailPath))

%%



%%

%profile viewer
%profile off