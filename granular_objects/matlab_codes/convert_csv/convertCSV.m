cd C:\Users\tactile_pc1\Desktop\Togzhanfiles\
a = fileName(1,1);

function e=convertCSV(L,H)
fileNames = dir('*.csv');
fileNames = {fileNames.name}; % loads all csv files 
for i=L:H
    filename=string(fileNames(1,i));
    a = readtable(filename);
    a = a(:,5);
    a=table2array(a);
    C{i-L+1} = split (a,','); %% gives 1x5 cells
end
for j = 1:1:H % change for 5 when for 5 vevlocities
    b = string(C{1,j}); 
    c = split(b(:,1),'[');
    d = split(b(:,2),']');
    b = cell(1,j);
    e{1,j}=double([c(:,2),d(:,1)]); % 1-5 60,80,100,120,140
    
end
end