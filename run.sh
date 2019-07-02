#!/bin/bash

DEPLOY_ENV="env"
if [ ! -d "$PWD/$DEPLOY_ENV" ] 
then
    echo "Error: Directory $PWD/$DEPLOY_ENV does not exists."
    virtualenv -p python3 env
else
    echo "Directory $PWD/$DEPLOY_ENV exists."
fi

cd $PWD
. "$PWD/$DEPLOY_ENV/bin/activate"
export KIVY_VIDEO=ffpyplayer

pip install -r requirements.txt

chmod +x main.py

python main.py
