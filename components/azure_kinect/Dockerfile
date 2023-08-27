FROM ros:foxy-ros-base-focal

ARG DEBIAN_FRONTEND=noninteractive

# Change apt source to Kakao mirror
RUN sed -i".bak.original" -re "s/([a-z]{2}.)?archive.ubuntu.com|security.ubuntu.com/mirror.kakao.com/g" /etc/apt/sources.list

# Install prerequisites
RUN apt-get update && apt-get upgrade -y \
   && apt-get install -y -qq --no-install-recommends \
      curl \
      wget \
      git \
      sed \
      libsoundio1 \
      build-essential \
      ros-dev-tools \
      ros-foxy-image-transport \
      ros-foxy-cv-bridge \
      ros-foxy-angles \
      ros-foxy-xacro \
      ros-foxy-joint-state-publisher \
      ros-foxy-robot-state-publisher \
      ros-foxy-rmw-cyclonedds-cpp \
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*

# Cyclone DDS for communication between host and container (FastDDS requires shared memory)
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# Add Microsoft repository of Ubuntu18.04 to 20.04
RUN curl -sSL https://packages.microsoft.com/config/ubuntu/18.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft-prod.list \
   && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Install Azure Kinect SDK
RUN apt-get update && apt-get upgrade -y \
   && ACCEPT_EULA=Y apt-get install -y \
      libgl1 \
      k4a-tools \
      libk4a1.4-dev \
      libk4a1.4 \
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*

# Add k4a rules
RUN wget https://raw.githubusercontent.com/microsoft/Azure-Kinect-Sensor-SDK/develop/scripts/99-k4a.rules \
   && mkdir -p /etc/udev/rules.d \
   && mv 99-k4a.rules /etc/udev/rules.d/

# Build and install Azure Kinect ROS driver
ARG WS=foxy_ws
WORKDIR /root
RUN mkdir -p ${WS}/src \
   && cd ${WS}/src \
   && git clone https://github.com/microsoft/Azure_Kinect_ROS_Driver.git -b foxy-devel
RUN cd /root/${WS} \
   && . /opt/ros/foxy/setup.sh \
   && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-w"
