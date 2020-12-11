cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\ad_csv_final 
%%
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\ad_csv_final\data_sc_p
%%
csv = dir('*.csv');
csvNames = {csv.name};
load('rangeLow.mat');
load('rangeUP.mat');
%% soda ok
filename = csvNames(1,41:45);
soda_data=p_p(range_l.soda,range_u.soda,filename);
%% beans ok
filename = csvNames(1,1:5);
beans_data=p_p(range_l.beans,range_u.beans,filename);
%% buckwheat 
filename = csvNames(1,6:10);
buckwheat_data=p_p(range_l.buckwheat,range_u.buckwheat,filename);
%% kuskus ok
filename = csvNames(1,11:15);
kuskus_data=p_p(range_l.kuskus,range_u.kuskus,filename);
%% lentis ok
filename = csvNames(1,16:20);
lentis_data=p_p(range_l.lentis,range_u.lentis,filename);
%% nut ok
filename = csvNames(1,21:25);
nut_data=p_p(range_l.nut,range_u.nut,filename);
%% peas 
filename = csvNames(1,26:30);
peas_data=p_p(range_l.peas,range_u.peas,filename);
%% rice ok
filename = csvNames(1,31:35);
rice_data=p_p(range_l.rice,range_u.rice,filename);
%% salt 
filename = csvNames(1,36:40);
salt_data=p_p(range_l.salt,range_u.salt,filename);
%% struct
data.beans_data=beans_data;
data.buckwheat_data=buckwheat_data;
data.kuskus_data=kuskus_data;
data.lentis_data=lentis_data;
data.nut_data=nut_data;
data.peas_data=peas_data;
data.rice_data=rice_data;
data.salt_data=salt_data;
data.soda_data=soda_data;
save('data.mat','data');
%%
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\ad_csv_final\data_sc_p
%%
save('beans_data.mat','beans_data');
save('buckwheat_data.mat','buckwheat_data');
save('kuskus_data.mat','kuskus_data');
save('lentis_data.mat','lentis_data');
save('nut_data.mat','nut_data');
save('peas_data.mat','peas_data');
save('rice_data.mat','rice_data');
save('salt_data.mat','salt_data');
save('soda_data.mat','soda_data');
%% working f-ns to split and get delataP and magnitude
function p = p_p(L,U,filename)
l=length(filename);
for i = 1:l
b=(filename{i});
low=(L{i});
up=(U{i});
f=length(low);
%p=cell(1,l);
    for j=1:f
        a=P_P(low(1,j),up(1,j),b);% returns dif[1x2]
        c=a(1,1);% dif
        d=a(1,2);% S
        pp(1,j)=c;% dif
        pp(2,j)=d;% S
    end
p{i}=pp;
end
end
function dif = P_P(A,B,C) % A - lowerbound B- upperbound C-csv fie name
a=csvread(C, A, 1,[A,1,B,1]);%17671
y=a-mean(a);y=detrend(y);
Fs = 8000;
Fnorm = 5/(Fs/2); % Normalized frequency
df = designfilt('highpassiir',...
               'PassbandFrequency',Fnorm,...
               'FilterOrder',2,...
               'PassbandRipple',1,...
               'StopbandAttenuation',100);
z = filter(df,y);
L=length(z);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(z,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
P=2*abs(Y(1:NFFT/2+1));
P_2=P.^2;
P_3=(P_2.').*f;
SC = sum(P_3)/(sum(P_2));
P =(1/L)*(sum(z.^2)); 
dif = [SC P];
end