#!/bin/bash

# user setting
IDE_SHELL_PATH_IN_DOCKER='/opt/idea/idea-IU-201.7223.91/bin/idea.sh'
USER_HOME_PATH_IN_DOCKER='/home/default'

# this script trap setting
## setting trap
trap catch ERR
trap finally EXIT

## executed function when happen error in process
function catch {
    echo 'something error happening'
}
## always executed function when process exit 
function finally {
    docker-compose down
}


# run IDE
## run docker container and create current login user (same uid and same gid is to avoid mount and sync owner problem)
USER_HOME="${USER_HOME_PATH_IN_DOCKER}" USER_NAME=$(whoami) USER_ID=$(id -u) GROUP_ID=$(id -g) DISPLAY=192.168.11.2:0.0  docker-compose up -d

## check to created current login user as nopasswd sudoer
while [ 1 ]; do
	sleep 1
	docker-compose exec runner su - $(whoami) -s /bin/bash -c "( sudo -l -U $(whoami) >/dev/null 2>&1 ) && echo 'It is to able to login to docker current user as sudoer user'"
	if [ $? -eq 0 ]; 
	then
	       	break;
	fi
	echo '... waiting for finish docker-entry-point.sh'
done;

## login and start IDE (require update-locale and relogin if you want to input japanese in idea )
docker-compose exec runner su - $(whoami) -s /bin/bash -c 'sudo update-locale LANG=ja_JP.UTF8'
docker-compose exec runner su - $(whoami) -s /bin/bash -c 'locale && fcitx-autostart'
docker-compose exec runner su - $(whoami) -s /bin/bash -c "source .xprofile && ${IDE_SHELL_PATH_IN_DOCKER}"

