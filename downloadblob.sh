#!/bin/bash

apt-get update -y && apt-get install -y python libssl-dev libffi-dev python-dev build-essential
curl -L https://azurecliprod.blob.core.windows.net/install.py -o install.py
printf "/usr/azure-cli\n/usr/bin" | python install.py
az

export AZURE_STORAGE_ACCOUNT=devopsblogstorage
export container_name=pretrainedmodel
export AZURE_STORAGE_KEY=fzy27WL5j0c+N5/DepTkvfpUEJLz2c2S33q1SDuOh83cZKv3m7WMidKJD1ScKVFBWNZg4IKv1s7n7JCjmX4liQ==

az storage blob download --container-name $container_name --name ResNet_152.model --file downloadedmodelfile --output table
az storage blob list --container-name $container_name --output table
