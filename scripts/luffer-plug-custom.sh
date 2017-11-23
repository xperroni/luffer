#!/bin/bash

# If there's already a running container by the given name...
if [ $(docker ps -q -f "name=$LUFFER_IMAGE_NAME") ]
then
    exit 1
fi

# Remove the occasional stale container.
docker rm $LUFFER_IMAGE_NAME > /dev/null 2>&1

# Create a new running container by the given name.
$LUFFER_HOME/luffer-run.sh $* --name $LUFFER_IMAGE_NAME -d \
    --volume="$LUFFER_IMAGE_HOME:$HOME" \
    > /dev/null

# Abort session if container not created successfully.
if [ $? == 1 ]
then
    exit 1
fi

# Create the current user on the container.
$LUFFER_HOME/luffer-sudo.sh "useradd -u $(id -u) $USER"

# Start screen session.
$LUFFER_HOME/luffer-screen.sh

# Remove the current user from the container.
$LUFFER_HOME/luffer-sudo.sh "userdel $USER"

# After screen session finishes, stop the container.
docker stop $LUFFER_IMAGE_NAME > /dev/null 2>&1

