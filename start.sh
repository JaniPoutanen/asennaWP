#!/bin/bash

sudo apt-get update
sudo apt-get -y install puppet git
git config --global user.email "janipoutanen@gmail.com"
git config --global user.name "jani"
git config --global credential.helper "cache --timeout=7200"
git clone https://github.com/JaniPoutanen/asennaWP.git
cd asennaWP
sudo cp -r modules /etc/puppet/
bash apply.sh
