#!/bin/bash

export DOKKA_IMAGE=$1
export DOKKA_PLUGGED=${1//[:\/]/_}
export DOKKA_PLUGGED_DIR="$DOKKA_HOME/${1//://}"
export DOKKA_PLUGGED_HOME="$DOKKA_PLUGGED_DIR/home"

mkdir -p "$DOKKA_PLUGGED_HOME"

PLUG_CUSTOM="$DOKKA_HOME/${1//://}/plug.sh"

if [ -e "$PLUG_CUSTOM" ]
then
    $PLUG_CUSTOM $1 bash "${@:2}"
else
    $DOKKA_HOME/dokka-plug-custom.sh $1 bash "${@:2}"
fi
