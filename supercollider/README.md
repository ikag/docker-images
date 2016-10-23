# supercollider

## Build

    docker build -t ikag/supercollider:latest

## Run

    docker run --privileged --ulimit rtprio=95 --ulimit memlock=-1 -ti --rm ikag/supercollider
