FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
# timezone setting
ENV TZ=Asia/Tokyo


RUN apt update -y && apt upgrade -y
RUN apt install -y --no-install-recommends apt-utils
RUN apt install ubuntu-desktop -y

RUN useradd -ms /bin/bash vagrant
USER vagrant 
WORKDIR /home/vagrant
ENTRYPOINT []
