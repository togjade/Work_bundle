#!/usr/bin/env python
import rospy
from std_msgs.msg import Float32
import numpy as np
import time
from std_msgs.msg import Float32MultiArray

arr = Float32MultiArray() 
arr.data = []

pressureGlobal = np.float32()
forceGlobal=np.float32()
pressureGlobal = 0
forceGlobal = 0

def callbackPressure(pressure_msg):
    global pressureGlobal
    pressureGlobal=pressure_msg.data

def callbackForce(force):
    global forceGlobal
    forceGlobal=force.data

def listener1():
    rospy.Subscriber("pressure", Float32, callbackPressure)

def listener2():
	rospy.Subscriber("force", Float32, callbackForce)

def talker():
    
    while not rospy.is_shutdown():
        arr.data.insert(0, pressureGlobal)
        arr.data.insert(1, forceGlobal)
        pub.publish(arr)
        arr.data[:]=[] #clear array
        rate.sleep()

if __name__ == '__main__':
    rospy.init_node('listener', anonymous=True)
    pub = rospy.Publisher('publisherFP', Float32MultiArray, queue_size =100)
    rate = rospy.Rate(150) #10hz
    listener1()
    listener2()  
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
    rospy.spin()
    
