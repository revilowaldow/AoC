function makeFiles(y)
mkdir(y)
for idx = 1:12
    mkdir(fullfile(y,sprintf("%02i",idx)))
    fn = fullfile(y,sprintf("%02i",idx),"AoC_" + sprintf("%02i",idx)+".txt");
    writematrix("clear",fn,QuoteStrings=false)
    movefile(fn,fn.replace(".txt",".m"))
    writelines("",fullfile(y,sprintf("%02i",idx),sprintf("%02i",idx)+"_inputDemo.txt"))
    writelines("",fullfile(y,sprintf("%02i",idx),sprintf("%02i",idx)+"_input.txt"))
end
end