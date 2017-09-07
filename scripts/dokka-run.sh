#!/bin/bash

IMAGE=$1
START=$2

if [ "$(pwd)" == "$HOME" ]
then
    echo "Error: DOKKA cannot be run from the current user's home directory." 1>&2
    exit 1
fi

docker run -it \
    -e DOKKA_HOME \
    -e DISPLAY \
    --net=host \
    --privileged \
    --workdir="$(pwd)" \
    --volume="$DOKKA_HOME:$DOKKA_HOME" \
    --volume="$(pwd):$(pwd)" \
    "${@:3}" \
    $IMAGE \
    $START
