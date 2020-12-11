#!/usr/bin/env python
import rospy
from std_msgs.msg import Float32, Int32
import numpy as np
import time
from std_msgs.msg import Float32MultiArray

Global=np.float32()
Global2=np.float32()

Global = 0
Global2 = 0

def callbackAccel(data):
    global Global
    Global=data.data[0]

def listener2():
    rospy.Subscriber("setData", Float32MultiArray, callbackAccel)

def talker():
    while not rospy.is_shutdown():
        pub.publish(Global)
        rate.sleep()

if __name__ == '__main__':
    rospy.init_node('listener1', anonymous=True)
    pub = rospy.Publisher('data', Float32, queue_size =100)
    rate = rospy.Rate(1) #10hz
    listener2()  
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
    rospy.spin()
    
