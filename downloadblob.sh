#!/bin/bash

#This file is to download pretrained model file and associate synset.txt file. It is assumed that these two files are already in a blob
#container, if you want to use a pretrained image classification model and associated synset file, you can download them from the links below
# and put them in storage container
# wget http://data.dmlc.ml/mxnet/models/imagenet/synset.txt
# wget https://www.cntk.ai/resnet/ResNet_152.model

# Downloading Azure CLI on the VSTS build agent machine
apt-get update -y && apt-get install -y python libssl-dev libffi-dev python-dev build-essential
curl -L https://azurecliprod.blob.core.windows.net/install.py -o install.py
printf "/usr/azure-cli\n/usr/bin" | python install.py
az

#Setting environment variables to access the blob container
export AZURE_STORAGE_ACCOUNT=$1
export AZURE_STORAGE_KEY=$2
export container_name=$3
export blob_name1=$4
export blob_name2=$5

# Downloading Blob
mkdir flaskwebapp
az storage blob download --container-name $container_name --name $blob_name1 --file flaskwebapp/$blob_name1 --output table
az storage blob download --container-name $container_name --name $blob_name2 --file flaskwebapp/$blob_name2 --output table
az storage blob list --container-name $container_name --output table
