#!/bin/bash
# This script tests the docker image passed to it

IMAGE=$1
echo "Starting Docker image " $IMAGE

docker run -d -p 88:88 $IMAGE

sleep 10

# Simple API test
echo "Testing API"
reply=$(curl http://0.0.0.0:88/version)
if [[ $reply == 2.0rc1 ]]; then
        echo -e "Successfully validated version API call"
else
        echo "Basic API call failed"
        exit 1
fi

# Testing classification
echo "Testing Classification"
 source anaconda/bin/activate
result=$(python test/classify.py)
source anaconda/bin/deactivate

echo $result

echo "Stopping container and removing"
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

echo "Finished"
exit 0
