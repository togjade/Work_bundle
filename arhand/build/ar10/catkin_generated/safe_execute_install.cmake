execute_process(COMMAND "/home/user/ros_s/arhand/build/ar10/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/user/ros_s/arhand/build/ar10/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
