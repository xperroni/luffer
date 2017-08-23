#!/bin/bash

export EXEC_BASHRC="$DOKKA_PLUGGED_DIR/exec.bashrc"

if [ -e "$EXEC_BASHRC" ]
then
    docker exec -ti $DOKKA_PLUGGED bash -c "cd $(pwd) ; source $EXEC_BASHRC ; $*"
else
    docker exec -ti $DOKKA_PLUGGED bash -c "cd $(pwd) ; $*"
fi
