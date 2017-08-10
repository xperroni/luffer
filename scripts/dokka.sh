#!/bin/bash

DOKKA_SCRIPT=$(readlink -f "$0")
export DOKKA_HOME=$(dirname "$DOKKA_SCRIPT")

$DOKKA_HOME/dokka-$1.sh "${@:2}"
