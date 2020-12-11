%% upload .mat data
cd C:\Users\tactile_pc1\Desktop\Togzhanfiles\experiments\gripper\mat_files\
fileNames = dir('*.mat');
fileNames = {fileNames.name}; % loads all csv files 
for i=1:length(fileNames)
    load(string(fileNames{i}));
end
%% plot data
for i = 1:length(data_gripper_on2)
    %data_gripper_on{1,i} = data_gripper_on{1,i}(1700:end,:);
    hold on
    subplot(3,2,i)
    plot(data_gripper_on2{i}(:,1));
end
%% show splitted data 
for i = 1:length(data_gripper_on2)
    a = data_gripper_on2{1,i};
    for j = 1:29
%         if j == 29 
%             b{i}{j} = data_gripper_on2{1,i}(1+2000*(j-1):end,:);
%         else
            b{i}{j} = data_gripper_on2{1,i}(1+2000*(j-1):2000*(j),:);
%         end
        hold on
        subplot(3,10,j)
        plot(b{1}{j}(:,1));
    end
end
%% save splitted data
data_trial_grip_on2= b;
save('data_trial_grip_on2.mat', 'data_trial_grip_on2');
%% compute fft
for i = 1:length(data_trial_grip_close)
    data = data_trial_grip_close{i};
    for j  = 1 :length(data)
        Data_on{i}{j} = P_P(data{j}(:,2));
    end
end
%% save fft data 
save('Data_on2.mat', 'Data_on2');
save('Data_on2_noise.mat', 'Data_on2_noise');
%% plot fft
for i = 1:length(Data_on2)
    data = Data_on2{i};
    for j = 1:1%length(data)
        subplot(2,3,i);
        f = data{j}(1,:);
        P = (data{j}(2,:)).';
        plot(f,P);
%         title(['Obj #'+i]);
    end
end
%% fft pof each separately
cd C:\Users\tactile_pc1\Desktop\Togzhanfiles\experiments\gripper\mat_files\30_05_19_on
rice_fft_on2 = Data_on2{1};save('rice_fft_on2','rice_fft_on2');
soda_fft_on2 = Data_on2{2};save('soda_fft_on2','soda_fft_on2');
salt_fft_on2 = Data_on2{3};save('salt_fft_on2','salt_fft_on2');
nut_fft_on2 = Data_on2{4};save('nut_fft_on2','nut_fft_on2');
beans_fft_on2 = Data_on2{5};save('beans_fft_on2','beans_fft_on2');
%% function to get features from fft 
T_close_pressure = [];
for i = 1:length(data_trial_grip_close) % 9
    DD = data_trial_grip_close{i};
    for k =1:length(DD) % 29
        T_close_pressure(k+29*(i-1),:) = DD{k}(:,1).';
    end
end
%T_close = [Line_close fft_data];
%%
T_24 = [];% i -1 - 9 // j 1 - 29
features = {};
for i = 1:length(Data_on2)
    data = Data_on2{i};
    for j = 1:24%length(data)
        input = data{j}(2,:);
        T_24(j+24*(i-1),:) = [input];
    end
end
%% plot accel data
for i = 1:length(data_trial_grip_on2)
    data = data_trial_grip_on2{i};
    for j = 1:1%length(data)
        subplot(3,3,i)
        plot(data{j}(:,2));
    end
end
%% Signal noise ratio SNR
% SNR = average_power_signal / average_power_noise 
% SNR = (average_amplitude_signal / average_amplitude_noise)^2
for i = 1:length(Data_on2)
    data = Data_on2{i};
    data_noise = Data_on2_noise{i};
    D1=data_trial_grip_on2{i}; 
    for j = 1: length(D1)
%         f = data{j}(:,1);
%         f_noise = data_noise{j}(:,1);
%         P = (data{j}(:,2)).';
%         P_noise = (data_noise{j}(:,2)).';
%         meanS = mean(P.*f);
%         meanN = mean(P_noise.*f_noise);
        f_noise = data_noise{j}(:,1);
        SNR{i}(1,j) = snr(D1{j}(:,2), D1{j}(:,3));%(meanS/meanN).^2;
    end
end
%% function for fft
function dif = P_P(a) % A - lowerbound B- upperbound C-csv fie name
y=a-mean(a);y=detrend(y);
Fs = 1000;
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
dif = [f; P.'];
end