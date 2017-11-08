#!/bin/bash

LUFFER_SCRIPT=$(readlink -f "$0")
export LUFFER_HOME=$(dirname "$LUFFER_SCRIPT")

$LUFFER_HOME/luffer-$1.sh "${@:2}"
