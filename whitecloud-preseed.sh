#!/bin/bash
export IMAGE_NAME=ayamunaque/preseed
export TAG=1.4
export UBUNTU="http://cdimage.ubuntu.com/ubuntu-server/bionic/daily/current/bionic-server-amd64.iso"

echo "Downloading Docker Image:"
docker pull ${IMAGE_NAME}:${TAG}

sudo mkdir -p /etc/preseed/base_image
sudo mkdir -p /etc/preseed/new_image

read -p "Do you want to download the last version of Ubuntu Bionic? (y/n) `echo $'\n> '`" answer
if [ "$answer" == "y" ]; then
  echo "Downloading Ubuntu Image"
  sudo wget -4 $UBUNTU -P /etc/preseed/base_image
else
  echo "Executing docker container"
fi

sudo docker run --rm -it --privileged --name generator-iso -v /etc/preseed:/etc/preseed $IMAGE_NAME:$TAG python3 /root/main.py
