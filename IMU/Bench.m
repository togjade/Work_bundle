%% with scores
% Data names and descriprion:
% data_array - [point(end,1) point(end,2) finger_angle x_g y_g finger_angle_g];
% data_glove_array - calibrated IMU data(1:54,:)+ Arduino time(55,:) + PCtime(56,:)  
% quaternion - 4d-quaternions for 6 IMU sensors (4,:,6)
% rmsval - rms value across for 8 chanels for defined window
% data_EMG_log - mm.myoData.emg_log at the time of stop;
% data_timeEMG_log - mm.myoData.timeEMG_log at the time of stop;
% data_last_time - PCtime at the time of stop;

%% Model 1D, wrist flexion/extension
% only 2 chanels of data will be used
% scaling is added with coefficient 95% so maximum recorded RMS value - is
% 0.95 of the scale value
%% quaternion initialization
addpath('quaternion_library');      % include quaternion library
AHRS1 = MadgwickAHRS('SamplePeriod', 1/100, 'Beta', 10);
AHRS2 = MadgwickAHRS('SamplePeriod', 1/100, 'Beta', 10);
AHRS3 = MadgwickAHRS('SamplePeriod', 1/100, 'Beta', 10);
AHRS4 = MadgwickAHRS('SamplePeriod', 1/100, 'Beta', 10);
AHRS5 = MadgwickAHRS('SamplePeriod', 1/100, 'Beta', 10);
AHRS6 = MadgwickAHRS('SamplePeriod', 1/100, 'Beta', 10);   %sqrt(3.0 / 4.0)*14*pi/180=0.21
AHRS=[AHRS1, AHRS2, AHRS3, AHRS4, AHRS5, AHRS6];
quaternion=[];
quat_ref=[0.1647   -0.6784   -0.1199   -0.7059];    % rest position perpendicular to PC screen
%% Myo object initialization
countMyos = 1;
mm = MyoMex(countMyos);
disp('Myo connected')
%% Ardunino initialization
% Create serial object for Arduino 
s = serial('COM6','BaudRate',1000000); % change the COM Port number as needed (Lowest)
%s.InputBufferSize = 4096; % read only one byte every time 
s.InputBufferSize = 220;
try 
    fopen(s); 
catch err 
    fclose(instrfind);
    error('Make sure you select the correct COM Port where the Arduino is connected.');
end
set(s,'Terminator','CR/LF');
%% Model initiaization
rms = dsp.RMS('Dimension','row');
%**************************************************************************
matrixXY=[1 1/sqrt(2) 0 -1/sqrt(2) -1 -1/sqrt(2)  0  1/sqrt(2); ...
          0 1/sqrt(2) 1  1/sqrt(2)  0 -1/sqrt(2) -1 -1/sqrt(2)]';
