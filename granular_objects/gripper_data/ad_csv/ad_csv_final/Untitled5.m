%%
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\ad_csv_final\data_sc_p
%%
for i = 1:5
    for j=1:14
        sc1=double(soda_data{i}(1,j));
        p1=double(soda_data{i}(2,j));
        m(,:) = [1 sc1 p1];
    end
end