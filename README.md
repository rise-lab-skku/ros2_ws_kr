# VSCode ROS2 Workspace Template for KR

This template provides a fully prepared ROS2 workspace using a VSCode Dev Container, and it employs the Kakao mirror as an Ubuntu APT mirror.
Furthermore, it builds upon two other repositories.
If you find this template useful, please consider showing your support by giving a star to the repositories mentioned below.

- 👑 [athackst/vscode_ros2_workspace](https://github.com/athackst/vscode_ros2_workspace)
- 👑 [sskorol/ros2-humble-docker-dev-template](https://github.com/sskorol/ros2-humble-docker-dev-template)

---

**목차**

1. [📦 사전 준비](#-사전-준비)
2. [✏️ 사용법](#️-사용법)
3. [📌 정보](#-정보)
   1. [1️⃣ 유용한 기능들은 무엇이 있나요?](#1️⃣-유용한-기능들은-무엇이-있나요)
   2. [2️⃣ Dev Container는 일반적인 컨테이너에 비해 어떤 장점이 있나요?](#2️⃣-dev-container는-일반적인-컨테이너에-비해-어떤-장점이-있나요)
   3. [3️⃣ 배포용 도커 이미지는 어떻게 만들 수 있나요?](#3️⃣-배포용-도커-이미지는-어떻게-만들-수-있나요)
   4. [4️⃣ 원격으로 VSCode를 사용할 때 유용한 팁이 있나요?](#4️⃣-원격으로-vscode를-사용할-때-유용한-팁이-있나요)
   5. [5️⃣ 설정된 settings.json 중에서 알아두면 좋은 것들은 무엇이 있나요?](#5️⃣-설정된-settingsjson-중에서-알아두면-좋은-것들은-무엇이-있나요)
   6. [6️⃣ 설정된 devcontainer.json 중에서 알아두면 좋은 것들은 무엇이 있나요?](#6️⃣-설정된-devcontainerjson-중에서-알아두면-좋은-것들은-무엇이-있나요)
   7. [7️⃣ Docker compose를 devcontainer로 사용하고 싶다면 어떻게 해야 하나요?](#7️⃣-docker-compose를-devcontainer로-사용하고-싶다면-어떻게-해야-하나요)
   8. [8️⃣ 쉘 변경은 어떻게 하나요?](#8️⃣-쉘-변경은-어떻게-하나요)
4. [📹 실제 센서 연결](#-실제-센서-연결)
5. [✨ 기능 추가](#-기능-추가)
6. [🔑 문제 해결](#-문제-해결)
   1. [Q. 센서가 인식되지 않습니다.](#q-센서가-인식되지-않습니다)
   2. [Q. Windows에서 GUI 창이 뜨지 않습니다.](#q-windows에서-gui-창이-뜨지-않습니다)

---

## 📦 사전 준비

1. Host 시스템에 [Docker Engine](https://docs.docker.com/engine/install/)과 [VSCode](https://code.visualstudio.com/) 그리고 [Dev Containers 플러그인](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)이 설치되어 있어야 합니다.
2. GPU를 사용하려면, Host 시스템에 [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#setting-up-nvidia-container-toolkit)을 설치해야 합니다.

   <details>
   <summary>설치 방법</summary>

   ```bash
   # Add the package repositories
   distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
   && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
   sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
   sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

   # Install the toolkit
   sudo apt-get update
   sudo apt-get install -y nvidia-container-toolkit
   sudo nvidia-ctk runtime configure --runtime=docker
   sudo systemctl restart docker
   ```

   </details>

3. 현재 Dev Container에서 Host 시스템의 시간을 사용하도록 설정되어 있습니다. 따라서 컨테이너 내부의 시간을 NTP로 동기화하고 싶다면, Host 시스템에 `chrony` 설치를 추천합니다. (ROS Clock에 대해 읽어보기: [ROS2](https://design.ros2.org/articles/clock_and_time.html), [ROS1](http://wiki.ros.org/Clock))

   ```bash
   sudo apt install chrony
   ```

## ✏️ 사용법

1. 원하는 workspace 이름으로 저장소를 내려받습니다. 다음 2가지 방법 중 하나를 선택하세요.

   - **(방법 1)** 본 저장소를 바로 내려받고 git 연결을 끊는 방법. `$YOUR_WORKSPACE_NAME`는 원하는 workspace 이름으로 바꿔주세요.

      ```bash
      git clone https://github.com/rise-lab-skku/ros2_ws_kr.git $YOUR_WORKSPACE_NAME
      cd $YOUR_WORKSPACE_NAME
      git remote remove origin
      ```

   - **(방법 2)** 본인의 private 저장소를 만들어서 workspace를 관리하는 방법. 이렇게 하면 `./src/` 폴더에 담을 ROS 패키지들을 [submodule](https://git-scm.com/book/ko/v2/Git-%EB%8F%84%EA%B5%AC-%EC%84%9C%EB%B8%8C%EB%AA%A8%EB%93%88)로 관리할 수 있습니다.

      <details>
      <summary>펼치기</summary>

      템플릿을 사용하여 새 저장소 만들기를 선택합니다.

      ![image](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/aa68da73-e0b6-4115-a24b-c1052458a7b8)

      저장소 이름을 원하는 workspace 이름으로 설정하고, private으로 생성합니다.

      ![image](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/21f8ea0c-67ae-478e-861a-e7ae2d3a0fd2)

      생성된 저장소를 내려받습니다. `git clone ${복사한 저장소 주소}`

      ![image](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/e5bf84b3-9c26-490a-9937-90d6f46f96f2)

      </details>

1. 내려받은 workspace를 VSCode로 엽니다.
   - **오른쪽 하단**에 컨테이너를 사용할 것인지 묻는 팝업이 뜨면, `Reopen in Container`를 선택합니다.
   - 만약 팝업을 보지 못했다면, `Ctrl+Shift+P`로 패널을 열어서 `Dev Containers: Reopen in Container`를 선택합니다.
   - 위의 과정을 거치면, 컨테이너가 빌드되고 VSCode가 재시작됩니다.
   - 최초 실행 시, Docker 이미지를 빌드하는 과정이 있어서 시간이 몇 분 정도 걸릴 수 있지만, 두 번째 실행부터는 빌드된 이미지가 있으므로 바로 실행됩니다.

2. 올바로 실행되었다면, ``Ctrl+Shift+`(역따옴표)``로 터미널을 열여서 유저이름이 `ros`인 것을 확인할 수 있고, 다음과 같이 ROS2 명령어를 사용할 수 있습니다. <span style="color:red">(단, Windows 환경이라면 Ubuntu와 달리 X11 포워딩을 수동으로 설정해야 GUI 창이 뜹니다. [설정 방법](#q-windows에서-gui-창이-뜨지-않습니다)을 참고바랍니다.)</span>

   ```zsh
   ros@...:~$ rviz2
   ```

참고로,

- 기본 쉘은 `zsh`입니다. [Oh My Zsh](https://ohmyz.sh/)이 설치되어 있으며, [agnoster](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#agnoster) 테마를 사용합니다. `bash`를 원하신다면, [여기 적힌 방법](#8️⃣-쉘-변경은-어떻게-하나요)으로 얼마든지 바꿀 수 있습니다.
- [DooD](https://code.visualstudio.com/remote/advancedcontainers/use-docker-kubernetes#:~:text=Docker%2Dfrom%2DDocker%20%2D%20Also,but%20has%20bind%20mounting%20limitations.) 설정이 되어 있어서, Host의 Docker를 Dev Container 내에서도 동일하게 사용할 수 있습니다. 다만, rootless 모드가 설정되어 있지 않아서 `sudo`를 입력해야 합니다. 예를 들어, `sudo docker ps`를 입력하면, Dev Container 자기 자신이 나타납니다.

## 📌 정보

### 1️⃣ 유용한 기능들은 무엇이 있나요?

- 실제 Host PC를 사용하는 것과 거의 동일한 경험을 제공합니다.
   - `sudo` 명령을 사용할 수 있어서, `sudo apt install`로 패키지를 추가로 설치할 수 있습니다.
   - Host의 Docker를 Dev Container 내부에서 사용할 수 있도록 [DooD (Docker-outside-of-Docker)](https://code.visualstudio.com/remote/advancedcontainers/use-docker-kubernetes#:~:text=Docker%2Dfrom%2DDocker%20%2D%20Also,but%20has%20bind%20mounting%20limitations.) 설정이 되어 있습니다. 다만 `docker` 명령어를 사용하려면, `sudo`를 붙여야 합니다. (예: `sudo docker ps`)
   - 실제 센서들을 쉽게 사용할 수 있도록 [components 폴더](components)에 Dockerfile이 미리 준비되어 있습니다.
   - GUI 프로그램을 실행할 수 있습니다.
- `tasks.json`에는 다양한 task들이 미리 설정되어 있습니다.
  - `Ctrl+Shift+P`를 눌러 `Tasks: Run Task`를 선택하고, 사용할 수 있는 task들을 확인해보세요.
  - Tasks를 활용하는 멋진 방법은 [원작자의 블로그](https://www.allisonthackston.com/articles/vscode-tasks.html)를 확인해주세요.
- 기본 쉘로 `zsh`이 설정되어 있고, [Oh My Zsh](https://ohmyz.sh/)의 유용한 플러그인들도 미리 설치되어 있습니다. 쉘을 `bash`로 되돌리고 싶다면 [(8️) 쉘 변경은 어떻게 하나요?](#8️⃣-쉘-변경은-어떻게-하나요)를 읽어주세요.
- APT mirror 서버가 Kakao 서버로 설정되어 있어 국내에서 `apt update`와 `apt install`이 빠릅니다.
- ROS2에서 추천하는 formatter와 linter가 설정되어 있습니다. ([ROS2 code style](https://docs.ros.org/en/rolling/The-ROS2-Project/Contributing/Code-Style-Language-Versions.html))
- Github CI로 ROS2 linting이 설정되어 있습니다. [``.github/workflows/ros.yaml``](.github/workflows/ros.yaml) 파일을 참고하세요.

### 2️⃣ Dev Container는 일반적인 컨테이너에 비해 어떤 장점이 있나요?

- Dev Container를 사용하면, 컨테이너 환경뿐만 아니라 extension 같은 VSCode의 설정들도 일관되게 관리할 수 있습니다.
- 공유할 수 있는 VSCode의 설정들에는 `tasks.json`, `launch.json`, `settings.json` 등도 포함됩니다.
- 원격지 서버의 Dev Container도 쉽게 사용할 수 있으므로, 로컬 PC의 성능에 구애받지 않고 개발할 수 있습니다. ([참고가 될만한 팁](#원격으로-vscode를-사용할-때-유용한-팁이-있나요))

### 3️⃣ 배포용 도커 이미지는 어떻게 만들 수 있나요?

배포용 도커 이미지는 다음 도커파일을 참고하여 작성하시길 추천합니다.

- [athackst/humble.Dockerfile](https://github.com/athackst/dockerfiles/blob/main/ros2/humble.Dockerfile)
- [athackst/humble-cuda.Dockerfile](https://github.com/athackst/dockerfiles/blob/main/ros2/humble-cuda.Dockerfile)

다양한 ROS2 도커 이미지 예시로는 [DominikN/ros2_docker_examples](https://github.com/DominikN/ros2_docker_examples)가 좋은 참고 자료가 될 것입니다.

만약, 컨테이너 내부의 시간을 호스트 시스템의 시간과 동일하게 맞추고 싶다면, 다음과 같이 volume을 마운트하면 됩니다.

```bash
--volume=/etc/timezone:/etc/timezone:ro \
--volume=/etc/localtime:/etc/localtime:ro
```

### 4️⃣ 원격으로 VSCode를 사용할 때 유용한 팁이 있나요?

- 원격지 서버에서 개발할 때 잦은 비밀번호 입력으로 불편하다면, `ssh-keygen & ssh-copy-id`를 사용하여 비밀번호 없이 로그인할 수 있도록 설정하거나 `ssh-agent`를 사용하여 비밀번호를 한 번만 입력하도록 설정할 수 있습니다.
- 원격으로 접속할 때도 X11 포워딩을 통해 GUI 창을 띄울 수 있습니다. 원격 서버가 Linux라면, VSCode에서 ssh 접속 시 `-X` 옵션을 주면 됩니다. 만약 `X11 connection rejected` 같은 오류가 발생한다면, [설정이 올바른지](https://unix.stackexchange.com/questions/162979/annoying-message-x11-connection-rejected-because-of-wrong-authentication-while) 또는 `devcontainer.json`에서 `DISPLAY` 변수는 현재 환경에 적절한지 확인해주세요. 필요에 따라 서버에서 `$HOME/.Xauthority` 폴더를 지워야 할 수도 있습니다.

   ```sh
   ssh user@host -X -A
   # -X Enables X11 forwarding.
   # -A Enable forwarding of the authentication agent connection. (ssh-agent)
   ```

### 5️⃣ 설정된 settings.json 중에서 알아두면 좋은 것들은 무엇이 있나요?

키보드 타이핑이 끝나고 1초 후에 자동으로 저장되도록 설정되어 있기 때문에, 저장 단축키를 누르지 않아도 자동으로 저장됩니다.
또한, 파일 끝에 있는 빈 줄과 공백 문자들도 자동으로 제거되도록 설정되어 있습니다.

```json
"files.autoSave": "afterDelay",
"files.trimTrailingWhitespace": true,
"files.trimFinalNewlines": true,
"editor.formatOnType": false,
```

### 6️⃣ 설정된 devcontainer.json 중에서 알아두면 좋은 것들은 무엇이 있나요?

- `runArgs` 항목에 주석 처리된 옵션들이 있습니다. 필요한 옵션이 있다면 주석을 해제하고 사용하시면 됩니다.
- 사용할 도커 이미지를 변경하고 싶다면, `dockerFile` 항목을 수정하면 됩니다.

   ```json
   {
     "dockerFile": "humble_full.Dockerfile",
     // "dockerFile": "humble_full_cuda.Dockerfile",
   }
   ```

- Extension 중에서 GitHub 계정이 필요한 것들은 주석 처리되어 있습니다. 필요하다면 주석을 해제하고 사용하시면 됩니다. (GitHub Copilot과 GitHub Actions)

   ```json
   "extensions": [
     // // [Optional] These extensions require GitHub account authentication. Uncomment them to enable.
     // "github.vscode-github-actions",
     // "GitHub.copilot",
   ]
   ```

### 7️⃣ Docker compose를 devcontainer로 사용하고 싶다면 어떻게 해야 하나요?

VSCode의 공식 문서에 [Docker compose를 devcontainer로 사용하는 방법](https://code.visualstudio.com/docs/devcontainers/create-dev-container#_use-docker-compose)이 잘 설명되어 있습니다.

### 8️⃣ 쉘 변경은 어떻게 하나요?

- `bash`와 `zsh`을 자유롭게 사용할 수 있습니다. `bash`를 사용하고 싶다면, 터미널에서 `bash`를 입력하면 됩니다.
- 기본 쉘을 바꾸고 싶다면, [devcontainer.json](.devcontainer/devcontainer.json)에서 `"terminal.integrated.defaultProfile.linux"` 항목을 수정하면 됩니다.

## 📹 실제 센서 연결

- [Azure Kinect 컨테이너](./components/azure_kinect/README.md)
- [Intel RealSense 컨테이너](./components/realsense/README.md)

## ✨ 기능 추가

새로운 기능에 대한 요청이나 추가는 issue나 pull request를 통해 환영합니다. 관리자가 주기적으로 확인하고 있으나, 답변은 늦을 수 있으니 양해 부탁드립니다.

## 🔑 문제 해결

### Q. 센서가 인식되지 않습니다.

- 컨테이너를 실행할 때 적절한 권한과 옵션을 부여하였는지 확인해주세요. `--privileged` 옵션이 필요할 수도 있습니다.
- 연결선이 적절한 사양인지 확인해주세요. 실수로 데이터 선이 없는 케이블을 사용하고 있거나, 다른 작업 도중 연결선이 빠지지 않았는지 확인해주세요. `lsusb` 명령어로 연결된 USB 장치들을 확인할 수 있습니다.
- 그럼에도 작동하지 않는다면, 다른 포트에 꽂아보세요. 노트북이나 데스트탑 PC에 USB 포트가 여러 개 있다면, 동일하게 USB 3.0이라고 적혀있더라도 실제 대역폭과 세부 스팩이 다른 포트가 섞여 있는 경우가 있습니다. 그렇기 때문에, 다른 포트에 꽂으면 문제가 해결될 수도 있습니다.

### Q. Windows에서 GUI 창이 뜨지 않습니다.

Windows에서는 X11 포워딩이 기본적으로 없기 때문에, [Xming](https://sourceforge.net/projects/xming/)이나 [MobaXterm](https://mobaxterm.mobatek.net/)과 같은 X11 서버를 설치해야 합니다. <span style="color:red">여기서는 설정이 간편한 MobaXterm을 사용하겠습니다.</span>

1. MobaXterm을 설치합니다.
2. Settings > Configuration > X11에서 `OpenGL acceleration`을 `Software`로 설정합니다. 설정 후에는 MobaXterm을 그냥 켜두면 됩니다. (이 설정을 하지 않으면, RViz2가 실행되지 않습니다.)

   ![MobaXterm1](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/88e13275-54d9-4983-90ae-aed200f978ce)
   ![MobaXterm2](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/612374ae-2269-4af1-b3a0-5bc8a56d5f9b)

3. 윈도우에서 CMD 또는 PowerShell을 열고 `ipconfig`를 입력합니다. 여기서 WSL 항목에 적힌 IPv4 Address 주소를 확인합니다. 이 주소값 뒤에 `:0`를 붙여서, `.devcontainer` 폴더 > `devcontainer.json` 파일의 `DISPLAY` 항목에 입력합니다.

   ![ipconfig](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/777a7bf6-a086-411e-a087-349151a58557)
   ![DISPLAY variable](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/22e72644-69d6-4602-903c-643158ad4a44)
   ![DISPLAY devcontainer](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/926d6b0b-ed4b-4037-96c9-8074aa1c5c03)

4. VSCode에서 `Ctrl+Shift+P` > `Dev Containers: Rebuild Container`를 선택합니다. 이제 RViz2 창이 뜨는 것을 확인할 수 있습니다.

   ![RViz2 on Windows](https://github.com/rise-lab-skku/ros2_ws_kr/assets/19263912/5daeb6e0-830e-417a-be99-6d4017dc6b05)
