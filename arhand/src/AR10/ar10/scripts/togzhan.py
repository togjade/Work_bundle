#!/usr/bin/env python
#Active8 Robots, AR10 hand posing tool
#Beta release 1.2
#Written by Nick Hornsey
#Last edited on 26/10/16

#The following program uses Parser Arguments in order to move the hand into a selection of pre-defined poses.
#This program can be run from the ROS workspace using the folowing command:

#rosrun ar10 ar10_pose_hand.py -o

#This uses argument "-o" in order to open the hand, other arguments can be found using the "-h" argument instead:

#rosrun ar10 ar10_pose_hand.py -h

from ros_ar10_class import ar10 # necessary imports in order for the program to run
import time
import sys
import os
import random
import serial
import subprocess
import argparse

import rosbag 
from std_msgs.msg import Float32, Float32MultiArray
i=0
j=0

def main():
    parser = argparse.ArgumentParser() #defines argument parser
    pose_group = parser.add_mutually_exclusive_group(required=True) #adds group of arguments "pose_group"
    pose_group.add_argument("-v1", help = "moves to ok hand position",action='store_true') # argument for ok
    pose_group.add_argument("-v2", help = "moves hand to random pose",action='store_true') # argument for r
    args = parser.parse_args()
    
    if args.v1:

    	hand = ar10()
        hand.change_speed(60)
        hand.set_speed(8)
        hand.set_speed(9)
        hand.set_speed(0)
        hand.set_speed(1)
    	hand.move(0,6000)
    	hand.move(1,7000)

    	hand.move(8,6000)
    	hand.move(9,5000)
    	hand.wait_for_hand()
        hand.move(0,6000)
        hand.move(1,8000)

    	hand.move(8,7000)
        hand.move(9,7000)
        hand.wait_for_hand()
        print ('ok complete')
        hand.close()
  

    if args.v2:
    	global j
    	hand = ar10()
    	hand.move(0,6000)
    	hand.move(1,7000)
    	while j < 10:
    		hand = ar10()
    		print ("iteration" ,i)
    		hand.change_speed(40)
    		hand.set_speed(8)
    		hand.set_speed(9)
    		hand.move(8,6000)
    		hand.move(9,5000)
    		hand.wait_for_hand()
    		hand.move(8,7000)
    		hand.move(9,7000)
    		hand.wait_for_hand()
    		print ('ok complete')
    		hand.close()
    		i=i+1  


if __name__ == "__main__":
    main()
