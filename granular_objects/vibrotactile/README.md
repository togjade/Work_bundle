
1. Command to run on the Centos 7

		1.1. Turn on the computer -> choose advanced options for centos 7 -> choose second one from the top

		1.2. Open the terminal and run following commands in given order
    
				1.2.1. export ROS_MASTER_URI=http://10.1.71.79:11311
        
				1.2.2. export ROS _IP=10.1.70.233
        
				1.2.3. rosrun nidaq Togzhan6221
   
2. On the computer with Ubuntu ->

		2.1. In 1nd terminal:
    
				2.1.1. sudo –i
        
				2.1.2. source /home/user/catkin_ws/devel/setup.bash
        
				2.1.3. roslaunch schunck_ezn64 ezn64_usb_control.launch
        
		2.2. In 2nd terminal:
    
				2.2.1. rosservice call /schunck_ezn64/reference
        
		2.3. In 3rd terminal:
    
				2.3.1.rosrun rosserial_python serial_node.py /dev/ttyACM0
        
				2.3.2. roslaunch gripper
        
