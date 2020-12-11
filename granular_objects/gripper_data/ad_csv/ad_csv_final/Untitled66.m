cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\ad_csv_final 
%%
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\ad_csv_final\data_by_trials_cell\
save('beans_data.csv','beans_data');
%%
save('buckwheat_data.mat','buckwheat_data');
save('kuskus_data.mat','kuskus_data');
save('lentis_data.mat','lentis_data');
save('nut_data.mat','nut_data');
save('peas_data.mat','peas_data');
save('rice_data.mat','rice_data');
save('salt_data.mat','salt_data');
save('soda_data.mat','soda_data');
%%
csv = dir('*.csv');
csvNames = {csv.name};
load('rangeLow.mat');
load('rangeUP.mat');
%% soda ok
filename = csvNames(1,41:45);
soda_data=p_p(range_l.soda,range_u.soda,filename);
%%
save('S.');
%%
S1=cell2table(soda_data{1});
S2=cell2table(soda_data{2});
S3=cell2table(soda_data{3});
S4=cell2table(soda_data{4});
S5=cell2table(soda_data{5});
S=table(S1, S2, S3, S4, S5);
%%
for i=1:1
    L=length(soda_data{i});
    for j=1:L
        T = soda_data{i}{j}; % Whatever you do to get your table
        fname = ['MyTable',num2str(i*j),'.csv']; % or .txt, or however you want to save it
    end
end
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
%%
function p = p_p(L,U,filename)
l=length(filename);
for i = 1:l
b=(filename{i});
low=(L{i});
up=(U{i});
f=length(low);
    for j=1:f
        a{j}=P_P(low(1,j),up(1,j),b);% returns dif[axp]=size[N 2]
    end
p{i}=a;
end
end
function dif = P_P(A,B,C) % A - lowerbound B- upperbound C-csv fie name
a=csvread(C, A, 1,[A,1,B,1]);%17671
p=csvread(C, A, 0,[A,0,B,0]);
dif=[a p];
end
%%
%%
function dif = P_P(A,B,C) % A - lowerbound B- upperbound C-csv fie name
a=csvread(C, A, 1,[A,1,B,1]);%17671
p=csvread(C, A, 0,[A,0,B,0]);
y=a-mean(a);y=detrend(y);
k=1000;
rice=P_P(22*k,23*k,'rice_140.csv');
% system impedance (ohms)
R=50;
% sampling frequency (Hz)
fs=5000;
% number of time-domain samples
L=length(a);
% time vector for time-domain signal (s)
t=1/fs*[1:L];
% frequency vector for frequency-domain signal (Hz)
nfft=L;
f=fs/2*[-1:2/nfft:1-2/nfft];
% create demonstration sinusoids and noise signals (V)
ns=wgn(L,1,-10,1,[],'dBm','real').';
s=1*cos(2*pi*18e6*t)+0.02*cos(2*pi*35e6*t)+ns;
% normalized FFT of signal
S=(fftshift(fft(a,nfft))/(L));
% power spectrum
Sp=10*log10((abs(S).^2)/R*1000);
% plot time-domain signal
figure(1)
clf
plot(t/1e-9,a)
title('Time-Domain Signal')
xlabel('Time (ns)')
ylabel('Amplitude (V)')
axis([0 1000 -1 1])
% plot power spectrum
figure(2)
clf
plot(f/L,Sp)
title('Power Spectrum Using Linear Scale')
xlabel('Frequency (MHz)')
ylabel('Relative Amplitude (linear)')
dif = 0;
end