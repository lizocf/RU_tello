#!/bin/bash

# sudo setenforce 0
xhost +si:localuser:root

if [ "$1" == "clean" ]; then
	docker compose down --remove-orphans
	tmux kill-session -t stackcli
fi

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

# tmux split-window -h 'fish'
# tmux send-keys 'sudo docker exec -it velodyne bash'
# tmux send-keys Enter
# # tmux send-keys 'roslaunch velodyne_pointcloud VLP16_points.launch'
# # tmux send-keys Enter 

# tmux select-pane -t 0
# tmux split-window -v 'fish'
# tmux send-keys 'sudo docker exec -it rtabmap bash'
# tmux send-keys Enter
# # tmux send-keys "roslaunch rtabmap_launch ekf.launch"
# # tmux send-keys Enter

# tmux select-pane -t 2
# tmux split-window -v 'fish'
# tmux send-keys 'sudo docker exec -it rviz bash'
# tmux send-keys Enter
# # tmux send-keys 'rviz'
# # tmux send-keys Enter 

tmux attach-session -t stackcli