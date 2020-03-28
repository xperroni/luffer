# Workaround for X11 bug
export QT_X11_NO_MITSHM=1

# Setup ROS environment
source /opt/ros/$1/setup.bash

# Setup development environment
if [ -e "devel/setup.bash" ]
then
    source devel/setup.bash
elif [ -e "devel_isolated/setup.bash" ]
then
    source devel_isolated/setup.bash
fi
