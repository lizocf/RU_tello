#!/bin/bash

# if any command fails, exit script
# set -e

# source setup environments for ros and catkin workspace
source /opt/ros/foxy/setup.bash

# https://unix.stackexchange.com/questions/466999/what-does-exec-do
exec "$@"