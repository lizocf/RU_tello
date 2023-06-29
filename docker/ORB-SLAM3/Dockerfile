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
        wget \
        unzip \
        python3.9 \
        python3.9-venv \
        libopencv-dev \
        gcc g++ clang \
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
#     sudo make install

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

RUN echo "export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:orbslam3/Examples/ROS" >> ~/.bashrc

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
# MAKE SURE DISPLAY=:0 !!!!!!!!!

# Building orbslam3:

# changed all "make -j" in build.sh to "make -j4"
# "sed -i 's/++11/++14/g' CMakeLists.txt" before running ./build.sh

#https://medium.com/@tristan.sch/setting-up-a-virtual-machine-with-orb-slam-3-1a12e7905cf5 
# ^ how to usb cam + ros + orb3

# Testing with EuRoc dataset:

# cd orbslam3
# mkdir -p Datasets/EuRoc/
# cd Datasets/EuRoc/
# wget -c http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_01_easy/MH_01_easy.zip
# mkdir MH01
# unzip MH_01_easy.zip -d MH01/
# cd ../../orbslam3
# ./Examples/Monocular/mono_euroc \ 
# ./Vocabulary/ORBvoc.txt \ 
# ./Examples/Monocular/EuRoC.yaml \ 
# ./Datasets/EuRoc/MH01 \
# ./Examples/Monocular/EuRoC_TimeStamps/MH01.txt \
# dataset-MH01_mono