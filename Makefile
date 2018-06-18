define PROJECT_HELP_MSG
Usage:
    make help                           show this message
    make image                          make docker image
    make push				push image to acr
    make run-local			run the docker container locally
endef
export PROJECT_HELP_MSG

acr = blogacr.azurecr.io
image_name = $(acr)/modelapi
vpath % flaskwebapp

help:
	@echo "$$PROJECT_HELP_MSG" | less

push: image
	docker push $(image_name)

image: flaskwebapp/ResNet_152.model flaskwebapp/synset.txt
	docker build -t $(image_name) -f flaskwebapp/dockerfile flaskwebapp

flaskwebapp/synset.txt:
	wget http://data.dmlc.ml/mxnet/models/imagenet/synset.txt -P flaskwebapp

flaskwebapp/ResNet_152.model:
	wget https://www.cntk.ai/resnet/ResNet_152.model -P flaskwebapp

run-local:
	docker run -p 88:88 $(image_name)

.PHONY: help push image run-local
