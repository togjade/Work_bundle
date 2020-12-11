#include "ros/ros.h"
#include "std_msgs/Float32.h"
#include "std_msgs/MultiArrayLayout.h"
#include "std_msgs/MultiArrayDimension.h"
#include "std_msgs/Float32MultiArray.h"


void callback(const std_msgs::Float32MultiArray::ConstPtr& data);

int main(int argc, char **argv)
{
  float v = 0;
  ros::init(argc, argv, "listener");
  ros::NodeHandle n;
  ros::Rate loop_rate(1);
  ros::Subscriber sub = n.subscribe<std_msgs::float32multiarray>("setData", 1000, callback);
  ros::Publisher chatter_pub = n.advertise<std_msgs::Float32>("test", 1000);
  while (ros::ok())
  {
    ros::spinOnce();
    std_msgs::Float32 msg;
    msg.data = vel;
    chatter_pub.publish(msg);
    loop_rate.sleep();
  
  }

  return 0;
}
void callback(const std_msgs::Float32MultiArray::ConstPtr& data)
{
  vel = data->data[0];
}
