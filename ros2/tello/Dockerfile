FROM ros:foxy-ros-base

SHELL ["/bin/bash", "-c"]

WORKDIR /app

# install dep and such
RUN apt update && apt install -y \
    build-essential gdb \
    locales \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep2 \
    python3-tf* \
    ros-foxy-ament-cmake* \
    ros-foxy-tf2* \
    ros-foxy-rclcpp* \
    ros-foxy-rosgraph* \
    ros-foxy-rviz* \
    ros-foxy-rqt

# RUN local-gen en_US en_US.UTF-8 &&\
#     update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 &&\
#     export LANG=en_US.UTF-8

RUN pip3 install -U argcomplete

RUN pip3 install \
    catkin_pkg \
    rospkg \
    av \
    image \
    opencv-python \
    djitellopy2 \
    pyyaml 


RUN rosdep update &&\
    rosdep fix-permissions



RUN mkdir -p ros_ws/src

RUN cd ros_ws &&\
    source /opt/ros/foxy/setup.bash &&\ 
    rosdep install --from-paths src --ignore-src -r -y  &&\
    colcon build

# copy alias bash and add to bashrc
COPY ./entrypoint.sh /
COPY ./alias.sh /

RUN echo "source /alias.sh" >> ~/.bashrc
RUN echo "source /entrypoint.sh" >> ~/.bashrc
RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
RUN echo "export _colcon_cd_root=~/ros2_install" >> ~/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

# see https://github.com/anqixu/tello_driver for install info

# if all dependency issues fail, resort to rosdep install --from-paths . -i --rosdistro noetic :)

# check camera in master:  rosrun rqt_image_view rqt_image_view /tello/image_raw/compressed