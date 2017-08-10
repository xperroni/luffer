#!/bin/bash

docker run -it \
    -e DISPLAY \
    --net=host \
    --privileged \
    --user=$(id -u) \
    --workdir="/home/$USER" \
    --volume="/home/$USER:/home/$USER" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/lib/modules:/lib/modules" \
    ubuntu:14.04 \
    /bin/bash
