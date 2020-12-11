#!/usr/bin/env python
import rospy
from std_msgs.msg import Float32, Float32MultiArray 
import numpy as np
import time
from ros_ar10_class import ar10 # necessary imports in order for the program to run
import sys
import os
import random
import serial
import subprocess
import argparse

handGlobal = np.float32()
handGlobal = 0

def callbackHand(hand_msg):
    global handGlobal
    handGlobal=hand_msg.data


def listener3():
    rospy.Subscriber("hanD", Float32, callbackHand)

def talker():
    
    while not rospy.is_shutdown():
        if handGlobal == 1:
            hand = ar10()
            hand.change_speed(60)
            hand.set_speed(8)
            hand.set_speed(9)
            hand.set_speed(0)
            hand.set_speed(1)
            hand.move(0,6000)
            hand.move(1,6800)
            hand.move(8,6000)
            hand.move(9,5500)
            hand.wait_for_hand()
            hand.close()
            #handGlobal = 0;
        if handGlobal == 0:
            hand = ar10()
            hand.change_speed(60)
            hand.set_speed(8)
            hand.set_speed(9)
            hand.set_speed(0)
            hand.set_speed(1)
            hand.move(0,6000)
            hand.move(1,70200)
            hand.move(8,6300)
            hand.move(9,6500)
            hand.wait_for_hand()
        
        rate.sleep()

if __name__ == '__main__':

    rospy.init_node('listener1', anonymous=True)
    pub = rospy.Publisher('handChatter', Float32MultiArray, queue_size =100)
    rate = rospy.Rate(8000) #10hz

    listener3()
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
    rospy.spin()
    

