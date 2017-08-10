#!/bin/bash

apt-get update && apt-get install -y nano screen wget

# Setup screen
echo 'shell $DOKKA_SHELL' >> /etc/screenrc
