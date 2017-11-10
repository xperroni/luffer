#!/bin/bash

# Copy luffer scripts to user's directory.
mkdir -p ~/.luffer
(cd scripts ; cp -v *.sh host.* ~/.luffer)

# Copy example ROS configuration to user's directory.
mkdir -p ~/.luffer/osrf/ros/kinetic-desktop-full
(cd scripts/osrf/ros/kinetic-desktop-full ; cp -v *.bashrc ~/.luffer/osrf/ros/kinetic-desktop-full)

# Create symbolic link to base luffer script.
mkdir -p $HOME/bin
ln -s $HOME/.luffer/luffer.sh $HOME/bin/luffer

# If luffer is already in the $PATH, terminate script.
if [ "$(which luffer)" ]
then
    exit
fi

# Otherwise, ask if user wants to add base directory to $PATH.
echo -n "Add directory $HOME/bin to "'$PATH'"? (y/n) "
read yn

# If positive, add base directory to $PATH on the user's .bashrc file.
if [ "$yn" == "y" ]
then
    echo export PATH="$HOME/bin:"'$PATH' >> $HOME/.bashrc
fi
