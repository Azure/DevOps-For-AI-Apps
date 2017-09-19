define PROJECT_HELP_MSG
Usage:
    make help                           show this message
    make image                          remove model
    make push
endef
export PROJECT_HELP_MSG

password = demo
app_server_path = /home/mat/repos/AdvancedHTTPServer
web_root_path = /home/mat/repos/Jabil-ImagePM/Code/03_Deployment/ignite_demo
acr = predictivehub.azurecr.io
image_name = $(acr)/modelapi
data_path = /mnt/data/jabil
vpath %.model $(data_path)


help:
	@echo "$$PROJECT_HELP_MSG" | less

push: image
	docker push $(image_name)

image: flaskwebapp/ResNet_152.model flaskwebapp/synset.txt
	docker build -t $(image_name) -f flaskwebapp/dockerfile flaskwebapp

flaskwebapp/ResNet_152.model:
    wget https://migonzastorage.blob.core.windows.net/deep-learning/models/cntk/imagenet/ResNet_152.model -P flaskwebapp

flaskwebapp/synset.txt:
    wget "https://ikcompuvision.blob.core.windows.net/acs/synset.txt -P flaskwebapp


.PHONY: help push image
