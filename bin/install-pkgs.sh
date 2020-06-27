#!/bin/bash

# Install Python version of our choice
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get install -y python${PY_VER}-dev

# Install PIP using the Python version we installed
wget --quiet --output-document get-pip.py https://bootstrap.pypa.io/get-pip.py
sudo -H python${PY_VER} $PWD/get-pip.py
