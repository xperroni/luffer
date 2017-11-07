#!/bin/bash

CONTAINER=$(docker ps -l -q)
IMAGE=$1

if [ "$#" -eq 2 ]
then
    CONTAINER=$1
    IMAGE=$2
fi

docker commit $CONTAINER $IMAGE
docker rm $CONTAINER
