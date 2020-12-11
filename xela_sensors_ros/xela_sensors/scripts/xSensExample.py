#!/usr/bin/env python
 
import rospy
 
from xela_sensors.srv import XelaSensorStream
 
import sys
 
rospy.init_node('ExampleServiceUser')
 
#wait the service to be advertised, otherwise the service use will fail
rospy.wait_for_service('xServStream')
 
#setup a local proxy for the service (we will chack the full stream of data)
srv=rospy.ServiceProxy('xServStream',XelaSensorStream)
 
#use the service and send it a value. In this case, I am sending sensor: 1
service_example=srv(1)
 
#print the result from the service
#Let's print out the x coordinate for taxel 3 on requested sensor 1
print("Item 1: {}".format(service_example.xyz[3].x))