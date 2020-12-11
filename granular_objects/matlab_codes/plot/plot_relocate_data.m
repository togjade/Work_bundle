array=[0.0005 0.0010 0.0015 0.002 0.0025 0.0030 0.0035 0.004 0.0045 0.0050];
array2=[0.0005 0.0010 0.0015 0.002 0.0025 0.0030 0.0035 0.004 0.0045 0.0050 0.0055 0.0060 0.0065 0.0070 0.0075 0.0080];

hold on
scatter(array,beans_data_reloc,400,'.','r');
scatter(array,buckwheat_data_reloc,400,'.','k');
scatter(array,kuskus_data_reloc,400,'.','g');
scatter(array,lentis_data_reloc,400,'.','b');
scatter(array,nut_data_reloc,400,'.','m');
scatter(array,peas_data_reloc,400,'.','c');
scatter(array,rice_data_reloc,400,'x','m');
scatter(array,salt_data_reloc,400,'x','b');
scatter(array2,soda_data_reloc,400,'*','r')
%title('red-beans, black-buckwheat, green - kuskus,blue-lentis,magenta-nut,cyan-peas, x-magenta-rice, x-blue-salt, *-red-soda');
legend('red-beans', 'black-buckwheat', 'green - kuskus','blue-lentis','magenta-nut','cyan-peas', 'x-magenta-rice', 'x-blue-salt', '*-red-soda');

xlim([0 0.01])
hold off
