#!/bin/bash

# Import Luffer utility functions.
source "$LUFFER_HOME/luffer-utils.sh"

# Find the path to the execution configuration file, if it exists.
export EXEC_BASHRC=$(pathto "exec.bashrc")

if [ -e "$EXEC_BASHRC" ]
then
    docker exec -ti $LUFFER_IMAGE_NAME bash -c "cd $(pwd) ; source $EXEC_BASHRC ; $*"
else
    docker exec -ti $LUFFER_IMAGE_NAME bash -c "cd $(pwd) ; $*"
fi
