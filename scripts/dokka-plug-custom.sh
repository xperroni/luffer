#!/bin/bash

$DOKKA_HOME/dokka-run.sh $* --name $DOKKA_PLUGGED -d \
    --user="$(id -u):$(id -g)" \
    $(for gid in $(id -G); do echo -n "--group-add $gid "; done) \
    --volume="$DOKKA_PLUGGED_HOME:$HOME" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    > /dev/null

if [ $? == 1 ]
then
    exit 1
fi

$DOKKA_HOME/dokka-screen.sh

docker stop $DOKKA_PLUGGED > /dev/null 2>&1

docker rm $DOKKA_PLUGGED > /dev/null 2>&1
