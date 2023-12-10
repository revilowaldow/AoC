clear
input = char(readlines('10_input.txt'))

%%

[mInit, nInit] = find(input=='S');

% hardcoded start value, not great but a quick shortcut
dir = 'R';
pathvals = 'S';
n = nInit+1;

m = mInit;
dirHist = dir;
step = 1;
path = [];

while true
    pathvals = [pathvals input(m,n)];
    path(step,:)= [m,n];
    switch input(m,n)
        case 'S'
            disp('Loop complete')
            break
        case 'L'
            switch dir
                case 'L'
                    m = m-1;
                    dir = 'U';
                case 'D'
                    n = n+1;
                    dir = 'R';
                otherwise
                    error('Invalid direction')
            end
        case 'J'
            switch dir
                case 'R'
                    m = m-1;
                    dir = 'U';
                case 'D'
                    n = n-1;
                    dir = 'L';
                otherwise
                    error('Invalid direction')
            end
        case '7'
            switch dir
                case 'R'
                    m = m+1;
                    dir = 'D';
                case 'U'
                    n = n-1;
                    dir = 'L';
                otherwise
                    error('Invalid direction')
            end
        case 'F'
            switch dir
                case 'L'
                    m = m+1;
                    dir = 'D';
                case 'U'
                    n = n+1;
                    dir = 'R';
                otherwise
                    error('Invalid direction')
            end
        case '|'
            switch dir
                case 'D'
                    m = m+1;
                case 'U'
                    m = m-1;
                otherwise
                    error('Invalid direction')
            end
        case '-'
            switch dir
                case 'R'
                    n = n+1;
                case 'L'
                    n = n-1;
                otherwise
                    error('Invalid direction')
            end
        case '.'
            error('On ground, return to pipe.')
        otherwise
            error('Invalid location')
    end
    step = step + 1;
    dirHist = [dirHist dir];
end

Ans1 = step/2


%%

vec = 1:length(input);
[vecX,vecY] = meshgrid(vec,vec);
[in,on] = inpolygon(vecX,vecY,path(:,1),path(:,2));

Ans2 = sum(sum(in & ~on))

%% bonus plotting round

close all
plot(path(:,1),path(:,2))
axis equal
hold on
plot(vecX(in & ~on),vecY(in & ~on),'r+') % points inside
plot(vecX(~in  & ~on),vecY(~in  & ~on),'bo') % points outside
hold off
