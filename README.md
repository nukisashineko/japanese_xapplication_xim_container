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

## run
```bash
cd `pwd`/`git rev-parse --show-cdup`
bash bin/donwload_idea.sh 
bash bin/start_idea.sh 
```