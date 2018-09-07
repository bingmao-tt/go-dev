#!/bin/bash

DIR_PATH=$(dirname $(readlink -f $0))
USER_ID=$(id | awk '{print $1}' | egrep -o "=[0-9]*\(" | egrep -o "[0-9]*")
GROUP_ID=$(id | awk '{print $2}' | egrep -o "=[0-9]*\(" | egrep -o "[0-9]*")

#cp $DIR_PATH/Dockerfile.default $DIR_PATH/Dockerfile
#
#sed -i "s/<UID>/$USER_ID/g" $DIR_PATH/Dockerfile
#sed -i "s/<GID>/$GROUP_ID/g" $DIR_PATH/Dockerfile


cd $DIR_PATH
set -e
docker-compose down
set +e

docker-compose build

set +e
docker rm $(docker ps -a | awk '{print $1}')
docker rmi -f $(docker images -f "dangling=true" -q)
set -e

docker-compose up -d
