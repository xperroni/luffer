#!/bin/bash

source "$DOKKA_SETTINGS/../root/environment.sh"
conda create --name p4 --clone p1
conda remove -y --name p1 --all
