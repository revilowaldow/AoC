clear
input = fileread('input.txt')

%%
checkPacketIndex = checkIndex(input,4)
checkMessageIndex = checkIndex(input,14)

%%
function index = checkIndex(message,marker)
for i = 1:(length(message)-marker-1)
    if length(unique(message(i:i+marker-1))) == marker
        break
    end
end
index = i+marker-1;
end
