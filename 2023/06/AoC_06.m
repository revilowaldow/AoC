clear
opts = detectImportOptions('06_input.txt');
opts.SelectedVariableNames = 2:5;
input = readmatrix("06_input.txt", opts)'

%%

time = input(:,1);
distance = input(:,2);

Ans1 = prod(holdTime(time, distance))

%%

time = double(strjoin(string(time),''));
distance = double(strjoin(string(distance),''));

Ans2 = holdTime(time, distance)

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