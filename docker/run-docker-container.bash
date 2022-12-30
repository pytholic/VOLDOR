#!/bin/bash

# start sharing xhost
xhost +local:root

# run docker
docker run \
  --name voldor2 \
  --ipc=host \
  --gpus all \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $HOME/.Xauthority:$docker/.Xauthority \
  -e DISPLAY=$DISPLAY \
  -e XAUTHORITY=$home_folder/.Xauthority \
  -e QT_X11_NO_MITSHM=1 \
  -it pytholic/voldor
