clear
opts = detectImportOptions('04_input.txt');
opts.SelectedVariableNames = [3:12];
winners = readmatrix('04_input.txt',opts)
opts.SelectedVariableNames = [14:38];
ours = readmatrix('04_input.txt',opts)
clear opts

%%

count = zeros([length(winners) 1]);
for i = 1:length(ours)
    count(i) = 2^(sum(ismember(winners(i,:),ours(i,:)))-1);
end

Ans1 = sum(count(count~=0.5))

%%

copies = ones([length(winners) 1]);
for i = 1:length(ours)
    wins = sum(ismember(winners(i,:),ours(i,:)));
    for c = 1:copies(i)
        copies(i+1:i+wins,:)=copies(i+1:i+wins,:)+1;
    end
end

Ans2 = sum(copies)