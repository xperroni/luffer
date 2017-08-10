#!/bin/bash

IMAGE=$1
START=$2

echo $1
echo $2

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
