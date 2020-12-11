beans_data_reloc=relocate(beans_data);    buckwheat_data_reloc=relocate(buckwheat_data);
kuskus_data_reloc=relocate(kuskus_data);  lentis_data_reloc=relocate(lentis_data);
nut_data_reloc=relocate(nut_data);        peas_data_reloc=relocate(peas_data);
rice_data_reloc=relocate(rice_data);      salt_data_reloc=relocate(salt_data);
%%
function b=relocate(data)
reloc=zeros(9,5);
for i=1:5 % from 1 to 5 
    p1=1;p2=1;p3=1;p4=1;p5=1;p6=1;p7=1;p8=1;p9=1;
    d21=0;d22=0;d23=0;d24=0;d25=0;d26=0;d27=0;d28=0;d29=0;
    daTa=data{1,i};
    L=length(daTa);
    for j = 1:L
        d2=daTa(2,j);
        if daTa(1,j)>=0 && daTa(1,j)<0.0005
            daTa(1,j)=0.0005; p1=p1+1;  d21=daTa(2,j);
        elseif daTa(1,j) >= 0.0005 && daTa(1,j) < 0.0010
            daTa(1,j)=0.0010; p2=p2+1;  d22=daTa(2,j);
        elseif daTa(1,j) >= 0.0010 && daTa(1,j) < 0.0015
            daTa(1,j)=0.0015; p3=p3+1;  d23=daTa(2,j);
        elseif daTa(1,j) >= 0.0015 && daTa(1,j) < 0.0020
            daTa(1,j)=0.0020; p4=p4+1;  d24=daTa(2,j);
        elseif daTa(1,j) >= 0.0020 && daTa(1,j) < 0.0025
            daTa(1,j)=0.0025; p5=p5+1;  d25=daTa(2,j);
        elseif daTa(1,j) >= 0.0025 && daTa(1,j) < 0.0030
            daTa(1,j)=0.0030; p6=p6+1;  d26=daTa(2,j);
        elseif daTa(1,j) >= 0.0030 && daTa(1,j) < 0.0035
            daTa(1,j)=0.0035; p7=p7+1;  d27=daTa(2,j);
        elseif daTa(1,j) >= 0.0035 && daTa(1,j) < 0.0040
            daTa(1,j)=0.0040; p8=p8+1;  d28=daTa(2,j);
        elseif daTa(1,j) >= 0.0040 && daTa(1,j) < 0.0045
            daTa(1,j)=0.0045; p9=p9+1;  d29=daTa(2,j);
        elseif daTa(1,j) >= 0.0045 && daTa(1,j) < 0.0050
            daTa(1,j)=0.0050; p10=p10+1;  d210=daTa(2,j);
        elseif daTa(1,j) >= 0.0045 && daTa(1,j) < 0.0050 
            daTa(1,j)=0.0045; p10=p10+1;  d210=daTa(2,j);
        end
        F1(1,p1)=d21; F2(1,p2)=d22;F3(1,p3)=d23;F4(1,p4)=d24;F5(1,p5)=d25;F6(1,p6)=d26;F7(1,p7)=d27;F8(1,p8)=d28;F9(1,p9)=d29;
        f1=mean(F1);f2=mean(F2);f3=mean(F3);f4=mean(F4);f5=mean(F5);f6=mean(F6);f7=mean(F7);f8=mean(F8);f9=mean(F9);
        reloc(1,i)=f1;reloc(2,i)=f2;reloc(3,i)=f3;reloc(4,i)=f4;reloc(5,i)=f5;reloc(6,i)=f6;reloc(7,i)=f7;reloc(8,i)=f8;reloc(9,i)=f9;
        
    end
