#!/usr/bin/env bash

apt-get update
if ! [ -d /home/vagrant/anaconda3 ]; then
  wget http://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh
  sudo chmod +x /home/vagrant/Anaconda3-4.0.0-Linux-x86_64.sh
  sudo /home/vagrant/Anaconda3-4.0.0-Linux-x86_64.sh -b
fi
export PATH="/home/vagrant/anaconda3/bin":$PATH
conda update -y conda
conda update -y anaconda
