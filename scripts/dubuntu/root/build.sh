#!/bin/bash

cd "$DOKKA_SETTINGS"

apt-get update && sudo apt-get install -y nano screen wget unzip git
wget -nc https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
bash Anaconda3-4.2.0-Linux-x86_64.sh -b -p /opt/anaconda3

echo 'shell $DOKKA_SHELL' >> /etc/screenrc

source "./environment.sh"
source activate root
pip install --upgrade pip
