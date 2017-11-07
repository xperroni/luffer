#!/bin/bash

export EXEC_BASHRC="$DOKKA_IMAGE_DIR/exec.bashrc"

if [ -e "$EXEC_BASHRC" ]
then
    docker exec -ti $DOKKA_IMAGE_NAME bash -c "cd $(pwd) ; source $EXEC_BASHRC ; $*"
else
    docker exec -ti $DOKKA_IMAGE_NAME bash -c "cd $(pwd) ; $*"
fi
