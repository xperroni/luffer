#!/bin/bash

# See: http://stackoverflow.com/a/37160346/476920
HEADERS_1="/usr/src/linux-headers-$(uname -r)"
HEADERS_2="/usr/src/linux-headers-$(uname -r | egrep -o '\w+\.\w+\.\w+\-\w+')"

$DOKKA_HOME/dokka-plug-custom.sh $DOKKA_IMAGE bash \
    --volume="/lib/modules:/lib/modules" \
    --volume="$HEADERS_1:$HEADERS_1" \
    --volume="$HEADERS_2:$HEADERS_2"
