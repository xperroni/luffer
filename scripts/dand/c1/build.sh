#!/bin/bash

sudo apt-get install -y libgtk2.0-dev

source "$DOKKA_SETTINGS/../root/environment.sh"
conda create --name p1 --clone root
source activate p1

conda install -y -c https://conda.anaconda.org/menpo opencv3
conda install -y pango
pip install moviepy

python -c "import imageio ; imageio.plugins.ffmpeg.download()"
