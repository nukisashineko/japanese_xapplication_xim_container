FROM ubuntu:18.04
# install tzdata without interpreter (to avoid TTY problem around installing gnome)
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
## timezone setting
ENV TZ=Asia/Tokyo

# install gnome (for Xim)
RUN apt update -y && apt upgrade -y
RUN apt install -y --no-install-recommends apt-utils
RUN apt install ubuntu-desktop -y

# Use mirror repository
RUN sed -i.bak -e "s%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g" /etc/apt/sources.list

# Install prerequisite packages (for docker-entrypoint.sh)
RUN apt update \
 && apt -yq dist-upgrade \
 && apt install -yq --no-install-recommends \
      sudo \
      supervisor \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*


# install git, vim and mozc (after recovery apt/list)
RUN rm -vf /var/lib/apt/lists/* && apt-get update &&  apt install -y git
RUN apt install -y vim fcitx-mozc fcitx-libs-dev

# install Japanese Team language addtion package (for locale ja_JP.UTF8)
RUN ( wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add - ) \
  && ( wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add - ) \
  && ( wget https://www.ubuntulinux.jp/sources.list.d/bionic.list -O /etc/apt/sources.list.d/ubuntu-ja.list ) \
  && ( apt update && apt upgrade -y && apt install -y ubuntu-defaults-ja )

RUN apt-get update && apt-get install -y \
  curl \
  && rm -rf /var/lib/apt/lists/*

ENV DOCKER_CLIENT_VERSION=20.10.2
ENV DOCKER_API_VERSION=1.41
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLIENT_VERSION}.tgz \
  | tar zxv -C /usr/local/bin --strip=1 docker/docker
# Boot process
## copy default files ( but maybe overwrite by docker-compose.yml )
COPY mount_point/etc/supervisord.conf /etc
COPY mount_point/var/tmp/docker-entrypoint.sh /var/tmp
## set entrypoint
CMD bash -E /var/tmp/docker-entrypoint.sh

