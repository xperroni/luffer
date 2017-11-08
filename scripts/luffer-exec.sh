#!/bin/bash

export EXEC_BASHRC="$LUFFER_IMAGE_DIR/exec.bashrc"

if [ -e "$EXEC_BASHRC" ]
then
    docker exec -ti $LUFFER_IMAGE_NAME bash -c "cd $(pwd) ; source $EXEC_BASHRC ; $*"
else
    docker exec -ti $LUFFER_IMAGE_NAME bash -c "cd $(pwd) ; $*"
fi
