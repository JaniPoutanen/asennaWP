#!/bin/bash

sudo apt-get update
sudo apt-get -y install puppet git
git config --global credential.helper "cache --timeout=3600"
git clone https://github.com/JaniPoutanen/asennaWP.git
cd asennaWP
sudo puppet apply --modulepath modules/ -e 'class  {"asennawp":}'
sudo cp -r modules /etc/puppet/
bash apply.sh
