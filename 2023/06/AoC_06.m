clear
opts = detectImportOptions('06_input.txt');
opts.SelectedVariableNames = 2:5;
input = readmatrix("06_input.txt", opts)'

%%

time = input(:,1);
distance = input(:,2);

tic
Ans1 = prod(holdTime(time, distance))
toc
tic
for i = 1:length(time)
    each(i) = calcWins(time(i), distance(i));
end
Ans1Alt = prod(each)
toc

%%

time = double(strjoin(string(time),''));
distance = double(strjoin(string(distance),''));

tic
Ans2 = holdTime(time, distance)
toc
tic
Ans2Alt = calcWins(time, distance)
toc

%%
function methods = holdTime(time, distance)
methods = zeros(size(time));
for i = 1:length(time)
    record = distance(i);
    for j = 0:time(i)
        attempt = (time(i)-j)*j;
        if attempt>record
            methods(i) = methods(i)+1;
        end
    end
end
end

function wins = calcWins(time, distance)
discr = sqrt(time^2 - 4 * (distance + 1));
x = [ceil((time - discr) / 2), floor((time + discr) / 2)];
wins = x(2) - x(1) + 1;
end

