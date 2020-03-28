#!/bin/bash

function pathto {
    BASE_PATH="$LUFFER_IMAGE_DIR"
    while [ "$BASE_PATH" != "$LUFFER_HOME" ]
    do
        FILE_PATH="$BASE_PATH/$1"
        if [ -e "$FILE_PATH" ]
        then
            echo $FILE_PATH
            return
        fi
        BASE_PATH=$(dirname "$BASE_PATH")
    done
}
