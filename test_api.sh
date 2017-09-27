#!/bin/bash
# This script tests the docker image passed to it

IMAGE=$1
echo "Starting Docker image " $IMAGE

docker run -d -p 88:88 $IMAGE

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

sleep 10

# Simple API test
echo "Testing API"
reply=$(curl http://0.0.0.0:88/version)
if [[ $reply == 2.0rc1 ]]; then
        echo -e "${GREEN}Successfully validated version API call ${NC}"
else
        echo "${RED}Basic API call failed ${NC}"
        exit 1
fi

echo "Stopping container and removing"
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
