#!/bin/bash

# Import Luffer utility functions.
source "$LUFFER_HOME/luffer-utils.sh"

# Find the path to the execution configuration file, if it exists.
export EXEC_BASHRC=$(pathto "exec.bashrc")

# Build the command setup expression, adding path to
# the execution configuration file as appropriate.
SETUP="cd $(pwd)"
if [ -e "$EXEC_BASHRC" ]
then
    SETUP="$SETUP ; source $EXEC_BASHRC"
fi

# Run the given command in the container under the given user.
docker exec --user="$1" -ti $LUFFER_IMAGE_NAME bash -c "$SETUP ; ${*:2}"
