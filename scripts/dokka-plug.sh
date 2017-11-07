#!/bin/bash

export DOKKA_IMAGE=$1
export DOKKA_IMAGE_NAME=${1//[:\/]/_}
export DOKKA_IMAGE_DIR="$DOKKA_HOME/${1//://}"
export DOKKA_IMAGE_HOME="$DOKKA_IMAGE_DIR/home"

mkdir -p "$DOKKA_IMAGE_HOME"

PLUG_CUSTOM="$DOKKA_HOME/${1//://}/plug.sh"

if [ -e "$PLUG_CUSTOM" ]
then
    $PLUG_CUSTOM $1 bash "${@:2}"
else
    $DOKKA_HOME/dokka-plug-custom.sh $1 bash "${@:2}"
fi
