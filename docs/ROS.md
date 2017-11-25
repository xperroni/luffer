# Running ROS containers with Luffer

The [Open Source Robotics Foundation (OSRF)](https://www.osrfoundation.org/) provides a number of [ROS Docker images](https://registry.hub.docker.com/_/ros/) for different releases and packages configurations. This tutorial shows how such images can be used with Luffer to quickly setup a ROS development environment.

You must have [Docker](http://docker.com/) and [Luffer](https://github.com/xperroni/luffer) installed on your system before proceeding.

## Downloading ROS Images

To download a full install of the latest ROS release (Kinetic Kame at time of writing), you can do:

    $ docker pull osrf/ros:kinetic-desktop-full

This particular version will be used in all further examples, but you can easily tailor them to your preference.

Next, create a new [tag](https://docs.docker.com/engine/reference/commandline/tag/) to the downloaded image:

    $ docker tag osrf/ros:kinetic-desktop-full ros/kinetic:osrf

This will make it easier to use Luffer's default ROS configuration files on the downloaded image, as will be explained below.

## Running Containers

To instantiate the ROS image and connect it to your current shell session on the host, use the command below:

    $ luffer plug ros/kinetic:osrf
    (ros/kinetic:osrf) $

This will also load the extra settings included in `$LUFFER_HOME/ros/host.bashrc`, which specifies a number of aliases to common ROS commands, for example:

    alias catkin_create_pkg='luffer exec catkin_create_pkg'
    alias catkin_init_workspace='luffer exec catkin_init_workspace'
    alias catkin_make='luffer exec catkin_make'

    alias roscore='luffer exec roscore'
    alias roslaunch='luffer exec roslaunch'
    alias rosmsg='luffer exec rosmsg'
    alias rosnode='luffer exec rosnode'
    alias rosrun='luffer exec rosrun'
    alias rostopic='luffer exec rostopic'

As explained in the [Luffer documentation](https://github.com/xperroni/luffer/blob/master/README.md), this means that calling those commands in the host session will invoke them on the running container, e.g. calling:

    (ros/kinetic:osrf) $ roscore

Will call the `roscore` command on the container. Any command not in the alias list can still be invoked on the container using the `luffer exec` command, for example:

    (ros/kinetic:osrf) $ luffer exec rosdep update

## Customizing Images

Depending on your pruposes, you may want to customize the original ROS image with extra packages, etc. This can be done in Luffer using the `luffer sudo` command to run root-mode commands on the container, for example:

    (ros/kinetic:osrf) $ luffer sudo apt-get update
    (ros/kinetic:osrf) $ luffer sudo apt-get install ros-kinetic-controller-manager \
                                                     ros-kinetic-gazebo-ros-control \
                                                     ros-kinetic-joint-state-controller \
                                                     ros-kinetic-effort-controllers

This will update APT's package list and install the above ROS packages on the container.

Depending on your host configuration, you may also have to install extra video drivers on the image. For example, in my system I have the `nvidia-375` package installed on the host, so in order for 3D graphics to work on the running container I also need the same drivers installed there:

    (ros/kinetic:osrf) $ luffer sudo apt-get install -y --no-install-recommends nvidia-375

Once you're done with customizations, exit the session to terminate the container and commit changes to a new image:

    (ros/kinetic:osrf) $ exit
    $ luffer commit ros/kinetic:custom001

Saving changes to a new image makes it easier to rollback them later if needed, simply by removing the latest image and starting over from the previous version.

## Development Environments

One difficulty using Luffer for ROS development is the need to `source devel/setup.sh` in order to update the `$PATH` and other environment parameters. Configuration file `$LUFFER_HOME/ros/exec.bashrc` gets around this by adding `source devel/setup.sh` to the execution setup when a command is ran from a workspace base folder.

## References

* [Getting started with ROS and Docker](http://wiki.ros.org/docker/Tutorials/Docker)
