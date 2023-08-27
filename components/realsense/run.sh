docker run --rm \
    --name rws-realsense \
    --network host \
    --privileged \
    --ipc host \
    -v /dev:/dev \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    rws-realsense:latest \
    bash -c "ros2 launch realsense2_camera rs_launch.py"
