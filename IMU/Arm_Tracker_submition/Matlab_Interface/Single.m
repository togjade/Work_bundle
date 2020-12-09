 %% APPENDIX 1. MATLAB CODE 
addpath('/home/togzhan/Documents/Arm_Tracker_submition/Matlab_Interface/madgwick_algorithm_matlab/');
addpath('/home/togzhan/Documents/Arm_Tracker_submition/Matlab_Interface/madgwick_algorithm_matlab/quaternion_library');
clear; clc; close all; 
 
% Copyright 2014 The MathWorks, Inc. 
% if octave
% pkg load instrument-control
 
%% Create serial object for Arduino 
s = serial('/dev/ttyUSB1','BaudRate',115200); % change the COM Port number as needed
%s = serial('/dev/ttyUSB0',115200);
%% Connect the serial port to Arduino 
%%m s.InputBufferSize = 1024; % read only one byte every time 
try 
    fopen(s); 
catch err 
    fclose(instrfind);
    error('Make sure you select the correct COM Port where the Arduino is connected.');
end
%%
%%t = tcpip('127.0.0.1', 5005, 'NetworkRole', 'client');
%%fopen(t);
%%
results=zeros(6,9); 
% madgwick filter
Samp_per=0.025;
Filt_beta=0.05;
AHRS1 = MadgwickAHRS('SamplePeriod', Samp_per, 'Beta', Filt_beta);
AHRS2 = MadgwickAHRS('SamplePeriod', Samp_per, 'Beta', Filt_beta);
AHRS3 = MadgwickAHRS('SamplePeriod', Samp_per, 'Beta', Filt_beta);
AHRS4 = MadgwickAHRS('SamplePeriod', Samp_per, 'Beta', Filt_beta);
AHRS5 = MadgwickAHRS('SamplePeriod', Samp_per, 'Beta', Filt_beta);
AHRS6 = MadgwickAHRS('SamplePeriod', Samp_per, 'Beta', Filt_beta);


q = zeros(6,4); 
euler = zeros(6,3);
axang = zeros(6,4);
ang = zeros(6,3); 
%%
Storage=zeros(1,9);
%%

flushinput(s);
%srl_flush(s);
%srl_read(s,1024)

gyroToM=pi*2000/(180*2^16);
acceToM=9.81*8/(2^12);
magnToM=8/(2^16)*0.0001;

gyroToM=1;
% acceToM=1;
% magnToM=1;

accelFilt=zeros(6,3,20);

while 1
tic
  % Read buffer data 
   while i<6
        data = fgetl(s);
%         red_temp=0;
%         data=[];
%         while red_temp~=10
%             red_temp=read(s,1);
%             data(end+1)=red_temp;
%         end
%         disp(data)
        %
        temp = str2double(strsplit(char(data)));
        if floor(temp(1)/777)==10 && length(temp)>=10
            cur_sens=temp(1)-7769;
            results(cur_sens,:)=temp(2:10);
