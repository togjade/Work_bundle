%% 60- red, 80-green,100-blue, 120-cyan, 140-black
% buckwheat dot
hold on
figure(1)
title('buckwheat');
scatter(buckwheat_data{1,1}(1,:),buckwheat_data{1,1}(2,:),'.','r');%60
scatter(buckwheat_data{1,2}(1,:),buckwheat_data{1,2}(2,:),'.','g');%80
scatter(buckwheat_data{1,3}(1,:),buckwheat_data{1,3}(2,:),'.','b');%100
scatter(buckwheat_data{1,4}(1,:),buckwheat_data{1,4}(2,:),'.','c');%120
scatter(buckwheat_data{1,5}(1,:),buckwheat_data{1,5}(2,:),'.','k');%140
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
hold off
%% beans circle
hold on
title('beans');
scatter(beans_data{1,1}(1,:),beans_data{1,1}(2,:),'o','r');%60
scatter(beans_data{1,2}(1,:),beans_data{1,2}(2,:),'o','g');%80
scatter(beans_data{1,3}(1,:),beans_data{1,3}(2,:),'o','b');%100
scatter(beans_data{1,4}(1,:),beans_data{1,4}(2,:),'o','c');%120
scatter(beans_data{1,5}(1,:),beans_data{1,5}(2,:),'o','k');%140
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
hold off
%% kuskus plus 
hold on
title('kuskus');
scatter(kuskus_data{1,1}(1,:),kuskus_data{1,1}(2,:),'+','r');%60
scatter(kuskus_data{1,2}(1,:),kuskus_data{1,2}(2,:),'+','g');%80
scatter(kuskus_data{1,3}(1,:),kuskus_data{1,3}(2,:),'+','b');%100
scatter(kuskus_data{1,4}(1,:),kuskus_data{1,4}(2,:),'+','c');%120
scatter(kuskus_data{1,5}(1,:),kuskus_data{1,5}(2,:),'+','k');%140
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')

hold off
%% lentis asterisk
hold on
title('lentis');
scatter(lentis_data{1,1}(1,:),lentis_data{1,1}(2,:),'*','r');%60
scatter(lentis_data{1,2}(1,:),lentis_data{1,2}(2,:),'*','g');%80
scatter(lentis_data{1,3}(1,:),lentis_data{1,3}(2,:),'*','b');%100
scatter(lentis_data{1,4}(1,:),lentis_data{1,4}(2,:),'*','c');%120
scatter(lentis_data{1,5}(1,:),lentis_data{1,5}(2,:),'*','k');%140
xlabel('delta P');
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
hold off
%% nut x
hold on
title('nut');
scatter(nut_data{1,1}(1,:),nut_data{1,1}(2,:),'x','r');%60
scatter(nut_data{1,2}(1,:),nut_data{1,2}(2,:),'x','g');%80
scatter(nut_data{1,3}(1,:),nut_data{1,3}(2,:),'x','b');%100
scatter(nut_data{1,4}(1,:),nut_data{1,4}(2,:),'x','c');%120
scatter(nut_data{1,5}(1,:),nut_data{1,5}(2,:),'x','k');%140
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
xlabel('delta P');

hold off
%% peas square
hold on
title('peas');
scatter(peas_data{1,1}(1,:),peas_data{1,1}(2,:),'s','r');%60
scatter(peas_data{1,2}(1,:),peas_data{1,2}(2,:),'s','g');%80
scatter(peas_data{1,3}(1,:),peas_data{1,3}(2,:),'s','b');%100
scatter(peas_data{1,4}(1,:),peas_data{1,4}(2,:),'s','c');%120
scatter(peas_data{1,5}(1,:),peas_data{1,5}(2,:),'s','k');%140
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
xlabel('delta P');

hold off
%% rice diamond
hold on
title('rice');
scatter(rice_data{1,1}(1,:),rice_data{1,1}(2,:),'d','r');%60
scatter(rice_data{1,2}(1,:),rice_data{1,2}(2,:),'d','g');%80
scatter(rice_data{1,3}(1,:),rice_data{1,3}(2,:),'d','b');%100
scatter(rice_data{1,4}(1,:),rice_data{1,4}(2,:),'d','c');%120
scatter(rice_data{1,5}(1,:),rice_data{1,5}(2,:),'d','k');%140
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
xlabel('delta P');

hold off
%% salt star
hold on
title('salt');
scatter(salt_data{1,1}(1,:),salt_data{1,1}(2,:),'p','r');%60
scatter(salt_data{1,2}(1,:),salt_data{1,2}(2,:),'p','g');%80
scatter(salt_data{1,3}(1,:),salt_data{1,3}(2,:),'p','b');%100
scatter(salt_data{1,4}(1,:),salt_data{1,4}(2,:),'p','c');%120
scatter(salt_data{1,5}(1,:),salt_data{1,5}(2,:),'p','k');%140
legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
xlabel('delta P');

hold off
%% soda >
hold on
title('soda');
scatter(soda_data{1,1}(1,:),soda_data{1,1}(2,:),'>','r');%60
scatter(soda_data{1,2}(1,:),soda_data{1,2}(2,:),'>','g');%80
scatter(soda_data{1,3}(1,:),soda_data{1,3}(2,:),'>','b');%100
scatter(soda_data{1,4}(1,:),soda_data{1,4}(2,:),'>','c');%120
scatter(soda_data{1,5}(1,:),soda_data{1,5}(2,:),'>','k');%140
xlabel('delta P');

legend('60- red, 80-green,100-blue, 120-cyan, 140-black')
