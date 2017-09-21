#!/usr/bin/env bash

docker run -d -p 8888:8888 acrforblog.azurecr.io/model-api:latest
docker images
docker ps -a
curl http://localhost:8888/version
