FROM ros:humble-ros-base

ARG DEBIAN_FRONTEND=noninteractive

# Change apt source to Kakao mirror
RUN sed -i".bak.original" -re "s/([a-z]{2}.)?archive.ubuntu.com|security.ubuntu.com/mirror.kakao.com/g" /etc/apt/sources.list

# Install the fallowing packages:
#   - RealSense SDK 2.0 (without graphical tools and examples)
#   - ROS2 wrapper for RealSense devices
#   - Cyclone DDS for communication between host and container (FastDDS requires shared memory)
RUN apt-get update && apt-get upgrade -y \
   && apt-get install -y -qq --no-install-recommends \
      ros-humble-librealsense2* \
      ros-humble-realsense2-* \
      ros-humble-rmw-cyclonedds-cpp \
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
