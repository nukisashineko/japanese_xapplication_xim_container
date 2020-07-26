FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
# timezone setting
ENV TZ=Asia/Tokyo


RUN apt update -y && apt upgrade -y
RUN apt install -y --no-install-recommends apt-utils
RUN apt install ubuntu-desktop -y

# add vagrant sudoer user
RUN apt install sudo -y
#RUN useradd -rm -d /home/vagrant -s /bin/bash -G sudo vagrant
#USER vagrant
#WORKDIR /home/vagrant
#RUN pwconv
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]
#RUN echo 'vagrant:xpasswordx' | chpasswd 

#ENTRYPOINT []
# Use mirror repository
RUN sed -i.bak -e "s%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g" /etc/apt/sources.list

# Install prerequisite packages
RUN apt update \
 && apt -yq dist-upgrade \
 && apt install -yq --no-install-recommends \
      sudo \
      supervisor \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*


RUN rm -vf /var/lib/apt/lists/* && apt-get update &&  apt install -y git

RUN apt install -y vim fcitx-mozc fcitx-libs-dev

# Boot process
COPY mount_point/etc/supervisord.conf /etc
COPY mount_point/var/tmp/docker-entrypoint.sh /var/tmp
CMD bash -E /var/tmp/docker-entrypoint.sh

