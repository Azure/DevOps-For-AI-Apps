#!/usr/bin/env bash

docker images
docker ps -a
sleep 20s
curl http://localhost:88/version
