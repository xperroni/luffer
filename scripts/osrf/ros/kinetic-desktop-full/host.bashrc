alias catkin_create_pkg='luffer exec catkin_create_pkg'
alias catkin_init_workspace='luffer exec catkin_init_workspace'
alias catkin_make='luffer exec catkin_make'
alias catkin_make_isolated='luffer exec catkin_make_isolated'

alias rosbag='luffer exec rosbag'
alias roscore='luffer exec roscore'
alias rosclean='luffer exec rosclean'
alias roslaunch='luffer exec roslaunch'
alias rosmsg='luffer exec rosmsg'
alias rosnode='luffer exec rosnode'
alias rosrun='luffer exec rosrun'
alias rosservice='luffer exec rosservice'
alias rostopic='luffer exec rostopic'

alias rqt='luffer exec rqt'

# Run rosdep init in root mode, but other commands in user mode.
function rosdep {
    if [ "$1" == "init" ]
    then
        luffer sudo rosdep init
    else
        luffer exec rosdep "$@"
    fi
}
