#!/usr/bin/env bash

# MOZC SERVER REQUIRE NON ROOT USER. So this entrypoint create non root user.
# link: https://blog.amedama.jp/entry/docker-container-host-same-user-bis
set -Ceux

assert_env_defined () {
  if [ ! -v $1 ]; then
    echo "please define '$1' environment variable"
    exit 1
  fi
}

: "Add non administrative user" && {

  : "Add user" && {
    assert_env_defined USER_NAME
    set +e  # avoid error check temporarily
    id ${USER_NAME}  # existence check
    if [ $? -ne 0 ]; then
      useradd -s /bin/bash -m ${USER_NAME}
    fi
    set -e  # enable error check
  }

  # use $USER_HOME if specify USER_HOME
  : "Set home directory" && {
    DEFAULT_USER_HOME="/home/${USER_NAME}"
    if [[  ! -v USER_HOME ]] ; then
      USER_HOME=${DEFAULT_USER_HOME}
    fi
    export HOME=$USER_HOME
    usermod -d ${USER_HOME} ${USER_NAME}
  }

  : "Change user id" && {
    assert_env_defined USER_ID
    if [ $(id -u ${USER_NAME}) -ne ${USER_ID} ]; then
      usermod -u ${USER_ID} ${USER_NAME}
    fi
  }

  : "Change group id" && {
    assert_env_defined GROUP_ID
    if [ $(id -g ${USER_NAME}) -ne ${GROUP_ID} ]; then
      if [[ ! $(grep -q ${GROUP_ID} /etc/group) ]] ; then
        groupadd -g ${GROUP_ID} templorary_create_group
      fi
      usermod -g ${GROUP_ID} ${USER_NAME}
    fi
  }

  : "Add common groups" && {
    usermod -aG sudo ${USER_NAME}
  }

  : "Add nopassword sudoer" && {
    echo 'Defaults visiblepw'                  >> /etc/sudoers
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
  }
}

: "Start supervisord" && {
  supervisord -c /etc/supervisord.conf
}
