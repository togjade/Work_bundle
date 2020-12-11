#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist, Vector3
from xela_sensors.srv import XelaSensorZ
import time

class xyz():
    def __init__(self,x,y,z):
        self.x = x
        self.y = y
        self.z = z


rospy.init_node('xSim', anonymous=True)
pub = rospy.Publisher('cmd_vel', Twist, queue_size=10)
baseline = []
for i in  range(0,17):
    baseline.append(40000)
rospy.wait_for_service("xServZ")
ser = rospy.ServiceProxy("xServZ",XelaSensorZ)

def serv(x,y):
    val = int(ser(x,y).value)
    if baseline[y] > val and val > 100:
        baseline[y] = val
    out = mapper(val,baseline[y],40000,0.0,0.3,1000)
    #rospy.loginfo("{}/{} IN: {} OUT: {}".format(y,baseline[y],val,out))
    return out

def mapper(val,inmin,inmax,outmin,outmax,treshold):
    if val<inmin+treshold:
        return outmin
    if val>inmax:
        return outmax
    inner = val-inmin-treshold
    if inner<0:
        inner=0
    inrange = inmax-inmin
    if inrange < 1:
        return 0.0
    outrange = outmax-outmin
    inscale = float(inner) / float(inrange)
    return float(outmax + outrange*inscale)

while not rospy.is_shutdown():
    up1 = serv(1,2)
    up2 = serv(1,3)
    left1 = serv(1,5)
    left2 = serv(1,9)
    right1 = serv(1,8)
    right2 = serv(1,12)
    down1 = serv(1,14)
    down2 = serv(1,15)
    updown = float(up1+up2-down1-down2)
    if updown > 1:
        rospy.loginfo("Going forward")
    if updown < -1:
        rospy.loginfo("Going backwards")

    leftright = float((right1+right2-left1-left2))
    if leftright < -1:
        rospy.loginfo("Turning right")
    if leftright > 1:
        rospy.loginfo("Turning left")

    pub.publish(xyz(updown,0.0,0.0),xyz(0.0,0.0,leftright))
    time.sleep(0.1)