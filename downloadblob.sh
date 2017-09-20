#!/bin/bash

# Downloading Azure CLI on the VSTS build agent machine
apt-get update -y && apt-get install -y python libssl-dev libffi-dev python-dev build-essential
curl -L https://azurecliprod.blob.core.windows.net/install.py -o install.py
printf "/usr/azure-cli\n/usr/bin" | python install.py
az

#Setting environment variables to access the blob container
export AZURE_STORAGE_ACCOUNT=$1
export AZURE_STORAGE_KEY=$2
export container_name=$3
export blob_name=$4

# Downloading Blob
az storage blob download --container-name $container_name --name $blob_name --file $blob_name --output table
az storage blob list --container-name $container_name --output table
