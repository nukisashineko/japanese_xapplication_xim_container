# abstract 
Japanese Xapplication container ( runnable idea.sh with mozc on wsl )

# VM Host Setting
Please xim client application install.   
Check run your xapplication (xeyes etc.) from any vm when you set only "export DISPLAY=XXX.XXX.XXX.XXX:0.0"  
## for Windows
- VcXsrv
- X410
    - (maybe require "Allow public access")

## for Mac 
( comming soon ... )


# usage
## script file setting
change "user setting" of bin/start_idea.sh
```bash
vim bin/donwload_idea.sh
vim bin/start_idea.sh
```

## first run
```bash
cd `pwd`/`git rev-parse --show-cdup`
bash bin/donwload_idea.sh 

# setting fcitx, mozc and idea ( SETTING_FCITX_AND_MOZC=1 plz. )
## fcitx setting: you require to add mozc  
bash bin/start_idea.sh 
```

## run 
```bash
cd `pwd`/`git rev-parse --show-cdup`
bash bin/start_idea.sh 
```

# other hint
### bin/start_idea.sh error
#### Q. error OCI runtime 
```text
~/workspace/xim_japanese_docker_container$ bash bin/start_idea.shStarting xim_japanese_docker_container_runner_1 ... error

ERROR: for xim_japanese_docker_container_runner_1  Cannot start service runner: OCI runtime create failed: container_linux.go:349: starting container process caused "process_linux.go:449: container init caused \"rootfs_linux.go:58: mounting \\\"/run/desktop/mnt/host/wsl/docker-desktop-bind-mounts/WLinux/428b987a781a813911f379ffcd891c371463c0ba23bc848c9c41d474cacc6ee6\\\" to rootfs \\\"/var/lib/docker/overlay2/8bf6cc8eb3e7bd64543bde490bd85347cba04adbd6ac4a64b0bed440f6fe683f/merged\\\" at \\\"/var/lib/docker/overlay2/8bf6cc8eb3e7bd64543bde490bd85347cba04adbd6ac4a64b0bed440f6fe683f/merged/var/tmp/docker-entrypoint.sh\\\" caused \\\"no such file or directory\\\"\"": unknown

ERROR: for runner  Cannot start service runner: OCI runtime create failed: container_linux.go:349: starting container process caused "process_linux.go:449: container init caused \"rootfs_linux.go:58: mounting \\\"/run/desktop/mnt/host/wsl/docker-desktop-bind-mounts/WLinux/428b987a781a813911f379ffcd891c371463c0ba23bc848c9c41d474cacc6ee6\\\" to rootfs \\\"/var/lib/docker/overlay2/8bf6cc8eb3e7bd64543bde490bd85347cba04adbd6ac4a64b0bed440f6fe683f/merged\\\" at \\\"/var/lib/docker/overlay2/8bf6cc8eb3e7bd64543bde490bd85347cba04adbd6ac4a64b0bed440f6fe683f/merged/var/tmp/docker-entrypoint.sh\\\" caused \\\"no such file or directory\\\"\"": unknown
ERROR: Encountered errors while bringing up the project.
something error happening
ERROR: No container found for runner_1
something error happening
... waiting for finish docker-entry-point.sh
```
#### A. compose down plz ( or maybe reboot)
```bash
docker-compose down
```



### debug (if you want)
```bash
# compose up
USER_HOME=/home/default USER_NAME=$(whoami) USER_ID=$(id -u) GROUP_ID=$(id -g) DISPLAY=192.168.11.2:0.0  docker-compose up
# compose exec 
docker-compose exec runner su - $(whoami) -s /bin/bash
```
