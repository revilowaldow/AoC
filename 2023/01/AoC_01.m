clear
opts = delimitedTextImportOptions("NumVariables", 1);
opts.VariableTypes = "string";
input = readmatrix("01_input.txt",opts);
clear opts
%%

N = regexp(input,'\d','Match');
Ans1 = sum(str2double(join([cellfun(@(x) x(1),N) cellfun(@(x) x(end),N)],'')))

%%

% Some absolute fuckery because MATLAB consumes and I'm not dealing with starting indicies
N2 = regexp(input,'\d|o(?=ne)|t(?=wo)|th(?=ree)|f(?=our)|fi(?=ve)|s(?=ix)|se(?=ven)|e(?=ight)|n(?=ine)','Match');
for i = 1:length(N2)
    N2{i}(N2{i}=="o")   = "1";
    N2{i}(N2{i}=="t")   = "2";
    N2{i}(N2{i}=="th") = "3";
    N2{i}(N2{i}=="f")  = "4";
    N2{i}(N2{i}=="fi")  = "5";
    N2{i}(N2{i}=="s")   = "6";
    N2{i}(N2{i}=="se") = "7";
    N2{i}(N2{i}=="e") = "8";
    N2{i}(N2{i}=="n")  = "9";
end

Ans2 = sum(str2double(join([cellfun(@(x) x(1),N2) cellfun(@(x) x(end),N2)],'')));
