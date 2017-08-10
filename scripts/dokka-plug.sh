#!/bin/bash

export DOKKA_IMAGE=$1
export DOKKA_PLUGGED=${1//:/_}

PLUG_CUSTOM="$DOKKA_HOME/${1//://}/plug.sh"

if [ -e "$PLUG_CUSTOM" ]
then
    $PLUG_CUSTOM
else
    $DOKKA_HOME/dokka-plug-custom.sh $1 bash "${@:2}"
fi
