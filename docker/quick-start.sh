#!/bin/bash

# sudo setenforce 0
xhost +si:localuser:root

if [ "$1" == "clean" ]; then
	docker compose down --remove-orphans
	tmux kill-session -t stackcli
fi

if [ "$1" == "all" ]; then
    docker compose up -d tello-ros

    tmux new-session -d -s stackcli 'fish'

    tmux new-window -n 'tello-ros'
    tmux select-window -t 'tello-ros'
    tmux send-keys 'docker exec -it tello-ros bash'
    tmux send-keys Enter
    tmux send-keys 'source-ros'
    tmux send-keys Enter
    tmux send-keys 'source-work'
    tmux send-keys Enter
    tmux send-keys 'cd ros_ws/src/nlopt/build && sudo make install'
    tmux send-keys Enter
    tmux send-keys 'cd ../../orbslam3/Pangolin/build && sudo make install'
    tmux send-keys Enter
    tmux send-keys 'cd ../..'
    tmux send-keys Enter
    tmux send-keys './build.sh'
    tmux send-keys Enter
    tmux send-keys 'cd /app/ros_ws && rm -rf build/ devel/'
    tmux send-keys Enter
    tmux send-keys 'catkin_make'
    tmux send-keys Enter
    tmux send-keys 'source-work'
    tmux send-keys Enter  

    sleep 30
    
    tmux split-window -v 'fish'
    tmux send-keys 'docker exec -it tello-ros bash'
    tmux send-keys Enter
    tmux send-keys 'source-work'
    tmux send-keys Enter
    tmux send-keys 'roslaunch tello_driver tello_node.launch'
    tmux send-keys Enter 

    tmux select-pane -t 1
    tmux split-window -h 'fish'
    tmux send-keys 'docker exec -it tello-ros bash'
    tmux send-keys Enter
    tmux send-keys 'cd packnet_ws && catkin_make'
    tmux send-keys Enter
    tmux send-keys "source-pack"
    tmux send-keys Enter
    tmux send-keys "rosrun packnet_sfm_ros packnet_sfm_node"
    tmux send-keys Enter

    tmux select-pane -t 2
    tmux split-window -v 'fish'
    tmux send-keys 'docker exec -it tello-ros bash'
    tmux send-keys Enter
    tmux send-keys 'source-work'
    tmux send-keys Enter
    tmux send-keys 'rosrun image_transport republish h264 in:=/tello/image_raw out:=/camera/color/image_raw'
    tmux send-keys Enter

    tmux select-pane -t 0
    tmux send-keys 'docker exec -it tello-ros bash'
    tmux send-keys Enter
    tmux send-keys 'source-work'
    tmux send-keys Enter
    tmux send-keys 'roslaunch ORB_SLAM3 tello_rgbd.launch'
    tmux send-keys Enter

    tmux split-window -h 'fish'
    tmux send-keys 'docker exec -it tello-ros bash'
    tmux send-keys Enter
    tmux send-keys 'source-work'
    tmux send-keys Enter
    tmux send-keys 'roslaunch plan_manage tello_kino_replan.launch'
    tmux send-kets Enter
    
    else
    docker compose up -d tello-ros

    tmux new-session -d -s stackcli 'fish'

    tmux new-window -n 'tello-ros'
    tmux select-window -t 'tello-ros'
    tmux send-keys 'docker exec -it tello-ros bash'
    tmux send-keys Enter
    tmux send-keys 'source-ros'
    tmux send-keys Enter
    tmux send-keys 'source-work'
    tmux send-keys Enter
    tmux send-keys 'cd ros_ws/src/nlopt/build && sudo make install'
    tmux send-keys Enter
    tmux send-keys 'cd ../../orbslam3/Pangolin/build && sudo make install'
    tmux send-keys Enter
    tmux send-keys 'cd ../..'
    tmux send-keys Enter
    tmux send-keys './build.sh'
    tmux send-keys Enter
    tmux send-keys 'cd /app/ros_ws && rm -rf build/ devel/'
    tmux send-keys Enter
    tmux send-keys 'catkin_make'
    tmux send-keys Enter
    tmux send-keys 'source-work'
    tmux send-keys Enter  
fi

tmux attach-session -t stackcli