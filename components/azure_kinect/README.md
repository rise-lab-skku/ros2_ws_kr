# Azure Kinect 컨테이너

## 도커 이미지 빌드

[Azure Kinect ROS Driver](https://github.com/microsoft/Azure_Kinect_ROS_Driver)가 설치된 도커 이미지를 빌드합니다.

```bash
cd components/azure_kinect
sudo ./build.sh
```

## 호스트 PC 설정

호스트 PC의 터미널을 열어 아래와 같이 설정해둬야 합니다. 이 설정은 한번만 해두면 되지만, 재부팅 후에는 유지되지 않으니 다시 설정해야 합니다.

```bash
xhost +local:docker
```

위 설정을 하지 않으면, 다음과 같이 `k4a::error` 오류가 발생합니다. ([참고](https://github.com/microsoft/Azure-Kinect-Sensor-SDK/issues/810#issuecomment-968537114))

```bash
( 생략 )/dewrapper.c (154): depth_engine_start_helper(). Depth engine create and initialize failed with error code: 204.
( 생략 )/dewrapper.c (160): deresult == K4A_DEPTH_ENGINE_RESULT_SUCCEEDED returned failure in depth_engine_start_helper()
( 생략 )/dewrapper.c (194): depth_engine_start_helper(dewrapper, dewrapper->fps, dewrapper->depth_mode, &depth_engine_max_compute_time_ms, &depth_engine_output_buffer_size) returned failure in depth_engine_thread()
```

## 컨테이너 실행

```bash
cd components/azure_kinect
sudo ./run.sh
```

종종 다음과 같은 오류가 발생하지만, 터미널을 재시작한 후 `./run.sh`를 다시 실행하면 정상적으로 실행됩니다.

```bash
[node-1] [WARN] [1693129030.159377940] [k4a_ros_device_node]: Initializing the device to realtime offset based on wall clock: 1693129029959326594 ns
[ERROR] [node-1]: process has died [pid 38, exit code -11, cmd '/root/foxy_ws/install/azure_kinect_ros_driver/lib/azure_kinect_ros_driver/node --ros-args --params-file /tmp/launch_params_59v7u70b --params-file /tmp/launch_params_n_wouon_ --params-file /tmp/launch_params_iorofqmm --params-file /tmp/launch_params_c_njzea2 --params-file /tmp/launch_params_ty4oacti --params-file /tmp/launch_params_f5ngg8a3 --params-file /tmp/launch_params__awq4tov --params-file /tmp/launch_params_j5s52j5v --params-file /tmp/launch_params_n6tsy9l5 --params-file /tmp/launch_params__jade2zg --params-file /tmp/launch_params_8u1e2cch --params-file /tmp/launch_params_94qo6lr5 --params-file /tmp/launch_params_v49q5hgb --params-file /tmp/launch_params_c2fm63in --params-file /tmp/launch_params_uahd4kl4 --params-file /tmp/launch_params_rw53kb8h --params-file /tmp/launch_params_mfyrig64 --params-file /tmp/launch_params_6wul44c4 --params-file /tmp/launch_params_dbb5u8nz --params-file /tmp/launch_params__yrc7f3t'].
```

정상적으로 실행되면 다음과 같은 메시지가 출력됩니다.

```bash
[node-1] [WARN] [1693129079.970896809] [k4a_ros_device_node]: Initializing the device to realtime offset based on wall clock: 1693129079770692906 ns
[node-1] [WARN] [1693129081.125536158] [k4a_ros_device_node]: Initializing or re-initializing the device to realtime offset: 1693129079816108324 ns
```
