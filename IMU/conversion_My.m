%% conversion of raw IMU values to AHRS ready
function [values]=conversion_My(values)
data_line=values;

m_min=zeros(1,3,6);
m_min(:,:,1)=[ -4589,  -4085,  -4281];
m_min(:,:,2)=[ -4505,  -3986,  -4353];
m_min(:,:,3)=[ -4412,  -4069,  -4037];
m_min(:,:,5)=[ -4268,  -3916,  -4156];
m_min(:,:,5)=[ -4058,  -3816,  -3689];
m_min(:,:,6)=[ -3792,  -3711,  -1783];
m_max=zeros(1,3,6);
m_max(:,:,1)=[ +3275,  +3488,  +2830];
m_max(:,:,2)=[ +3275,  +3343,  +2807];
m_max(:,:,3)=[ +3487,  +3681,  +2827];
m_max(:,:,5)=[ +3616,  +3853,  +2492];
m_max(:,:,5)=[ +3945,  +3786,  +2945];
m_max(:,:,6)=[ +3663,  +3946,  +5202];
% default running_min = {32767, 32767, 32767}, running_max = {-32768, -32768, -32768};
% Calibration data:
% 0: min: { -4589,  -4085,  -4281}    max: { +3275,  +3488,  +2830}
% 1: min: { -4505,  -3986,  -4353}    max: { +3275,  +3343,  +2807}
% 2: min: { -4412,  -4069,  -4037}    max: { +3487,  +3681,  +2827}
% 3: min: { -4268,  -3916,  -4156}    max: { +3616,  +3853,  +2492}
% 4: min: { -4058,  -3816,  -3689}    max: { +3945,  +3786,  +2945}
% 5: min: { -3792,  -3711,  -1783}    max: { +3663,  +3946,  +5202}

g_offset=zeros(1,3,6);
% g_offset(:,:,1) =[   1.7100  -32.8060  -12.5980];
% g_offset(:,:,2) =[  19.4390  -14.3820   -5.6970];
% g_offset(:,:,3) =[   9.6620  -19.6520  -17.7880];
% g_offset(:,:,4) =[   2.8490  -12.9650    8.6600];
% g_offset(:,:,5) =[  -0.7220   55.4190   -3.3020];
% g_offset(:,:,6) =[  -2.0900   -3.2180   14.6290];
g_offset(:,:,1) =[   1.7579  -34.1473  -13.2838];
g_offset(:,:,2) =[  20.4412  -14.2838   -4.1726];
g_offset(:,:,3) =[   8.0815  -21.2029  -21.4305];
g_offset(:,:,4) =[   3.1176  -13.7971    9.8047];
g_offset(:,:,5) =[   2.0164   53.8477   -2.7118];
g_offset(:,:,6) =[  -1.0973   -3.8622    8.5626];



for j=1:6                           % dps(degrees per second)
    % gyro: 2000 dps full scale, normal power mode, all axes enabled, 100 Hz ODR 12.5Hz Bandwith
    values(9*(j-1)+1:9*(j-1)+3)=(data_line(9*(j-1)+1:9*(j-1)+3)'-g_offset(:,:,j))*0.07 * (pi/180);   %  rad/s
    values(9*(j-1)+4:9*(j-1)+6)=data_line(9*(j-1)+4:9*(j-1)+6) * 0.000244;  % accelerom: 8 g full scale, 16bit representation, all axes enabled, 100 Hz ODR
    values(9*(j-1)+7:9*(j-1)+9)=((data_line(9*(j-1)+7:9*(j-1)+9)'-m_min(:,:,j))./(m_max(:,:,j)-m_min(:,:,j)) * 2 -1 );%* 4/65535;  % magnetom 
    % compass.m_min = (LSM303::vector<int16_t>){-32767, -32767, -32767};
    % compass.m_max = (LSM303::vector<int16_t>){+32767, +32767, +32767};
                                    %gyroscope units must be radians
end




end


% for j=1:6                           % dps(degrees per second)
%     % gyro: 2000 dps full scale, normal power mode, all axes enabled, 100 Hz ODR 12.5Hz Bandwith
%     values(9*(j-1)+1:9*(j-1)+3)=(data_line(9*(j-1)+1:9*(j-1)+3)'-g_offset(:,:,j)) * (pi/180)*(8.75 / 1000);   %  rad/s
%     values(9*(j-1)+4:9*(j-1)+6)=data_line(9*(j-1)+4:9*(j-1)+6)*(0.061 / 1000);% * 8/32767;  % accelerom: 8 g full scale, 16bit representation, all axes enabled, 100 Hz ODR
%     values(9*(j-1)+7:9*(j-1)+9)=(data_line(9*(j-1)+7:9*(j-1)+9)'-(m_min(:,:,j) + m_max(:,:,j)) / 2 )*(0.00014615609);% 4/65535;  % magnetom 
%     % compass.m_min = (LSM303::vector<int16_t>){-32767, -32767, -32767};
%     % compass.m_max = (LSM303::vector<int16_t>){+32767, +32767, +32767};
%                                     %gyroscope units must be radians
% end