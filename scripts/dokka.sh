#!/bin/bash

DOKKA_SCRIPT=$(readlink -f "$0")
export DOKKA_HOME=$(dirname "$DOKKA_SCRIPT")
export DOKKA_SHELL="$DOKKA_HOME/shell.sh"

# $1 == "run"
PROJECT=$2
VERSION=$3
IMAGE="$PROJECT:$VERSION"
START="$DOKKA_HOME/start.sh"
export DOKKA_SETTINGS="$DOKKA_HOME/$PROJECT/$VERSION"

if [ $1 == "build" ]
then
    source "$DOKKA_SETTINGS/build_settings.sh"
    IMAGE="$PROJECT:$PARENT_VERSION"
    START="$DOKKA_HOME/build.sh"
fi

# See: http://stackoverflow.com/a/37160346/476920
HEADERS_1="/usr/src/linux-headers-$(uname -r)"
HEADERS_2="/usr/src/linux-headers-$(uname -r | egrep -o '\w+\.\w+\.\w+\-\w+')"

docker run -it \
    -e DOKKA_HOME \
    -e DOKKA_SHELL \
    -e DOKKA_SETTINGS \
    -e DISPLAY \
    --net=host \
    --privileged \
    --user="$(id -u):$(id -g)" \
    $(for gid in $(id -G); do echo -n "--group-add $gid "; done) \
    --workdir="$HOME" \
    --volume="$HOME:$HOME" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/lib/modules:/lib/modules" \
    --volume="$HEADERS_1:$HEADERS_1" \
    --volume="$HEADERS_2:$HEADERS_2" \
    $IMAGE \
    $START

if [ $1 == "build" ]
then
    echo "Commiting changes to image $PROJECT:$VERSION..."
    docker commit $(docker ps -l -q) $PROJECT:$VERSION
fi
