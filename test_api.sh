#!/bin/bash

$IMAGE=$1


docker run -d -p 88:88 $IMAGE
reply=$(curl http://0.0.0.0:88/version)# Simple API test
if [ $reply == 2.0rc1 ]; then
	echo "Successfully validated version API call"
else
	echo "Basic API call failed"
	exit 1
fi
