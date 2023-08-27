# Intel RealSense 컨테이너

## 도커 이미지 빌드

[RealSense ROS2 패키지](https://github.com/IntelRealSense/realsense-ros)가 설치된 도커 이미지를 빌드합니다.

```bash
cd components/realsense
sudo ./build.sh
```

## 컨테이너 실행

```bash
cd components/realsense
sudo ./run.sh
```

종종 다음과 같은 오류가 발생하지만, `./run.sh`를 다시 실행하면 정상적으로 실행됩니다.

```bash
[node-1] [WARN] [1693129030.159377940] [k4a_ros_device_node]: Initializing the device to realtime offset based on wall clock: 1693129029959326594 ns
[ERROR] [node-1]: process has died [pid 38, exit code -11, cmd '/root/foxy_ws/install/azure_kinect_ros_driver/lib/azure_kinect_ros_driver/node --ros-args --params-file /tmp/launch_params_59v7u70b --params-file /tmp/launch_params_n_wouon_ --params-file /tmp/launch_params_iorofqmm --params-file /tmp/launch_params_c_njzea2 --params-file /tmp/launch_params_ty4oacti --params-file /tmp/launch_params_f5ngg8a3 --params-file /tmp/launch_params__awq4tov --params-file /tmp/launch_params_j5s52j5v --params-file /tmp/launch_params_n6tsy9l5 --params-file /tmp/launch_params__jade2zg --params-file /tmp/launch_params_8u1e2cch --params-file /tmp/launch_params_94qo6lr5 --params-file /tmp/launch_params_v49q5hgb --params-file /tmp/launch_params_c2fm63in --params-file /tmp/launch_params_uahd4kl4 --params-file /tmp/launch_params_rw53kb8h --params-file /tmp/launch_params_mfyrig64 --params-file /tmp/launch_params_6wul44c4 --params-file /tmp/launch_params_dbb5u8nz --params-file /tmp/launch_params__yrc7f3t'].
```

정상적으로 실행되면 다음과 같은 메시지가 출력됩니다.

```bash
[node-1] [WARN] [1693129079.970896809] [k4a_ros_device_node]: Initializing the device to realtime offset based on wall clock: 1693129079770692906 ns
[node-1] [WARN] [1693129081.125536158] [k4a_ros_device_node]: Initializing or re-initializing the device to realtime offset: 1693129079816108324 ns
```
