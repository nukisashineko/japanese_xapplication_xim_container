#!/bin/bash

IDE_FOLDER_PATH='mount_point/opt/idea/'
IDE_DOWNLOAD_URL='https://download-cf.jetbrains.com/idea/ideaIU-2020.1.3.tar.gz'
TAR_GZ_FILE='ideaIU-2020.1.3.tar.gz'

cd ${IDE_FOLDER_PATH}
if [ ! -e ${TAR_GZ_FILE_PATH} ] ; then
  curl -o ${TAR_GZ_FILE_PATH} ${IDE_DOWNLOAD_URL}
  tar zxvf ${TAR_GZ_FILE_PATH}
fi


