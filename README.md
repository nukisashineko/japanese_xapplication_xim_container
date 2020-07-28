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
### debug (if you want)
```bash
# compose up
USER_HOME=/home/default USER_NAME=$(whoami) USER_ID=$(id -u) GROUP_ID=$(id -g) DISPLAY=192.168.11.2:0.0  docker-compose up
# compose exec 
docker-compose exec runner su - $(whoami) -s /bin/bash
```