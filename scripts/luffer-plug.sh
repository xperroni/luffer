#!/bin/bash

export LUFFER_IMAGE=$1
export LUFFER_IMAGE_NAME=${1//[:\/]/_}
export LUFFER_IMAGE_DIR="$LUFFER_HOME/${1//://}"
export LUFFER_IMAGE_HOME="$LUFFER_IMAGE_DIR/home"

mkdir -p "$LUFFER_IMAGE_HOME"

PLUG_CUSTOM="$LUFFER_HOME/${1//://}/plug.sh"

if [ -e "$PLUG_CUSTOM" ]
then
    $PLUG_CUSTOM $1 bash "${@:2}"
else
    $LUFFER_HOME/luffer-plug-custom.sh $1 bash "${@:2}"
fi
