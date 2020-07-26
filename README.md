

USER_NAME=$(whoami)   USER_ID=$(id -u)   GROUP_ID=$(id -g) DISPLAY=192.168.11.2:0.0  docker-compose up


docker exec -it idea_docker_runner_1 su - root
passwd nukisashineko

docker exec -it idea_docker_runner_1 su - $(whoami)
source .xprofile &&  sudo service dbus start  && sudo update-locale LANG=ja_JP.UTF8  && fcitx-autostart && /opt/idea/idea-IU-201.7223.91/bin/idea.sh
