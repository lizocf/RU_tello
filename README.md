# RU_tello

Infrastructure:

- tello-driver
    - camera_info_manager_py
    - h264_image_transport
    - TelloPy

HOW TO BUILD:
1. docker compose up -d tello-driver
2. docker exec -it tello-driver
3. source-ros && source-work && export-ros
4. cd ros_ws/ && catkin_make
5. source devel/setup.bash

COMMANDS:
roslaunch tello_driver tello_node.launch
rosrun rqt_image_view rqt_image_view /tello/image_raw/h264

ISSUES:
chmod +x all source files before running
change python/python2 instances to python3

- orbslam3
    - Pangolin
    
(ORB-SLAM3: Current Frame:1886): dbind-WARNING **: 15:19:33.918: Couldn't connect to accessibility bus: Failed to connect to socket /run/user/1000/at-spi/bus_1: No such file or directory

COMMANDS:

1. rosrun image_transport republish h264 in:=/tello/image_raw out:=/tello/image_raw/compressed_transport

rosrun ORB_SLAM3 Mono Vocabulary/ORBvoc.txt Examples/Monocular/Tello.yaml /camera/image_raw:=/tello/image_raw/compressed_transport