FROM ros:noetic-ros-base

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

##  TELLO-ROS DEPENDENCIES ##
RUN apt update && apt install -y \
    ros-noetic-tello-driver \
    ros-noetic-image-transport-plugins \
    ros-noetic-codec-image-transport

RUN apt-get update && apt-get install -y \
    ros-noetic-catkin \
    ros-noetic-camera-info-manager \
    ros-noetic-joy \
    python3-catkin-tools \
    python3-pip \
    libx264-dev 
    # ros-noetic-camera-info-manager-py <- solved using a very scrappy method

RUN apt update && apt install -y \
    ros-noetic-rqt ros-noetic-rqt-common-plugins ros-noetic-ros-tutorials \
    ros-noetic-geometry-tutorials ros-noetic-rviz ros-noetic-rosbash ros-noetic-rqt-tf-tree \
    ros-noetic-image-transport-plugins ros-noetic-cv-bridge

RUN mkdir -p ros_ws/src

RUN pip install tellopy av pillow

## ORBSLAM3 DEPENDENCIES ##

RUN apt-get install -y \
        libglew-dev \
        cmake 

# install python
RUN apt-get install -y \
        # wget \   
        # unzip \   # for testing example orbslam
        # python3.9 \
        # python3.9-venv \
        libopencv-dev \
        gcc g++ clang 
        # python3-pip --fix-missing

RUN pip install opencv-python

# eigen eigen eigen
RUN apt install -y \    
        libeigen3-dev \
        libpython3.9-dev 

## PACKNET_SFM DEPENDENCIES ##

RUN apt-get install -y \
    # python3-pip \
    python3-yaml \
    python3-dev \
    python3-numpy \
    git

RUN pip3 install yacs matplotlib termcolor tqdm wandb

# long runtime #
RUN pip3 install torchvision

# RUN cd ros_ws/src &&\
#     git clone -b noetic https://github.com/ros-perception/vision_opencv.git

RUN cd ros_ws &&\
    source /opt/ros/noetic/setup.bash &&\ 
    rosdep install --from-paths src --ignore-src -r -y  &&\
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release

# copy alias bash and add to bashrc
COPY ./entrypoint.sh /
COPY ./alias.sh /

RUN echo "source /alias.sh" >> ~/.bashrc
RUN echo "source /entrypoint.sh" >> ~/.bashrc
RUN echo "export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:ORB-SLAM3/ORB_SLAM3_NOETIC/Examples/ROS" >> ~/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

# see https://github.com/anqixu/tello_driver for install info

# if all dependency issues fail, resort to rosdep install --from-paths . -i --rosdistro noetic :)

# check camera in master:  rosrun rqt_image_view rqt_image_view /tello/image_raw/h264

#Unable to load plugin for transport 'compressed', error string:
# According to the loaded plugin descriptions the class image_transport/compressed_sub with base class type image_transport::SubscriberPlugin 
# does not exist. Declared types are  image_transport/raw_sub

# Unable to load plugin for transport 'h264', error string:
# According to the loaded plugin descriptions the class image_transport/h264_sub with base class type image_transport::SubscriberPlugin 
# does not exist. Declared types are  image_transport/compressedDepth_sub image_transport/compressed_sub image_transport/raw_sub image_transport/theora_sub