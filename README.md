This repository contains samples showing how to build an AI application with DevOps in mind. For an AI application, there are always two streams of work, Data Scientists building machine learning models and App developers building the application and exposing it to end users to consume. test

In this tutorial we demonstrate how you can build a continous integration pipeline for an AI application. The pipeline kicks off for each new commit, run the test suite, if the test passes takes the latest build, packages it in a Docker container. The container is then deployed using Azure container service (ACS) and images are securely stored in Azure container registry (ACR). ACS is running Kubernetes for managing container cluster but you can choose Docker Swarm or Mesos.

The application securely pulls the latest model from an Azure Storage account and packages that as part of the application. Teh deployed application has the app code and ML model packaged as single container.

This decouples the app developers and data scientists, to make sure that their production app is always running the latest code with latest ML model.

Variation to this tutorial could be consuming the ML application as an endpoint instead of packaging it in the app. The goal is to show how easy it is do devops for an AI application.

For detailed instructions please refer to the [tutorial](https://github.com/Azure/DevOps-For-AI-Apps/blob/jainr-refactor/Tutorial.md)

Details about the code repository
* flaskwebapp - contains the application code.
* images - contains images used in tutorial.
* test - contains integration test
* deploy.yaml - used while deploying on Kubernetes ACS cluster.
* downloadblob.sh - script to download pretrained model and supporting files.
* tutorial.md - Starting point and step by step instuctions on creating build and release definitions.
