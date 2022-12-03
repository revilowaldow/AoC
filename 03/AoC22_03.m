clear
input = readlines("input.txt");

nRucksacks=length(input);
splitInput= strings(nRucksacks,2);
common=blanks(nRucksacks);
for i=1:nRucksacks
    len=strlength(input(i));
    splitInput(i,1)=input{i}(1:len/2);
    splitInput(i,2)=input{i}(1+len/2:end);
    common(i)=intersect(splitInput{i,1},splitInput{i,2});
end
Priorities=double(common)'-96;
for i=1:nRucksacks
    if Priorities(i)<0
        Priorities(i)=Priorities(i)+58;
    end
end
PrioritySum=sum(Priorities)

GroupType=blanks(nRucksacks/3);
for i=1:nRucksacks/3
    GroupType(i) = intersect(intersect(input{(i*3)-2}, input{(i*3)-1}), input{i*3});
end
GroupType=double(GroupType)'-96;
for i=1:nRucksacks/3
    if GroupType(i)<0
        GroupType(i)=GroupType(i)+58;
    end
end
GroupTypeSum=sum(GroupType)