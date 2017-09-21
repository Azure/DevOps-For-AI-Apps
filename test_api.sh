#!/usr/bin/env bash

docker images
docker ps -a
docker run -d -p 88:88 --network=host acrforblog.azurecr.io/model-api:94
#docker inspect acrforblog.azurecr.io/model-api:91
sleep 20s
curl http://0.0.0.0:88/version
