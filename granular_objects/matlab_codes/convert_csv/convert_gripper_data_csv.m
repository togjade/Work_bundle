cd C:\Users\tactile_pc1\Desktop\Togzhanfiles\experiments\gripper\23_05_19_on
fileNames = dir('*.mat');
fileNames = {fileNames.name}; % loads all csv files 
for i=1:length(fileNames)
    load(string(fileNames{i}));
end
%%
salt_gripper_on = salt_gripper_on(2400:end, :);
salt_gripper_close = salt_gripper_close(2400:end, :);
beans_gripper_on = beans_gripper_on(2400:end, :);
beans_gripper_close = beans_gripper_close(2400:end, :);
soda_gripper_on = soda_gripper_on(2400:end, :);
soda_gripper_close = soda_gripper_close(2400:end, :);
buckwheat_gripper_on = buckwheat_gripper_on(2400:end, :);
buckwheat_gripper_close = buckwheat_gripper_close(2400:end, :);
nut_gripper_on = nut_gripper_on(2400:end, :);
nut_gripper_close = nut_gripper_close(2400:end, :);
peas_gripper_on = peas_gripper_on(2400:end, :);
peas_gripper_close = peas_gripper_close(2400:end, :);
lentils_gripper_on = lentils_gripper_on(2400:end, :);
lentils_gripper_close = lentils_gripper_close(2400:end, :);
rice_gripper_on = rice_gripper_on(2400:end, :);
rice_gripper_close = rice_gripper_close(2400:end, :);
%%
save('kuskus_gripper_on.mat', 'kuskus_gripper_on');
save('salt_gripper_on.mat', 'salt_gripper_on');
save('beans_gripper_on.mat', 'beans_gripper_on');
save('soda_gripper_on.mat', 'soda_gripper_on');
save('buckwheat_gripper_on.mat', 'buckwheat_gripper_on');
save('nut_gripper_on.mat', 'nut_gripper_on');
save('peas_gripper_on.mat', 'peas_gripper_on');
save('lentils_gripper_on.mat', 'lentils_gripper_on');
save('rice_gripper_on.mat', 'rice_gripper_on');
%% 
cd C:\Users\tactile_pc1\Desktop\Togzhanfiles\experiments\gripper\23_05_19_close
kuskus_gripper_close = convertCSV(1,1);
salt_gripper_close = convertCSV(2,2);
beans_gripper_close = convertCSV(3,3);
soda_gripper_close = convertCSV(4,4);
buckwheat_gripper_close = convertCSV(5,5);
nut_gripper_close = convertCSV(6,6);
peas_gripper_close = convertCSV(7,7);
lentils_gripper_close = convertCSV(8,8);
rice_gripper_close = convertCSV(9,9);
%%
cd C:\Users\tactile_pc1\Desktop\Togzhanfiles\experiments\gripper\30_05_on\
fileNames = dir('*.csv');
fileNames = {fileNames.name}; % loads all csv files 
%%
salt_gripper_on2 = convertCSV(3,3);
beans_gripper_on2 = convertCSV(5,5);
soda_gripper_on2 = convertCSV(2,2);
nut_gripper_on2 = convertCSV(4,4);
rice_gripper_on2 = convertCSV(1,1);
%%
cd C:\Users\tactile_pc1\Desktop\Togzhanfiles\experiments\gripper\mat_files\
save('salt_gripper_on2.mat', 'salt_gripper_on2');
save('beans_gripper_on2.mat', 'beans_gripper_on2');
save('soda_gripper_on2.mat', 'soda_gripper_on2');
save('nut_gripper_on2.mat', 'nut_gripper_on2');
save('rice_gripper_on2.mat', 'rice_gripper_on2');

%%
function final=convertCSV(L,H)
fileNames = dir('*.csv');
fileNames = {fileNames.name}; % loads all csv files 
for i=L:H
    filename=string(fileNames(1,i));
    a = readtable(filename);
    a = a(:,5);
    a=table2array(a);
    C{i-L+1} = split (a,','); %% gives 1x5 cells
end
for j = 1:1 % change for 5 when for 5 vevlocities
    b = string(C{1,j}); 
    c = split(b(:,1),'['); %pressure
    d = split(b(:,2),','); % accelerometer
    e = split(b(:,3),','); % position 1
    f = split(b(:,4),','); % position 2
    g = split(b(:,5),','); % vleocity 1
    h = split(b(:,6),']'); % velocity 2 
    %,e(:,1),f(:,1),g(:,1),h(:,1)]
    b = cell(1,j);
    final=double([c(:,2),d(:,1),e(:,1),f(:,1),g(:,1),h(:,1)]); % 1-5 60,80,100,120,140
    
end
end