%             %
%             accelFilt(cur_sens,:,1:19)=accelFilt(cur_sens,:,2:20);
%             accelFilt(cur_sens,:,20)=temp(5:7);
%             results(cur_sens,4:6)=[sum(accelFilt(cur_sens,1,:))/20 ...
%                 sum(accelFilt(cur_sens,2,:))/20 sum(accelFilt(cur_sens,3,:))/20];
%             %
        else
            flushinput(s);
            %srl_flush(s);
            i=i-1;
        end
        i=i+1;
   end
   i=1;
   flushinput(s);
   disp("read_finish")
   Storage(end+1,:)=results(1,:);
   
   if ~all(all(not(isnan(results'))))
       continue
   end

   AHRS1.Update(gyroToM*[results(1,1) results(1,2) results(1,3)] , acceToM*[results(1,4) results(1,5) results(1,6)], magnToM*[results(1,7) results(1,8) results(1,9)]);
   AHRS2.Update(gyroToM*[results(2,1) results(2,2) results(2,3)] , acceToM*[results(2,4) results(2,5) results(2,6)], magnToM*[results(2,7) results(2,8) results(2,9)]);
   AHRS3.Update(gyroToM*[results(3,1) results(3,2) results(3,3)] , acceToM*[results(3,4) results(3,5) results(3,6)], magnToM*[results(3,7) results(3,8) results(3,9)]);
   AHRS4.Update(gyroToM*[results(4,1) results(4,2) results(4,3)] , acceToM*[results(4,4) results(4,5) results(4,6)], magnToM*[results(4,7) results(4,8) results(4,9)]);
   AHRS5.Update(gyroToM*[results(5,1) results(5,2) results(5,3)] , acceToM*[results(5,4) results(5,5) results(5,6)], magnToM*[results(5,7) results(5,8) results(5,9)]);
   AHRS6.Update(gyroToM*[results(6,1) results(6,2) results(6,3)] , acceToM*[results(6,4) results(6,5) results(6,6)], magnToM*[results(6,7) results(6,8) results(6,9)]);
   
   q(1,:) = AHRS1.Quaternion;
   q(2,:) = AHRS2.Quaternion;
   q(3,:) = AHRS3.Quaternion;
   q(4,:) = AHRS4.Quaternion;
   q(5,:) = AHRS5.Quaternion;
   q(6,:) = AHRS6.Quaternion;
   
   %
   for n =1:6 
         euler(n,:) = quatern2euler(quaternConj(q(n,:)) * 180/pi);
         axang(n,:) = quat2axang(q(n,:));
         axang(n,4) = axang(n,4)*180/pi; 
         [y, p, r] = quat2angle(q(n,:));
         ang(n,:) = [y p r]; 
    end 
     ang = ang*180/pi;
     %ang = ang+nn;
     th1 = ang(1:5,2)-[1 1 1 1 1]'*ang(6,2);
     q;
     ang
     %th1'; 
     %results;
     %axang; 
     %euler(1,:); 
     %results(1,4:6); 
     %q(1,:);
     %q(2,:);
     %axang(1,:); 
     %ang(1,:);
    
     tht = (81*[1 1 1 1 1]'+4*14*9*abs(th1)).^0.5;
     thp = (tht-9*[1 1 1 1 1]')/28;
     thd = thp.^2*2/3;
     thd(5)=8/23*th1(5); 
     a=mat2str(floor(thd'));
     %%fwrite(t,a);
%    
   % use conjugate for sensor frame relative to Earth and convert to degrees. 
%    x_plot=[1 0 0];
%    y_plot=[0 1 0];
%    z_plot=[0 0 1];
%    q_plot=quatinv(q(1,:));
%    x_sens=quatrotate(q_plot,x_plot);
%    y_sens=quatrotate(q_plot,y_plot);
%    z_sens=quatrotate(q_plot,z_plot);
%    ll=0:0.05:1;
%    x_plot=x_plot.*ll';
%    y_plot=y_plot.*ll';
%    z_plot=z_plot.*ll';
%    
%    x_sens=x_sens.*ll';
%    y_sens=y_sens.*ll';
%    z_sens=z_sens.*ll';
%    
%    plot3(x_plot(:,1),x_plot(:,2),x_plot(:,3));
%    hold on
%    plot3(y_plot(:,1),y_plot(:,2),y_plot(:,3));
%    plot3(z_plot(:,1),z_plot(:,2),z_plot(:,3));
%    grid on
%    plot3(x_sens(:,1),x_sens(:,2),x_sens(:,3));
%    plot3(y_sens(:,1),y_sens(:,2),y_sens(:,3));
%    plot3(z_sens(:,1),z_sens(:,2),z_sens(:,3));
%    hold off
%    xlim([-1.5 1.5]);
%    ylim([-1.5 1.5]);
%    zlim([-1.5 1.5]);
     while 1                 % to keep synchronized
       if toc>0.025
           break
       end
       java.lang.Thread.sleep(0.0010*1000); %pause for 1ms
     end
    
   toc
   disp(toc)
end

%% close files
fclose(s);
delete(s); clear s;