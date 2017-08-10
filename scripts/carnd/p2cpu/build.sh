#!/bin/bash

source "$DOKKA_SETTINGS/../root/environment.sh"
conda create --name p2cpu --clone root
source activate p2cpu

conda install -y -c conda-forge tensorflow
