#!/usr/bin/env bash

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

  : "Set home directory" && {
    export HOME=/home/${USER_NAME}
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
