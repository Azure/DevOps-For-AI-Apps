#!/bin/bash

export AZURE_STORAGE_ACCOUNT=devopsblogstorage
export container_name=pretrainedmodel


az storage blob download --container-name $container_name --name ResNet_152.model --file downloadedmodelfile --output table
az storage blob list --container-name $container_name --output table
