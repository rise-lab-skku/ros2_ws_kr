# VSCode ROS2 Workspace Template for KR

This template provides a fully prepared ROS2 workspace using a VSCode devcontainer, and it employs the Kakao mirror as an Ubuntu APT mirror.

Furthermore, it builds upon two other repositories.
If you find this template useful, please consider showing your support by giving a star to the repositories mentioned below.

- [athackst/vscode_ros2_workspace](https://github.com/athackst/vscode_ros2_workspace)
- [sskorol/ros2-humble-docker-dev-template](https://github.com/sskorol/ros2-humble-docker-dev-template)

## 📦 사전 준비

Host 시스템에 Docker와 VSCode Remote Containers 플러그인이 설치되어 있어야 합니다.

- [Docker Engine](https://docs.docker.com/engine/install/)
- [VSCode](https://code.visualstudio.com/)
- [VSCode Remote Containers Plugin](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## ✏️ 사용법

- 원하는 workspace 이름으로 본 저장소를 내려받습니다. `ws_[project]`는 원하는 workspace 이름으로 바꿔주세요.

  ```bash
  git clone https://github.com/rise-lab-skku/ros2_ws_kr.git ws_[project]
  ```

- 내려받은 workspace를 VSCode로 엽니다.
  - 컨테이너를 사용할 것인지 묻는 팝업이 뜨면, "Reopen in Container"를 선택합니다.
  - 만약 팝업을 보지 못했다면, 패널을 열어서 "Dev Containers: Reopen in Container"를 선택합니다.
- 잘 되었다면, 터미널에서 `ros`라는 이름으로 로그인된 것을 확인할 수 있습니다. (기본 쉘은 `zsh`입니다. 쉘에 대한 자세한 설명은 [유용한 기능](#유용한-기능들은-무엇이-있나요) 섹션을 참고해주세요.)

  ```bash
  ros@...:~$
  ```

- 자세한 사용법은 [how-to-use-this-template](#-how-to-use-this-template) 섹션을 참고해주세요.

## 📌 정보

### devcontainer는 일반적인 컨테이너에 비해 어떤 장점이 있나요?

- devcontainer를 사용하면, 컨테이너 환경뿐만 아니라 extension 같은 VSCode의 설정들도 일관되게 관리할 수 있습니다.
- 공유할 수 있는 VSCode의 설정들에는 `tasks.json`, `launch.json`, `settings.json` 등도 포함됩니다.

### 유용한 기능들은 무엇이 있나요?

- `tasks.json`에는 다양한 task들이 미리 설정되어 있습니다. `Ctrl+Shift+P`를 눌러 `Tasks: Run Task`를 선택하고, 사용할 수 있는 task들을 확인해보세요.
- 기본 쉘로 `zsh`이 설정되어 있고, [Oh My Zsh](https://ohmyz.sh/)의 유용한 플러그인들도 미리 설치되어 있습니다.
  - 물론, `bash`와 `zsh`을 자유롭게 사용할 수 있습니다. `bash`를 사용하고 싶다면, 터미널에서 `bash`를 입력하면 됩니다.
  - 기본 쉘을 바꾸고 싶다면, `~/.devcontainer/devcontainer.json`에서 `"terminal.integrated.defaultProfile.linux"` 항목을 수정하면 됩니다.
- 일반 PC에서 개발하듯 GUI 프로그램과 `sudo apt install`을 사용할 수 있습니다.
- APT mirror 서버가 Kakao 서버로 설정되어 있어 국내에서 `apt update`와 `apt install`이 빠릅니다.

### 배포용 도커 이미지는 어떻게 만들 수 있나요?

배포용 도커 이미지는 다음 도커파일을 참고하여 작성하시길 추천합니다.

- [athackst/humble.Dockerfile](https://github.com/athackst/dockerfiles/blob/main/ros2/humble.Dockerfile)
- [athackst/humble-cuda.Dockerfile](https://github.com/athackst/dockerfiles/blob/main/ros2/humble-cuda.Dockerfile)

다양한 ROS2 도커 이미지 예시로는 [DominikN/ros2_docker_examples](https://github.com/DominikN/ros2_docker_examples)가 좋은 참고 자료가 될 것입니다.

### 설정된 settings.json 중에서 알아두면 좋은 것들은 무엇이 있나요?

키보드 타이핑이 끝나고 1초 후에 자동으로 저장되도록 설정되어 있기 때문에, 저장 단축키를 누르지 않아도 자동으로 저장됩니다.
또한, 파일 끝에 있는 빈 줄과 공백 문자들도 자동으로 제거되도록 설정되어 있습니다.

```json
"files.autoSave": "afterDelay",
"files.trimTrailingWhitespace": true,
"files.trimFinalNewlines": true,
"editor.formatOnType": false,
```

### 설정된 devcontainer.json 중에서 알아두면 좋은 것들은 무엇이 있나요?

개발환경으로 사용할 도커 이미지를 변경하고 싶다면, `dockerFile` 항목을 수정하면 됩니다.

```json
{
  "dockerFile": "humble_full.Dockerfile",
  // "dockerFile": "humble_full_cuda.Dockerfile",
  ...
}
```

Extension 중에서 GitHub 계정이 필요한 GitHub Copilot과 GitHub Actions이 주석 처리되어 있습니다. 필요하다면 주석을 해제하고 사용하시면 됩니다.

```json
"extensions": [
  ...
  // [Optional] These extensions require GitHub account authentication. Uncomment them to enable.
  // "github.vscode-github-actions",
  // "GitHub.copilot",
  ...
]
```

### Docker compose를 devcontainer로 사용하고 싶다면 어떻게 해야 하나요?

VSCode의 공식 문서에 [Docker compose를 devcontainer로 사용하는 방법](https://code.visualstudio.com/docs/devcontainers/create-dev-container#_use-docker-compose)이 잘 설명되어 있습니다.

---

> *아래 이어지는 설명은 원본 저장소의 README.md 입니다.*
> *자세한 설명은 원본 저장소를 참고해주세요.*
> *<https://github.com/athackst/vscode_ros2_workspace>*


## 🪶 Features

### Style

ROS2-approved formatters are included in the IDE.

- **c++** uncrustify; config from `ament_uncrustify`
- **python** autopep8; vscode settings consistent with the [style guide](https://index.ros.org/doc/ros2/Contributing/Code-Style-Language-Versions/)

### Tasks

There are many pre-defined tasks, see [`.vscode/tasks.json`](.vscode/tasks.json) for a complete listing.  Feel free to adjust them to suit your needs.

Take a look at [how I develop using tasks](https://www.allisonthackston.com/articles/vscode_tasks.html) for an idea on how I use tasks in my development.

### Debugging

This template sets up debugging for python files, gdb for cpp programs and ROS launch files.  See [`.vscode/launch.json`](.vscode/launch.json) for configuration details.

### Continuous Integration

The template also comes with basic continuous integration set up. See [`.github/workflows/ros.yaml`](/.github/workflows/ros.yaml).

To remove a linter just delete it's name from this line:

```yaml
      matrix:
          linter: [cppcheck, cpplint, uncrustify, lint_cmake, xmllint, flake8, pep257]
```

## 🪶 How to use this template

### Prerequisites

You should already have Docker and VSCode with the remote containers plugin installed on your system.

- [docker](https://docs.docker.com/engine/install/)
- [vscode](https://code.visualstudio.com/)
- [vscode remote containers plugin](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Get the template

Click on "use this template"

![template_use](https://user-images.githubusercontent.com/6098197/91331899-43f23b80-e780-11ea-92c8-b4665ce126f1.png)

### Create your repository

On the next dialog, name the repository you would like to start and decide if you want all of the branches, or just the latest LTS: humble.

![template_new](https://user-images.githubusercontent.com/6098197/91332035-713ee980-e780-11ea-81d3-13b170f568b0.png)

Github will then create a new repository with the contents of this one in your account.  It grabs the latest changes as "initial commit".

### Clone your repo

Now you can clone your repo as normal

![template_download](https://user-images.githubusercontent.com/6098197/91332342-e4e0f680-e780-11ea-9525-49b0afa0e4bb.png)

### Open it in vscode

Now that you've cloned your repo onto your computer, you can open it in VSCode (File->Open Folder).

When you open it for the first time, you should see a little popup that asks you if you would like to open it in a container.  Say yes!

![template_vscode](https://user-images.githubusercontent.com/6098197/91332551-36898100-e781-11ea-9080-729964373719.png)

If you don't see the pop-up, click on the little green square in the bottom left corner, which should bring up the container dialog

![template_vscode_bottom](https://user-images.githubusercontent.com/6098197/91332638-5d47b780-e781-11ea-9fb6-4d134dbfc464.png)

In the dialog, select "Remote Containers: Reopen in container"

VSCode will build the dockerfile inside of `.devcontainer` for you.  If you open a terminal inside VSCode (Terminal->New Terminal), you should see that your username has been changed to `ros`, and the bottom left green corner should say "Dev Container"

![template_container](https://user-images.githubusercontent.com/6098197/91332895-adbf1500-e781-11ea-8afc-7a22a5340d4a.png)

### Update the template with your code

1. Specify the repositories you want to include in your workspace in `src/ros2.repos` or delete `src/ros2.repos` and develop directly within the workspace.
2. If you are using a `ros2.repos` file, import the contents `Terminal->Run Task..->import from workspace file`
3. Install dependencies `Terminal->Run Task..->install dependencies`
4. (optional) Adjust scripts to your liking.  These scripts are used both within tasks and CI.
   - `setup.sh` The setup commands for your code.  Default to import workspace and install dependencies.
   - `build.sh` The build commands for your code.  Default to `--merge-install` and `--symlink-install`
   - `test.sh` The test commands for your code.
5. Develop!

## 🪶 FAQ

### WSL2

#### The gui doesn't show up

This is likely because the DISPLAY environment variable is not getting set properly.

1. Find out what your DISPLAY variable should be

      In your WSL2 Ubuntu instance

      ```
      echo $DISPLAY
      ```

2. Copy that value into the `.devcontainer/devcontainer.json` file

      ```jsonc
        "containerEnv": {
          "DISPLAY": ":0",
         }
      ```

#### I want to use vGPU

If you want to access the vGPU through WSL2, you'll need to add additional components to the `.devcontainer/devcontainer.json` file in accordance to [these directions](https://github.com/microsoft/wslg/blob/main/samples/container/Containers.md)

```jsonc
  "runArgs": [
    "--network=host",
    "--cap-add=SYS_PTRACE",
    "--security-opt=seccomp:unconfined",
    "--security-opt=apparmor:unconfined",
    "--volume=/tmp/.X11-unix:/tmp/.X11-unix",
    "--volume=/mnt/wslg:/mnt/wslg",
    "--volume=/usr/lib/wsl:/usr/lib/wsl",
    "--device=/dev/dxg",
          "--gpus=all"
  ],
  "containerEnv": {
    "DISPLAY": "${localEnv:DISPLAY}", // Needed for GUI try ":0" for windows
    "WAYLAND_DISPLAY": "${localEnv:WAYLAND_DISPLAY}",
    "XDG_RUNTIME_DIR": "${localEnv:XDG_RUNTIME_DIR}",
    "PULSE_SERVER": "${localEnv:PULSE_SERVER}",
    "LD_LIBRARY_PATH": "/usr/lib/wsl/lib",
    "LIBGL_ALWAYS_SOFTWARE": "1" // Needed for software rendering of opengl
  },
```

### Repos are not showing up in VS Code source control

This is likely because vscode doesn't necessarily know about other repositories unless you've added them directly.

```
File->Add Folder To Workspace
```

![Screenshot-26](https://github.com/athackst/vscode_ros2_workspace/assets/6098197/d8711320-2c16-463b-9d67-5bd9314acc7f)

Or you've added them as a git submodule.

![Screenshot-27](https://github.com/athackst/vscode_ros2_workspace/assets/6098197/8ebc9aac-9d70-4b53-aa52-9b5b108dc935)

To add all of the repos in your *.repos file, run the script

```bash
python3 .devcontainer/repos_to_submodules.py
```

or run the task titled `add submodules from .repos`
