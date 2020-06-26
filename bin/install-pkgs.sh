#!/bin/bash

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get install -y python${PY_VER}-dev
wget -O get-pip.py https://bootstrap.pypa.io/get-pip.py
python3.8 get-pip.py
