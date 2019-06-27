#!/bin/bash

cd $PWD
. "$PWD/env/bin/activate"
export KIVY_VIDEO=ffpyplayer
pip check
PIP_CHECK=$?

if [ "$PIP_CHECK" = 0 ]; then
    echo "All packages installed"
else
    pip install -r requiriments.txt
fi

chmod +x main.py

python main.py
