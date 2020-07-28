#!/bin/bash

# user setting
IDE_DOWNLOAD_URL='https://download-cf.jetbrains.com/idea/ideaIU-2020.1.3.tar.gz'
TAR_GZ_FILE_PATH='ideaIU-2020.1.3.tar.gz'

# download and extract
IDE_FOLDER_PATH='mount_point/opt/idea/'
cd ${IDE_FOLDER_PATH}
if [ ! -f "${TAR_GZ_FILE_PATH}" ] ; then
  curl -o "${TAR_GZ_FILE_PATH}" "${IDE_DOWNLOAD_URL}"
  tar zxvf "${TAR_GZ_FILE_PATH}"
fi


