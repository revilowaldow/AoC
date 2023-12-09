clear
input = readmatrix("09_input.txt")

%%
predictions = zeros([length(input) 1]);

for i = 1:length(input)
    predictions(i) = n(input(i,:));
end

Ans1 = sum(predictions)

%%

for i = 1:length(input)
    predictions(i) = n(flip(input(i,:)));
end

Ans2 = sum(predictions)

%%

function out = n(line)
    if all(line==0)
        out = 0;
        return;
    end
    m = zeros(1, length(line)-1);
    for i = 1:(length(line)-1)
        m(i) = line(i+1) - line(i);
    end
    out = line(end) + n(m);
end