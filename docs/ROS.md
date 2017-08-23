# Running ROS containers with DOKKA

The [Open Source Robotics Foundation (OSRF)](https://www.osrfoundation.org/) provides a number of [ROS Docker images](https://registry.hub.docker.com/_/ros/) for different releases and packages configurations. This tutorial shows how such images can be used with DOKKA to quickly setup a ROS development environment.

You must have [Docker](http://docker.com/) and [DOKKA](https://github.com/xperroni/dokka) installed on your system before proceeding.

## Downloading ROS Images

To download a full install of the latest ROS release (Kinetic Kame at time of writing), you can do:

    $ docker pull osrf/ros:kinetic-desktop-full

This particular version will be used in all further examples, but you can easily tailor them to your preference.

## Customizing Images

Dependingon your pruposes, you may want to customize the original ROS image with extra packages, etc. In DOKKA this is done first by instantiating a container in root mode:

    $ dokka root osrf/ros:kinetic-desktop-full

This will open a root shell session on the running container. From there you can use standard Linux commands to make changes as you see fit, e.g. to install additional packages:

    # apt-get install ros-kinetic-controller-manager \
                      ros-kinetic-gazebo-ros-control \
                      ros-kinetic-joint-state-controller \
                      ros-kinetic-effort-controllers

Depending on your host configuration, you may also have to install extra video drivers on the image. For example, in my system I have the `nvidia-375` package installed on the host, so in order for 3D graphics to work on the running container I also need the same drivers installed there:

    # apt-get install --no-install-recommends nvidia-375

Once you're done with customizations, exit the session to terminate the container and commit changes to the originating image:

    # exit
    $ dokka commit osrf/ros:kinetic-desktop-full

## Running Containers

To instantiate the ROS image and connect it to your current shell session on the host, use the command below:

    $ dokka plug osrf/ros:kinetic-desktop-full
    (osrf/ros:kinetic-desktop-full) $

This will also load the extra settings included in `$DOKKA_HOME/osrf/ros/kinetic-desktop-full/host.bashrc`, which include a number of aliases to common ROS commands:

    alias catkin_create_pkg='dokka exec catkin_create_pkg'
    alias catkin_init_workspace='dokka exec catkin_init_workspace'
    alias catkin_make='dokka exec catkin_make'

    alias roscore='dokka exec roscore'
    alias roslaunch='dokka exec roslaunch'
    alias rosmsg='dokka exec rosmsg'
    alias rosnode='dokka exec rosnode'
    alias rosrun='dokka exec rosrun'
    alias rostopic='dokka exec rostopic'

As explained in the [DOKKA documentation](https://github.com/xperroni/dokka/blob/master/README.md), this means that calling those commands in the host session will invoke them on the running container, e.g. calling:

    (osrf/ros:kinetic-desktop-full) $ roscore

Will call the `roscore` command on the container. Any command not in the list above can still be invoked on the container using the `dokka exec` command, for example:

    (osrf/ros:kinetic-desktop-full) $ dokka exec rosdep update

## Development Environments

One difficulty using DOKKA for ROS development is the need to `source devel/setup.sh` in order to update the `$PATH` and other environment parameters. Configuration file `$DOKKA_HOME/osrf/ros/kinetic-desktop-full/exec.bashrc` gets around this by adding `source devel/setup.sh` to the execution setup when a command is ran from a workspace base folder.

## References

* [Getting started with ROS and Docker](http://wiki.ros.org/docker/Tutorials/Docker)
