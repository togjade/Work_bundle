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

arr = Float32MultiArray() 
arr.data = []
pressureGlobal = np.float32()
accelGlobal=np.float32()
handGlobal = np.float32()
accelGlobal = 0
pressureGlobal = 0
handGlobal = 0

def callbackPressure(pressure_msg):
    global pressureGlobal
    pressureGlobal=pressure_msg.data

def callbackAccel(accel):
    global accelGlobal
    accelGlobal=accel.data

def callbackHand(hand_msg):
    global handGlobal
    handGlobal=hand_msg.data

def listener1():
    rospy.Subscriber("pressure", Float32, callbackPressure)

def listener2():
    rospy.Subscriber("nidaqTogzhan6221", Float32, callbackAccel)

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
            hand.move(1,7000)
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
            hand.move(1,7000)
            hand.move(8,7000)
            hand.move(9,7500)
            hand.wait_for_hand()
        

        arr.data.insert(0, pressureGlobal)
        arr.data.insert(1, accelGlobal)
        pub.publish(arr)
        arr.data[:]=[] #clear array
        rate.sleep()

if __name__ == '__main__':

    rospy.init_node('listener1', anonymous=True)
    pub = rospy.Publisher('handChatter', Float32MultiArray, queue_size =100)
    rate = rospy.Rate(8000) #10hz
    listener1()
    listener2()
    listener3()
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
    rospy.spin()
    
