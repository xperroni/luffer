#!/bin/bash

# If there's already a running container by the given name...
if [ $(docker ps -q -f "name=$DOKKA_IMAGE_NAME") ]
then
    exit 1
fi

# Create a new running container by the given name.
$DOKKA_HOME/dokka-run.sh $* --name $DOKKA_IMAGE_NAME -d \
    --user="$(id -u):$(id -g)" \
    $(for gid in $(id -G); do echo -n "--group-add $gid "; done) \
    --volume="$DOKKA_IMAGE_HOME:$HOME" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    > /dev/null

# Abort session if container not created successfully.
if [ $? == 1 ]
then
    exit 1
fi

# Start screen session.
$DOKKA_HOME/dokka-screen.sh

# After screen session finishes, stop and delete the container.
docker stop $DOKKA_IMAGE_NAME > /dev/null 2>&1
docker rm $DOKKA_IMAGE_NAME > /dev/null 2>&1

