clear
input = char(readlines('11_input.txt'));

% Test case

inputTest = [
    '...#......';
    '.......#..';
    '#.........';
    '..........';
    '......#...';
    '.#........';
    '.........#';
    '..........';
    '.......#..';
    '#...#.....'];


%%

galDist(inputTest,2) == 374

Ans1 = galDist(input,2)

%%

galDist(inputTest,10)  == 1030
galDist(inputTest,100) == 8410

tic
Ans2 = galDist(input,1000000)
toc

%%

function dist = galDist(input, mult)

%Use a sparse matrix to only store non-zero values, memory and computationally efficient
input = sparse(input=='#');

[rInit, cInit] = size(input);

rEmpty = false(size(rInit));
cEmpty = false(size(cInit));

for i = 1:length(input)
    rEmpty(i) = all(input(i,:)==0);
    cEmpty(i) = all(input(:,i)==0);
end

for i = 1:((cInit-sum(cEmpty))+(mult*sum(cEmpty)))
    if cEmpty(i)
        cEmpty = [cEmpty(1:i-1) false([1 mult]) cEmpty(i+1:end)];
        input = [input(:,1:i-1) sparse(cInit,mult) input(:,i+1:end)];
    end
end

for i = 1:((rInit-sum(rEmpty))+(mult*sum(rEmpty)))
    if rEmpty(i)
        rEmpty = [rEmpty(1:i-1) false([1 mult]) rEmpty(i+1:end)];
        input = vertcat(input(1:i-1,:), sparse(mult,length(cEmpty)), input(i+1:end,:));
    end
end

[gr, gc] = find(input==1);

combs = nchoosek(1:length(gr),2);
pairdist = zeros([1 length(combs)]);
for i = 1:length(combs)
    pairdist(i) = abs(gr(combs(i,1))-gr(combs(i,2))) + abs(gc(combs(i,1))-gc(combs(i,2)));
end

dist = sum(pairdist);
size(input)
end

