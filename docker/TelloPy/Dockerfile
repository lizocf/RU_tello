FROM ros:noetic-ros-base

SHELL ["/bin/bash", "-c"]

WORKDIR /app

# clone ros repo
RUN mkdir -p ros_ws/src

# install python3.9
RUN apt-get update && apt-get install -y \
        python3.9 \
        python3.9-venv \
        libopencv-dev \
        mplayer \
        python3-pip --fix-missing

RUN pip3 install av \
        opencv-python \
        image \
        pygame

RUN cd ros_ws &&\
    source /opt/ros/noetic/setup.bash &&\ 
    rosdep install --from-paths src --ignore-src -r -y  &&\
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release

COPY ./entrypoint.sh /
COPY ./alias.sh /

RUN echo "source /alias.sh" >> ~/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]