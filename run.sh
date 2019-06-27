#!/bin/bash

DEPLOY_ENV="env"

if [ ! -d "$PWD/$DEPLOY_ENV" ]; then
    echo "Directory not created"
    virtualenv -p python3 env
fi

cd $PWD
. "$PWD/$DEPLOY_ENV/bin/activate"
export KIVY_VIDEO=ffpyplayer

PIP_CHECK=`pip check`

if [ "$PIP_CHECK" -eq 0 ]; then
    echo "All packages installed"
else
    pip install -r requiriments.txt
fi

chmod +x main.py

python main.py
