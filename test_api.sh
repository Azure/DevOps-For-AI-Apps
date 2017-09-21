#!/usr/bin/env bash

docker run acrforblog.azurecr.io/model-api:latest
docker images
docker ps -a
curl http://localhost:8888/version
