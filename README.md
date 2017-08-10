# DOKKA

<img height="300" src="https://xperroni.github.io/dokka/2017_dokka_03.png">

DOKKA is a collection of BASH scripts to package software development stacks as Docker images. Containers are seamlessly integrated to the host environment as they are instantiated, making possible to keep project files and general-purpose applications (such as text editor and version control clients) on the host.

## Dependencies

* [BASH](https://www.gnu.org/software/bash/) >= 4.0
* [Docker](https://www.docker.com/) >= 1.0
* [screen](https://www.gnu.org/software/screen/) >= 4.0

## Install

1. Clone the project repository;
2. Copy the contents of the `scripts` folder to a convenient place on your machine;
3. Create a symlink somewhere in your `PATH` leading to the `dokka.sh` file.

## Usage

DOKKA includes some conveniences for setting up custom Docker images. Use `dokka root` To create a container from a pre-existing image and enter a shell session on it, for example:

    $ dokka root ubuntu:17.04

This will create a container from the `ubuntu:17.04` image (downloading it from Docker's repository if not yet available) and start a shell session on it logged to the root user. Additionally the host's current folder will be mapped to the instance, so files can be easily exchanged between the two. Package installation and other customizations can be performed in the usual manner, for example to install Jupyter Notebook type:

    $ apt-get update
    $ apt-get install python3-pip
    $ pip3 install jupyter

Once you're done with your modifications type `exit` to stop the container, then commit it to a new image with `dokka commit`, for example:

    $ dokka commit python:3

This will create an image with name `python` and version `3`. This can then be plugged to your current environment using the `dokka plug` command:

    $ dokka plug python:3

This will instantiate a container for the given image on the background and run `screen` on the host. All tabs created in this session will be able to send commands to the running container through the `dokka exec` command:

    (python:3) $ dokka exec jupyter notebook

New screen tabs can be created by typing `Ctrl+a c` (i.e. first type `Ctrl+a`, then release the keys and type `c`). Use `Ctrl+a n` (for "next) and `Ctrl+a p` (for "previous") to move along tabs. As with `dokka root` the host's current folder is mapped to the instance, so it can access all files on it and its subfolders (but not any parent folders).

To unplug the image, simply `exit` from all screen tabs.

Preceding commands with `dokka exec` can be tiresome and error-prone. To add aliases to those commands that should always be sent to the plugged instance, create a `host.bashrc` file inside a `<image name>/<image version>` subfolder of DOKKA's base folder (i.e. the folder where DOKKA scripts are located), then include appropriate `alias` entries in that file. For example:

    $ mkdir -p ~/bin/dokka/python/3
    $ echo "alias jupyter='dokka exec jupyter'" > ~/bin/dokka/python/3/host.bashrc

Now the next time the `python:3` image is plugged to the host environment, `jupyter` will automatically resolve to `dokka exec jupyter`:

    $ dokka plug python:3
    (python:3) $ type jupyter
    jupyter is aliased to `dokka exec jupyter'
    (python:3) $ jupyter notebook

The last command will be equivalent to `dokka exec jupyter notebook`.

## Known Bugs

* Interactive commands (e.g. running Python in interactive mode) hang when invoked through `dokka exec`;
* When a `dokka exec` command is interrupted with `Ctrl+c` the running process on the instance is not interrupted.
