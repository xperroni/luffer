### Commit last used container to image

    docker commit -a <author> -m <changes> $(docker ps -l -q) <image>:<version>

Example:

    docker commit -a "Helio Perroni Filho" -m "Install frameworks" $(docker ps -l -q) carnd:p3

### How to remove unused Docker containers and images

1. Delete all containers:

    $ docker ps -q -a | xargs docker rm

2. Delete all untagged images

    $ docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
