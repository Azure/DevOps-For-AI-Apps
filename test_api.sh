#!/usr/bin/env bash

docker images
docker ps -a
#docker run -d -p 88:88 acrforblog.azurecr.io/model-api:91
#docker inspect acrforblog.azurecr.io/model-api:91
sleep 20s
curl http://0.0.0.0:88/version
