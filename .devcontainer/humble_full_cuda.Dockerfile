#######################################
# The base image is based on CUDA 11.8
# Please refer to the following link for more information.
# https://github.com/athackst/dockerfiles/blob/main/ros2/humble-cuda.Dockerfile
#######################################
FROM althack/ros2:humble-cuda-full

# Change apt source to Kakao mirror
RUN sed -i".bak.original" -re "s/([a-z]{2}.)?archive.ubuntu.com|security.ubuntu.com/mirror.kakao.com/g" /etc/apt/sources.list

# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
ENV QT_X11_NO_MITSHM 1
ENV XDG_RUNTIME_DIR=/tmp

# ** [Optional] Uncomment this section to install additional packages. **
# ** When deploying, comment out the unnecessary packages. (e.g. fonts-firacode) **
#
ENV DEBIAN_FRONTEND=noninteractive
# ******************************************************

RUN apt-get update \
   && apt-get install -y -qq --no-install-recommends \
      # net-tools is required for ifconfig
      net-tools \
      # Expose the nvidia driver to allow opengl
      # Dependencies for glvnd and X11.
      libglvnd0 \
      libgl1 \
      libglx0 \
      libegl1 \
      libxext6 \
      libx11-6 \
      # Additional packages for ROS2
      python3-pydantic \
      ros-humble-joint-state-publisher \
      ros-humble-robot-localization \
      ros-humble-plotjuggler-ros \
      ros-humble-robot-state-publisher \
      ros-humble-ros2bag \
      ros-humble-rosbag2-storage-default-plugins \
      ros-humble-rqt-tf-tree \
      ros-humble-rmw-fastrtps-cpp \
      ros-humble-rmw-cyclonedds-cpp \
      ros-humble-slam-toolbox \
      ros-humble-twist-mux \
      ros-humble-xacro \
      # Additional packages for dev environment
      fonts-firacode \
      tmux \
      tmuxinator \
      xorg-dev \
      zsh \
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*

# Install openrr/urdf-viz
RUN wget https://github.com/openrr/urdf-viz/releases/download/v0.38.2/urdf-viz-x86_64-unknown-linux-gnu.tar.gz && \
   tar -xvzf urdf-viz-x86_64-unknown-linux-gnu.tar.gz -C /usr/local/bin/ && \
   chmod +x /usr/local/bin/urdf-viz && \
   rm -f urdf-viz-x86_64-unknown-linux-gnu.tar.gz

# Install Oh My Zsh
ARG USERNAME=ros
ENV _HOME=/home/${USERNAME}

USER $USERNAME
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
      -t agnoster \
      -p git \
      -p colorize \
      -p history \
      -p https://github.com/zsh-users/zsh-autosuggestions \
      -p https://github.com/zsh-users/zsh-syntax-highlighting \
      -p https://github.com/zsh-users/zsh-completions \
   # Autocompletion for zsh
   && echo "if [ -f /opt/ros/${ROS_DISTRO}/setup.zsh ]; then source /opt/ros/${ROS_DISTRO}/setup.zsh; fi" >> ${_HOME}/.zshrc \
   && echo "if [ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh ]; then source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh; fi" >> ${_HOME}/.zshrc \
   # Clean up
   && sudo apt-get autoremove -y \
   && sudo apt-get clean -y \
   && sudo rm -rf /var/lib/apt/lists/*
USER root

# # ** [Optional] Uncomment this section to install Tmuxinator. **
# # ** Please refer to the following link for how to use Tmuxinator. **
# # https://github.com/sskorol/ros2-humble-docker-dev-template
# RUN apt-get update \
#    && apt-get install -y -qq --no-install-recommends \
#       tmux \
#       tmuxinator \
#    && wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator \
#    # Clean up
#    && apt-get autoremove -y \
#    && apt-get clean -y \
#    && rm -rf /var/lib/apt/lists/*

# ******************************************************
ENV DEBIAN_FRONTEND=dialog

# Set up auto-source of workspace for ros user
ARG WORKSPACE
# Bash
RUN echo "if [ -f ${WORKSPACE}/install/local_setup.bash ]; then source ${WORKSPACE}/install/local_setup.bash; fi" >> ${_HOME}/.bashrc \
   && echo 'export PS1="\[\]\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ \[\]"' >> ${_HOME}/.bashrc \
   && echo 'alias ssetup="source ${WORKSPACE}/install/local_setup.bash"' >> ${_HOME}/.bashrc \
   && echo 'alias cyclone="export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp"' >> ${_HOME}/.bashrc \
   && echo 'alias fastdds="export RMW_IMPLEMENTATION=rmw_fastrtps_cpp"' >> ${_HOME}/.bashrc \
   && echo 'export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp' >> ${_HOME}/.bashrc \
   && echo 'eval "$(register-python-argcomplete3 ros2)"' >> ${_HOME}/.bashrc \
   && echo 'eval "$(register-python-argcomplete3 colcon)"' >> ${_HOME}/.bashrc
# Zsh
RUN echo "if [ -f ${WORKSPACE}/install/local_setup.zsh ]; then source ${WORKSPACE}/install/local_setup.zsh; fi" >> ${_HOME}/.zshrc \
   && echo 'alias ssetup="source ${WORKSPACE}/install/local_setup.zsh"' >> ${_HOME}/.zshrc \
   && echo 'alias cyclone="export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp"' >> ${_HOME}/.zshrc \
   && echo 'alias fastdds="export RMW_IMPLEMENTATION=rmw_fastrtps_cpp"' >> ${_HOME}/.zshrc \
   && echo 'export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp' >> ${_HOME}/.zshrc \
   && echo "autoload -U bashcompinit" >> ${_HOME}/.zshrc \
   && echo "bashcompinit" >> ${_HOME}/.zshrc \
   && echo 'eval "$(register-python-argcomplete3 ros2)"' >> ${_HOME}/.zshrc \
   && echo 'eval "$(register-python-argcomplete3 colcon)"' >> ${_HOME}/.zshrc

CMD ["/bin/zsh"]
