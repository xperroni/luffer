#!/bin/bash

$DOKKA_HOME/dokka-run.sh $1 bash "${@:2}" --user=root
