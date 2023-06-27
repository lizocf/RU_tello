FROM ros:noetic-ros-base

SHELL ["/bin/bash", "-c"]

WORKDIR /app

# clone ros repo
RUN mkdir -p ros_ws/src

# install dep and such
RUN apt update && apt install -y \
        git

RUN cd ros_ws/src

RUN git clone https://github.com/anqixu/TelloPy.git

# install python3.9
RUN apt-get install -y \
        python3.9 \
        python3.9-venv \
        libopencv-dev \
        mplayer \
        python3-pip --fix-missing

RUN cd TelloPy && pip3 install -e .

RUN cd .. &&\
        git clone https://github.com/anqixu/h264_image_transport.git &&\
        git clone https://github.com/anqixu/tello_driver.git

# RUN cd .. &&\
#         rosdep install h264_image_transport

RUN cd ros_ws &&\
    source /opt/ros/noetic/setup.bash &&\ 
    rosdep install --from-paths src --ignore-src -r -y  &&\
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release

COPY ./entrypoint.sh /
COPY ./alias.sh /

RUN echo "source /alias.sh" >> ~/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]