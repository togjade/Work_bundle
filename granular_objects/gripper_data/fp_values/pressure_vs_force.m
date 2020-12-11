plot(abs(fielddata1), fielddata0);
f = fit(abs(fielddata1), fielddata0, 'poly2');
plot(f,abs(fielddata1), fielddata0);
%%
s = 5;
f0 = abs(force0);  f3 = abs(force3); f4 = abs(force4); f5 = abs(force5);
%f1 = abs(force1);
f = fit(f0, p0, 'poly1');
plot(f, f0, p0);
hold on
%plot(f1,p1);
plot(f3,p3);plot(f4,p4);plot(f5,p5);
grid on
hold off