%% 60- red, 80-green,100-blue, 120-cyan, 140-black
% buckwheat dot
hold on 
for i = 1:5
scatter(buckwheat_data_reloc{1,i}(1,:),buckwheat_data_reloc{1,i}(2,:),'.','r');%60
scatter(beans_data_reloc{1,i}(1,:),beans_data_reloc{1,i}(2,:),'o','g');%60
scatter(kuskus_data_reloc{1,i}(1,:),kuskus_data_reloc{1,i}(2,:),'+','b');%60
scatter(lentis_data_reloc{1,i}(1,:),lentis_data_reloc{1,i}(2,:),'*','c');%60
scatter(nut_data_reloc{1,i}(1,:),nut_data_reloc{1,i}(2,:),'x','k');%60
scatter(peas_data_reloc{1,i}(1,:),peas_data_reloc{1,i}(2,:),'s','y');%60
scatter(rice_data_reloc{1,i}(1,:),rice_data_reloc{1,i}(2,:),'d','m');%60
end
hold off
%%
% salt star
subplot(2,2,4);
hold on
title('salt');
scatter(salt_data_reloc{1,1}(1,:),salt_data_reloc{1,1}(2,:),'p','r');%60
scatter(salt_data_reloc{1,2}(1,:),salt_data_reloc{1,2}(2,:),'p','g');%80
scatter(salt_data_reloc{1,3}(1,:),salt_data_reloc{1,3}(2,:),'p','b');%100
scatter(salt_data_reloc{1,4}(1,:),salt_data_reloc{1,4}(2,:),'p','c');%120
scatter(salt_data_reloc{1,5}(1,:),salt_data_reloc{1,5}(2,:),'p','k');%140
hold off
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')

%%
figure(3)
% soda >
title('soda');
hold on
scatter(soda_data_reloc{1,1}(1,:),soda_data_reloc{1,1}(2,:),'>','r');%60
scatter(soda_data_reloc{1,2}(1,:),soda_data_reloc{1,2}(2,:),'>','g');%80
scatter(soda_data_reloc{1,3}(1,:),soda_data_reloc{1,3}(2,:),'>','b');%100
scatter(soda_data_reloc{1,4}(1,:),soda_data_reloc{1,4}(2,:),'>','c');%120
scatter(soda_data_reloc{1,5}(1,:),soda_data_reloc{1,5}(2,:),'>','k');%140
hold off
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