end
LL=size(reloc);
for i=1:LL(1,1)
b(1,i)=mean(reloc(i,:));
end
end
%%
function n = soda_rel(data)
reloc=zeros(9,5);
array2=[0.0005 0.0010 0.0015 0.002 0.0025 0.0030 0.0035 0.004 0.0045 0.0050 0.0055 0.0060 0.0065 0.0070 0.0075 0.0080];
for i=1:5 % from 1 to 5 
    p1=1;p2=1;p3=1;p4=1;p5=1;p6=1;p7=1;p8=1;p9=1;p10=1;p11=1;p12=1;p13=1;p14=1;p15=1;p16=1;
    d21=0;d22=0;d23=0;d24=0;d25=0;d26=0;d27=0;d28=0;d29=0;d210=0;d211=0;d212=0;d213=0;d214=0;d215=0;d216=0;
    daTa=data{1,i};
    L=length(daTa);
    for j = 1:L
        d2=daTa(2,j);
        if daTa(1,j)>=0 && daTa(1,j)<0.0005
            daTa(1,j)=0.0005; p1=p1+1;  d21=daTa(2,j);
        elseif daTa(1,j) >= 0.0005 && daTa(1,j) < 0.0010
            daTa(1,j)=0.0010; p2=p2+1;  d22=daTa(2,j);
        elseif daTa(1,j) >= 0.0010 && daTa(1,j) < 0.0015
            daTa(1,j)=0.0015; p3=p3+1;  d23=daTa(2,j);
        elseif daTa(1,j) >= 0.0015 && daTa(1,j) < 0.0020
            daTa(1,j)=0.0020; p4=p4+1;  d24=daTa(2,j);
        elseif daTa(1,j) >= 0.0020 && daTa(1,j) < 0.0025
            daTa(1,j)=0.0025; p5=p5+1;  d25=daTa(2,j);
        elseif daTa(1,j) >= 0.0025 && daTa(1,j) < 0.0030
            daTa(1,j)=0.0030; p6=p6+1;  d26=daTa(2,j);
        elseif daTa(1,j) >= 0.0030 && daTa(1,j) < 0.0035
            daTa(1,j)=0.0035; p7=p7+1;  d27=daTa(2,j);
        elseif daTa(1,j) >= 0.0035 && daTa(1,j) < 0.0040
            daTa(1,j)=0.0040; p8=p8+1;  d28=daTa(2,j);
        elseif daTa(1,j) >= 0.0040 && daTa(1,j) < 0.0045
            daTa(1,j)=0.0045; p9=p9+1;  d29=daTa(2,j);
        elseif daTa(1,j) >= 0.0045 && daTa(1,j) < 0.0050
            daTa(1,j)=0.0050; p10=p10+1;  d210=daTa(2,j);
        elseif daTa(1,j) >= 0.0050 && daTa(1,j) < 0.0055 
            daTa(1,j)=0.0055; p10=p11+1;  d211=daTa(2,j);
        elseif daTa(1,j) >= 0.0055 && daTa(1,j) < 0.0060 
            daTa(1,j)=0.0060; p12=p12+1;  d212=daTa(2,j);
        elseif daTa(1,j) >= 0.0060 && daTa(1,j) < 0.0065 
            daTa(1,j)=0.0065; p13=p13+1;  d213=daTa(2,j);
        elseif daTa(1,j) >= 0.0065 && daTa(1,j) < 0.0070 
            daTa(1,j)=0.0070; p14=p14+1;  d214=daTa(2,j);
        elseif daTa(1,j) >= 0.0070 && daTa(1,j) < 0.0075 
            daTa(1,j)=0.0075; p15=p15+1;  d215=daTa(2,j);
        elseif daTa(1,j) >= 0.0075 && daTa(1,j) < 0.0080 
            daTa(1,j)=0.0080; p16=p16+1;  d216=daTa(2,j);    
        end
        F1(1,p1)=d21; F2(1,p2)=d22;F3(1,p3)=d23;F4(1,p4)=d24;F5(1,p5)=d25;F6(1,p6)=d26;F7(1,p7)=d27;F8(1,p8)=d28;F9(1,p9)=d29;F10(1,p10)=d210;
        F11(1,p11)=d211;F12(1,p12)=d212;F13(1,p13)=d213;F14(1,p14)=d214;F15(1,p15)=d210;F16(1,p16)=d216;
        f1=mean(F1);f2=mean(F2);f3=mean(F3);f4=mean(F4);f5=mean(F5);f6=mean(F6);f7=mean(F7);f8=mean(F8);f9=mean(F9);f10=mean(F10);
        f11=mean(F11);f12=mean(F12);f13=mean(F13);f14=mean(F14);f15=mean(F15);f16=mean(F16);
        reloc(1,i)=f1;reloc(2,i)=f2;reloc(3,i)=f3;reloc(4,i)=f4;reloc(5,i)=f5;reloc(6,i)=f6;reloc(7,i)=f7;reloc(8,i)=f8;reloc(9,i)=f9;reloc(10,i)=f10;
        reloc(11,i)=f11;reloc(12,i)=f12;reloc(13,i)=f13;reloc(14,i)=f14;reloc(15,i)=f15;reloc(16,i)=f16;
        
    end
end
LL=size(reloc);
for i=1:LL(1,1)
n(1,i)=mean(reloc(i,:));
%n2(1,i)=array2(1,i);
end
end
