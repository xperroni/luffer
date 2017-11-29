#!/bin/bash

# Import Luffer utility functions.
source "$LUFFER_HOME/luffer-utils.sh"

# Setup session environment variables.
export LUFFER_IMAGE=$1
export LUFFER_IMAGE_NAME=${1//[:\/]/_}
export LUFFER_IMAGE_DIR="$LUFFER_HOME/${1//://}"
export LUFFER_IMAGE_HOME="$LUFFER_IMAGE_DIR/home"

# Create the home directory for the container.
mkdir -p "$LUFFER_IMAGE_HOME"

# Get the path to the custom plug script, if it exists.
PLUG_CUSTOM=$(pathto "plug.sh")

if [ -e "$PLUG_CUSTOM" ]
then
    $PLUG_CUSTOM $1 bash "${@:2}"
else
    $LUFFER_HOME/luffer-plug-custom.sh $1 bash "${@:2}"
fi
