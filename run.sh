#!/bin/bash

DEPLOY_ENV="env"
DIR_LOCATION=`dirname $0`

cd $DIR_LOCATION
if [ ! -d "$DIR_LOCATION/$DEPLOY_ENV" ]
then
    echo "Error: Directory $DIR_LOCATION/$DEPLOY_ENV does not exists."
    virtualenv -p python3 env
else
    echo "Directory $DIR_LOCATION/$DEPLOY_ENV exists."
fi

. "$DIR_LOCATION/$DEPLOY_ENV/bin/activate"
export KIVY_VIDEO=ffpyplayer

pip install -r requirements.txt

chmod +x main.py

python main.py
