#!/bin/bash

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
     sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install azure-cli

export AZURE_STORAGE_ACCOUNT=devopsblogstorage
export container_name=pretrainedmodel
export AZURE_STORAGE_KEY=fzy27WL5j0c+N5/DepTkvfpUEJLz2c2S33q1SDuOh83cZKv3m7WMidKJD1ScKVFBWNZg4IKv1s7n7JCjmX4liQ==

az storage blob download --container-name $container_name --name ResNet_152.model --file downloadedmodelfile --output table
az storage blob list --container-name $container_name --output table
