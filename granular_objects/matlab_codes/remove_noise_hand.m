clear;clc;
load('buckwheatHand_15.mat')
load('beansHand_15.mat')
load('noiseHand_15.mat')
load('saltHand_15.mat')
%%
beans = P_P(beansHand_15);
%%
noise=P_P(noiseHand_15);
%%
function diF = P_P(A) % A - cell data
for i = 1:length(A)
    a = A{i}(:, 2);
    p = A{i}(:, 1);
    maxV=max(p);
    ind=find(p==maxV, 1);
    deltaP=maxV-p(1:1);
    dif= deltaP./(ind);
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
    %loglog(f,2*abs(Y(1:NFFT/2+1)));
    P=2*abs(Y(1:NFFT/2+1));
    subplot(3,5,i)
    %plot(f,P);
    periodogram(z, hamming(L));
    P_2=P.^2; %power
    P_3=(P_2.').*f; 
    SC = sum(P_3)/(sum(P_2));% spectral centroid SC
    Pl =(1/L)*(sum(z.^2)); % power P
    diF{i} = [SC Pl];
end
end