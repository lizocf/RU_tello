FROM ros:noetic-ros-base

SHELL ["/bin/bash", "-c"]

WORKDIR /app

# install dep and such
RUN apt-get update

RUN apt-get install -y \
        libglew-dev \
        cmake 

# install python
RUN apt-get install -y \
        python3.9 \
        python3.9-venv \
        python3-pip --fix-missing

RUN pip3 install opencv-python

RUN apt update && apt upgrade -y

RUN apt install -y \
        libeigen3-dev \
        libpython3.9-dev

# build Pangolin
# RUN cd ORB_SLAM3_NOETIC/Pangolin &&\
#     mkdir build &&\
#     cd build &&\
#     cmake .. &&\
#     make -j

# build Thirdparty libs and ORB-SLAM3
# RUN cd ORB_SLAM3_NOETIC &&\
#     chmod +x build.sh &&\
#     ./build.sh

# clone ros repo
RUN mkdir -p ros_ws/src

RUN cd ros_ws &&\
    source /opt/ros/noetic/setup.bash &&\ 
    rosdep install --from-paths src --ignore-src -r -y  &&\
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release



COPY ./entrypoint.sh /
COPY ./alias.sh /

RUN echo "source /alias.sh" >> ~/.bashrc

RUN echo "export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:ORB-SLAM3/ORB_SLAM3_NOETIC/Examples/ROS" >> ~/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

# Link to Rafalamao's ORB-SLAM3-NOETIC git: https://github.com/RAFALAMAO/ORB_SLAM3_NOETIC.git

# Test Pangolin:

# cd ORB_SLAM3_NOETIC/Pangolin/examples/HelloPangolin
# mkdir build
# cd build
# cmake ..
# make -j
# ./HelloPangolin