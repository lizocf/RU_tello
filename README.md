# RU_tello

Infrastructure:
Containers cannot connect to one ROS network, most likely due to the network_mode being set to "host" in order to connect to the Tello. Everything is running under one container (tello_ros).
build container by running: ./quick-start.sh clean

# MISC ISSUES
- if xbox controller not connecting via bluetooth, go to windows machine and connect there first. Then go to ubuntu machine and it should show up.

# tello-driver
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

# orbslam3
    - Pangolin

 build Pangolin
 RUN cd ORB_SLAM3_NOETIC/Pangolin &&\
     mkdir build &&\
     cd build &&\
     cmake .. &&\
     sudo make install

 build Thirdparty libs and ORB-SLAM3
 RUN cd ORB_SLAM3_NOETIC &&\
     chmod +x build.sh &&\
     ./build.sh

(ORB-SLAM3: Current Frame:1886): dbind-WARNING **: 15:19:33.918: Couldn't connect to accessibility bus: Failed to connect to socket /run/user/1000/at-spi/bus_1: No such file or directory


COMMANDS:

1. rosrun image_transport republish h264 in:=/tello/image_raw out:=/camera/color/image_raw 

2. rosrun ORB_SLAM3 Mono Vocabulary/ORBvoc.txt Examples/Monocular/mono_tello.yaml /camera/image_raw:=/camera/color/image_raw  (MONO)

3. rosrun ORB_SLAM3 RGBD Vocabulary/ORBvoc.txt Examples/RGB-D/rgbd_tello.yaml /camera/rgb/image_raw:=/packnet/color/image_raw /camera/depth_registered/image_raw:=/packnet/depth/image_raw (RGB-D)

# PackNet-SfM
    - CV-Bridge

ISSUES:
```
COMMAND: rosrun packnet_sfm_ros packnet_sfm_node
ERROR: AttributeError: module 'horovod.torch' has no attribute 'init'
Solution: Build horovod from source (https://github.com/horovod/horovod/issues/155)
$ git clone https://github.com/uber/horovod
$ cd horovod
$ python3 setup.py sdist
$ [flags] pip3 install dist/horovod*.tar.gz


COMMAND: rosrun ...
ERROR: rosrun not found (???)
Solution: sudo apt install --reinstall ros-noetic-rosbash

ERROR: /usr/lib/python3/dist-packages/requests/__init__.py:89: RequestsDependencyWarning: urllib3 (2.0.3) or chardet (3.0.4) doesn't match a supported version! warnings.warn("urllib3 ({}) or chardet ({}) doesn't match a supported "
Solution: pip install -U urllib3

ERROR: catkin build error
Solution: catkin build -DSETUPTOOLS_DEB_LAYOUT=OFF

```

packnet_sfm_node info:
Node [/packnet_sfm_node]                                          │
Publications:                                                     │
 * /packnet/color/image_raw [sensor_msgs/Image]                   │
 * /packnet/depth/image_raw [sensor_msgs/Image]                   │
 * /rosout [rosgraph_msgs/Log]                                    │
                                                                  │
Subscriptions:                                                    │
 * /camera/color/image_raw [unknown type]                         │
                                                                  │
Services:                                                         │
 * /packnet_sfm_node/get_loggers                                  │
 * /packnet_sfm_node/set_logger_level   


 # Fast-Planner

 ISSUES:
 - cmake error: run catkin_make -DCMAKE_CXX_STANDARD=14 OR add this to every cmake file:
 ```
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
```

git clone https://github.com/stevengj/nlopt.git
cd nlopt
mkdir build
cd build
cmake ..
make
sudo make install




## HOW TO RUN FR FR


```
## SETUP ## <> = new terminal
docker exec -it tello-ros bash
source-ros
cd ros_ws/src/nlopt/build && sudo make install
cd ../../orbslam3/Pangolin/build && sudo make install
cd ../orbslam3 && ./build.sh
cd ../.. && rm -rf build/ devel/ && catkin_make
source-work


## TELLO_DRIVER ##
roslaunch tello_driver tello_node.launch (devel.launch for joystick commands) 
rosrun image_transport republish h264 in:=/tello/image_raw out:=/camera/color/image_raw  <>

## PACKNET FOR RGBD ##
source-pack <>
catkin build / catkin_make?
rosrun packnet_sfm_ros packnet_sfm_node


## ORBSLAM3 RGBD ##
rosrun ORB_SLAM3 RGBD Vocabulary/ORBvoc.txt Examples/RGB-D/rgbd_tello.yaml /camera/rgb/image_raw:=/packnet/color/image_raw /camera/registered_depth/image_raw:=/packnet/depth/image_raw <>
```

## TO-DO LIST ##
- CLEAN UP ORBSLAM FOR THE LOVE OF GOD (publish /odom and /pose topics, move ros package to front)
- fast-planner integration !!!
- docker comtainer clean up  !!!!!!!!!!! (tonight
- tmux simple set up!)