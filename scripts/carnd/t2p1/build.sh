#!/bin/bash

sudo apt-get install -y libgtk2.0-dev

source "$DOKKA_SETTINGS/../root/environment.sh"
conda create --name t2p1 --clone root

sudo apt-get install -y g++ libeigen3-dev cmake