%**************************************************************************
% matrixXY=[-1  0  0    1  0  0  0  0; ...
%            0  0  0    0  0  0  0  0]';      
calibration=[0.6525 0.3951 0.5401 0.7020 0.7560 0.5884 0.5600 0.5426]*1.05;
% maximum values for all chanels with 5% increase
%**************************************************************************
point=[0 0];rmsval=zeros(1,8);
%%
%image
drawArrow = @(x,y) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0,'linewidth',3); 
figure(10);
viscircles([0, 0],1,'color',[0.8 0 0.8]);
hold on
grid on
xlim([-1.5, 1.5]);ylim([-1.5 1.5]);
arrow_h=drawArrow([0 0],[0 0]); % h - for EMG based algorithm
set(arrow_h,'color',[0 0.4470 0.7410]);
arrow_g=drawArrow([0 0],[0 0]); % g - for Tracking glove
set(arrow_g,'color',[0.8500 0.3250 0.0980]);
sphere_h=plot(0.4*cosd(0:360/20:370),0.4*sind(0:360/20:370));
set(sphere_h,'color','r');
sphere_g=plot(0.4*cosd(0:360/20:370),0.4*sind(0:360/20:370));
set(sphere_g,'color',[0.8 0 0.8]);
drawnow;
%end image
fread(s);
data_array=[];data_glove_array=[];
z=0;    
zm=[]; set(gcf,'keypress','zm=get(gcf,''currentchar'');');
while 1
    tic
    
    % read Glove
    fwrite(s,'a');
    data=fgetl(s);
    while length(data)~=110
        data=fgetl(s);
        disp('chpth')
        %s.BytesAvailable
        if s.BytesAvailable>110
            fread(s);
        end
    end
    values=zeros(55,1);
    for i=1:55
        values(i)=typecast([uint8(data(2*(i-1)+2)) uint8(data(2*(i-1)+1))],'int16');
    end
    data_line=conversion_My(values);    % IMU data in proper units and scaling
    data_glove_array(:,end+1)=[data_line; now];
    quaternion(:,end+1, 1) = zeros(4,1,1);
    for j=1:6
        AHRS(j).Update(data_line(9*(j-1)+1:9*(j-1)+3)', data_line(9*(j-1)+4:9*(j-1)+6)', data_line(9*(j-1)+7:9*(j-1)+9)');	% gyroscope units must be radians
        quaternion(:,end, j) = AHRS(j).Quaternion;
    end
    %quaternion(:,end, 7)=mm.myoData.quat; no need moves to much
    
    % read EMG
    Sample=mm.myoData.emg_log(end-20:end,:);
    rmsval(end+1,:) = rms(Sample')';
    point(end+1,:)=4*(rmsval(end,:)./calibration)*matrixXY;
    
    % plot arrow rest state arrow UP
    relatve_rotation=quatmultiply(quatinv(quaternion(:,end, 6)'),(quat_ref));
    ny = quatrotate(relatve_rotation, [0 -1 0]); nz = quatrotate(relatve_rotation, [1 0 0]);
    x=ny(3);y=ny(1); % position of the cursor: 
    % projection of -y to the x -> y*; projection of -y to the z -> x*
    yz=nz(1)/sqrt(nz(1)^2+nz(3)^2);    % orientation of the cursor: projection of Z on Z is the arrow length on Y*
    xz=nz(3)/sqrt(nz(1)^2+nz(3)^2);    % projection of Z on Z is the arrow length on X*
    X_g = [x-0.5*xz x+0.5*xz];
    Y_g = [y-0.5*yz y+0.5*yz];
    % fingers 
    sum_ang=0;sum_n=0;sum_x=0;sum_y=0;
    for k=1:4
        if sum(isnan(quaternion(:,end, k)))>0
            continue
        end
        fing1_x = quatrotate(quatmultiply(quatinv(quaternion(:,end, k)'),(quaternion(:,end, 6)')), [1 0 0]);
        sum_y=sum_y-fing1_x(3)/norm(fing1_x(2:3)); sum_x=sum_x-fing1_x(2)/norm(fing1_x(2:3)); sum_n=sum_n+1;
    end
    finger_angle=atan2(sum_y/sum_n,sum_x/sum_n);
    if finger_angle<(-pi/2)
        finger_angle=2*pi+finger_angle;
    end
    %finger_angle*180/pi
    finger_angle_g=finger_angle;
    SphereX_g=0.4*(3/2*pi-finger_angle)/(3/2*pi)*cosd(0:360/20:370)+x;
    SphereY_g=0.4*(3/2*pi-finger_angle)/(3/2*pi)*sind(0:360/20:370)+y;
    

    % position of the cursor EMG: 
    x=point(end,1);y=point(end,2);
    xz=0;yz=1;finger_angle=0;
    X = [x-0.5*xz x+0.5*xz];
    Y = [y-0.5*yz y+0.5*yz];
    SphereX=0.4*(3/2*pi-finger_angle)/(3/2*pi)*cosd(0:360/20:370)+x;
    SphereY=0.4*(3/2*pi-finger_angle)/(3/2*pi)*sind(0:360/20:370)+y;
    
    if mod(z,10)==0
        set(arrow_h,'xdata',X(1),'ydata',Y(1),'udata',X(2)-X(1),'vdata',Y(2)-Y(1));
        set(sphere_h,'xdata',SphereX,'ydata',SphereY); 
        set(arrow_g,'xdata',X_g(1),'ydata',Y_g(1),'udata',X_g(2)-X_g(1),'vdata',Y_g(2)-Y_g(1));
        set(sphere_g,'xdata',SphereX_g,'ydata',SphereY_g); 
        drawnow;
        clc;
    end
    % x_emg y_emg finger_emg x_g y_g finger_g
    data_array(end+1,:)=[point(end,1) point(end,2) finger_angle ny(3) ny(1) finger_angle_g];
    
    % to stop the image
    if ~isempty(zm)
        if strcmp(zm,'s') 
             disp('end'); 
             zm=[];
             data_EMG_log=mm.myoData.emg_log;
             data_timeEMG_log=mm.myoData.timeEMG_log;
             data_last_time=now;
             break;
        end
    end 
    
%     while 1                 % to keep synchronized
%        if toc>0.010
%            break
%        end
%           java.lang.Thread.sleep(0.0010*1000); %pause for 1ms
%     end
    z=z+1;    
    toc
end

%% Disconnect
fclose(s); %Close arduino port
mm.delete(); % clean up    
disp('Myo disconnected')