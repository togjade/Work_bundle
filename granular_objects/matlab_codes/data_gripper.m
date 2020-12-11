data_gripper_close = cell(1,9); 
data_gripper_close{1} = beans_gripper_close;
data_gripper_close{2} = buckwheat_gripper_close;
data_gripper_close{3} = kuskus_gripper_close;
data_gripper_close{4} = lentils_gripper_close;
data_gripper_close{5} = nut_gripper_close;
data_gripper_close{6} = peas_gripper_close;
data_gripper_close{7} = rice_gripper_close;
data_gripper_close{8} = salt_gripper_close;
data_gripper_close{9} = soda_gripper_close;
%%
data_gripper_on = cell(1,9); 
data_gripper_on{1} = beans_gripper_on;
data_gripper_on{2} = buckwheat_gripper_on;
data_gripper_on{3} = kuskus_gripper_on;
data_gripper_on{4} = lentils_gripper_on;
data_gripper_on{5} = nut_gripper_on;
data_gripper_on{6} = peas_gripper_on;
data_gripper_on{7} = rice_gripper_on;
data_gripper_on{8} = salt_gripper_on;
data_gripper_on{9} = soda_gripper_on;
%%
data_gripper_on2 = cell(1,5); 
data_gripper_on2{5} = beans_gripper_on2;
data_gripper_on2{4} = nut_gripper_on2;
data_gripper_on2{1} = rice_gripper_on2;
data_gripper_on2{3} = salt_gripper_on2;
data_gripper_on2{2} = soda_gripper_on2;

%%
cd C:\Users\tactile_pc1\Desktop\Togzhanfiles\experiments\gripper\mat_files\30_05_19_on
save('data_gripper_on2.mat', 'data_gripper_on2');
%%
for i = 2:4%1:length(data_gripper_on2)
    data_gripper_on2{i} = data_gripper_on2{i}(100:end, :);
end
%%
save('data_gripper_on.mat', 'data_gripper_on');
save('data_gripper_close.mat', 'data_gripper_close');
