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
    --user="$(id -u):$(id -g)" \
    $(for gid in $(id -G); do echo -n "--group-add $gid "; done) \
    --volume="$LUFFER_IMAGE_HOME:$HOME" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    > /dev/null

# Abort session if container not created successfully.
if [ $? == 1 ]
then
    exit 1
fi

# Start screen session.
$LUFFER_HOME/luffer-screen.sh

# After screen session finishes, stop the container.
docker stop $LUFFER_IMAGE_NAME > /dev/null 2>&1

