FROM ros:foxy-ros-core-focal

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

WORKDIR /app

RUN apt update && apt install -y \
    ros-foxy-rqt \
    ros-foxy-rqt-common-plugins \
    # ros-foxy-ros-tutorials \
    # ros-foxy-geometry-tutorials \
    ros-foxy-rviz2 \
    # ros-foxy-rosbash \
    ros-foxy-rqt-tf-tree

COPY ./entrypoint.sh /
COPY ./alias.sh /

RUN echo "source /alias.sh" >> ~/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]