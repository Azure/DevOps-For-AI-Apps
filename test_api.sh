#!/usr/bin/env bash

docker images
docker ps -a
docker run -p 88:88 acrforblog.azurecr.io/model-api:89

#curl http://localhost:88/version
