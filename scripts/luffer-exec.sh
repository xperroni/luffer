#!/bin/bash

$LUFFER_HOME/luffer-exec-as.sh "$(id -u):$(id -g)" "$@"
