clear
input = readlines("07_input.txt").split(" ")

%%

faces = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];
%facesValue = 

bids = double(input(:,2));
hands = split(input(:,1),"");
hands = hands(:,2:end-1);



[~,idx] = sort(hands.replace(faces,compose("%02i",0:12)).join("").double,1,"descend");
hands = hands(idx,:); % sort hands by rank ready for same results
bids = bids(idx,:); % sort hands by rank ready for same results


phands = permute(hands,3:-1:1); % hand per page
hIdx = phands == faces'; % hand to card matrix
n = squeeze(sum(sum(hIdx,2) == (1:5))); % num of each card
[rowIndices, colIndices] = find(n); % find max count of card
bigGroup = accumarray(colIndices, rowIndices, [], @max)';
bigGroup(bigGroup == 2) =  bigGroup(bigGroup == 2) + 0.5 * (n(2,bigGroup == 2) == 2);
bigGroup(bigGroup == 3) =  bigGroup(bigGroup == 3) + n(2,bigGroup == 3) * 0.5;

[~,idx] = sort(bigGroup); % sort and score


Ans1 = sum(bids(idx,:) .* (1:numel(bids))')



%%
clear

data = readlines("07_input.txt").split(" ").replace(["J" "T" "Q" "K" "A"],["1" "W" "X" "Y" "Z"]);
[~,idx] = sortrows(char(data(:,1)));
data = data(idx,:);
hands = double(char(data(:,1)));
hands(hands == double('1')) = nan;
r = mode(hands,2);
r(isnan(r)) = 2;
[row,~] = ind2sub(size(hands),find(isnan(hands)));
hands(isnan(hands)) = r(row);
hands = reshape(hands',1,5,[]);
s = squeeze(sum(hands == pagetranspose(hands),[1 2]));
[~,idx] = sort(s);

Ans2 = sum(data(idx,2).double() .* (1:height(data))')

