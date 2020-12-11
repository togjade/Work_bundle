%% create folder to store csv files
mkdir ad_csv_final
%% change to a proper directory of the exp and order of items according to exp
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\
%%
soda = fileName(1,5);       nut=fileName(6,10);         
beans=fileName(11,15);      kuskus=fileName(16,20);     
lentis=fileName(21,25);     rice=fileName(26,30);       
peas=fileName(31,35);       salt=fileName(36,40);       
buckwheat=fileName(41,45); 
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\ad_csv_final
csvwrite('soda_60.csv',soda{1}); csvwrite('soda_80.csv',soda{2}); csvwrite('soda_100.csv',soda{3}); csvwrite('soda_120.csv',soda{4}); csvwrite('soda_140.csv',soda{5});  
csvwrite('nut_60.csv',nut{1}); csvwrite('nut_80.csv',nut{2}); csvwrite('nut_100.csv',nut{3}); csvwrite('nut_120.csv',nut{4}); csvwrite('nut_140.csv',nut{5}); 
csvwrite('beans_60.csv',beans{1});csvwrite('beans_80.csv',beans{2});csvwrite('beans_100.csv',beans{3});csvwrite('beans_120.csv',beans{4});csvwrite('beans_140.csv',beans{5});
csvwrite('kuskus_60.csv',kuskus{1});csvwrite('kuskus_80.csv',kuskus{2});csvwrite('kuskus_100.csv',kuskus{3});csvwrite('kuskus_120.csv',kuskus{4});csvwrite('kuskus_140.csv',kuskus{5});
csvwrite('lentis_60.csv',lentis{1});csvwrite('lentis_80.csv',lentis{2});csvwrite('lentis_100.csv',lentis{3});csvwrite('lentis_120.csv',lentis{4});csvwrite('lentis_140.csv',lentis{5});
csvwrite('rice_60.csv',rice{1});csvwrite('rice_80.csv',rice{2});csvwrite('rice_100.csv',rice{3});csvwrite('rice_120.csv',rice{4});csvwrite('rice_140.csv',rice{5});
csvwrite('peas_60.csv',peas{1}); csvwrite('peas_80.csv',peas{2});csvwrite('peas_100.csv',peas{3});csvwrite('peas_120.csv',peas{4});csvwrite('peas_140.csv',peas{5});
csvwrite('salt_60.csv',salt{1});csvwrite('salt_80.csv',salt{2});csvwrite('salt_100.csv',salt{3});csvwrite('salt_120.csv',salt{4});csvwrite('salt_140.csv',salt{5});
csvwrite('buckwheat_60.csv',buckwheat{1});csvwrite('buckwheat_80.csv',buckwheat{2});csvwrite('buckwheat_100.csv',buckwheat{3});csvwrite('buckwheat_120.csv',buckwheat{4});csvwrite('buckwheat_140.csv',buckwheat{5});

%% for hand data 
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\hand_8_05\beans\
beansHand_15 = fileName(1,15);
%%
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\hand_8_05\salt\
saltHand_15 = fileName(1,15);
%%
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\hand_8_05\noise
%%
noiseHand_15 = fileName(1,7);
%%
motor = fileName(1,3);
%%
ball = fileName(1,3);
%%
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\hand_8_05\
save('beansHand_15.mat', 'beansHand_15');
save('buckwheatHand_15.mat', 'beansHand_15');
save('saltHand_15.mat', 'beansHand_15');
save('noiseHand_15.mat', 'noiseHand_15');
%%


%% csvread f-n 
function e=fileName(L,H)
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
%%




