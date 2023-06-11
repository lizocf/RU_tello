# To build:
# docker build --pull --no-cache --tag tello_ros:foxy .

# To run:
# docker run -it tello_ros:foxy bash

# I'm using this for smoke tests
# To run tello_ros in a docker container you will need to set up ports, x-windows, etc.

FROM osrf/ros:foxy-desktop

RUN mkdir -p ros_ws/src

WORKDIR /ros_ws/src

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y libasio-dev curl
RUN apt-get install -y python3-pip
RUN yes | pip3 install 'transformations==2018.9.5'

# RUN curl -sSL http://get.gazebosim.org | sh

RUN apt update && apt install -y \
    ros-foxy-cv-bridge \
    ros-foxy-camera-calibration-parsers \
    ros-foxy-gazebo-ros-pkgs

RUN apt install -y \
    gazebo11 \
    libgazebo11 \
    libgazebo11-dev

# WORKDIR /work/tello_ros_ws/src


# RUN mkdir -p ros_ws/src

RUN git clone https://github.com/clydemcqueen/tello_ros.git
RUN git clone https://github.com/ptrmu/ros2_shared.git
RUN git clone https://github.com/ptrmu/fiducial_vlam.git

RUN cd .. &&\
    rosdep install -y --from-paths . --ignore-src

COPY ./alias.sh /

RUN echo "source /alias.sh" >> ~/.bashrc

RUN /bin/bash -c "source /opt/ros/foxy/setup.bash && colcon build"
# colcon build --event-handlers console_direct+ --packages-skip tello_gazebo"
