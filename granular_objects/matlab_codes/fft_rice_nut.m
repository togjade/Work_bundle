cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\exp_9_02\ad_csv\ad_csv_final\
load('rice_140.csv');
%%
cd C:\Users\tactile_pc1\Downloads\Togzhanfiles\plots\
%%
k=1000;
P_P(6.6*k,7.4*k,'nut_140.csv');
%%
P_P(14.5*k,15.6*k,'nut_60.csv');
%%
P_P(20*k,21.8*k,'rice_60.csv');
%%
P_P(22*k,23*k,'rice_140.csv');
%%
function dif = P_P(A,B,C) % A - lowerbound B- upperbound C-csv fie name
a=csvread(C, A, 1,[A,1,B,1]);%17671
p=csvread(C, A, 0,[A,0,B,0]);
y=a-mean(a);y=detrend(y);
Fs = 5000;
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
figure('DefaultAxesFontSize',20);
plot(f,2*abs(Y(1:NFFT/2+1)));
figure('DefaultAxesFontSize',20);
plot(p(1:30:end));
figure('DefaultAxesFontSize',20);
plot(a);
dif = 0;
end