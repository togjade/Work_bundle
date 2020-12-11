#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/user/ros_s/arhand/src/AR10/ar10"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/user/ros_s/arhand/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/user/ros_s/arhand/install/lib/python2.7/dist-packages:/home/user/ros_s/arhand/build/ar10/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/user/ros_s/arhand/build/ar10" \
    "/usr/bin/python" \
    "/home/user/ros_s/arhand/src/AR10/ar10/setup.py" \
    build --build-base "/home/user/ros_s/arhand/build/ar10" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/user/ros_s/arhand/install" --install-scripts="/home/user/ros_s/arhand/install/bin"
