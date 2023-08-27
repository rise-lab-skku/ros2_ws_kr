docker run --rm \
    --name rws-azure-kinect \
    --network host \
    --privileged \
    --ipc host \
    -v /dev:/dev \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v ~/.Xauthority:/root/.Xauthority:ro \
    -e DISPLAY=unix$DISPLAY \
    rws-azure-kinect:latest \
    bash -c "source /root/foxy_ws/install/local_setup.bash && ros2 launch azure_kinect_ros_driver driver.launch.py"
