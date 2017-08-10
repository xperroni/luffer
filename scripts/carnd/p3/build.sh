#!/bin/bash

source "$DOKKA_SETTINGS/../root/environment.sh"
conda create --name p3 --clone root
source activate p3

conda install -y -c conda-forge tensorflow

pip install --upgrade pip
pip install flask-socketio
pip install eventlet
pip install pillow
pip install h5py
pip install keras
