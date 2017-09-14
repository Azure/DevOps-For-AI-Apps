This repository contains samples showing how to build an AI application with DevOps in mind. For an AI application there are always two streams of work, Data Scientists building machine learning models and App developers building the application and exposing it to end users to consume.

In this tutorial we demonstrate how you can build a continous integration pipeline for an AI application. The pipeline kicks off for each new commit, run the test suite, if the test passes takes the latest build, packages it in a Docker container. The container is then deployed using Azure container service (ACS) and images are securely stored in Azure container registry (ACR). ACS is running Kubernetes for managing container cluster but you can choose Docker Swarm or Mesos.

The application securely pulls the latest model from an Azure Storage account and packages that as part of the application. Teh deployed application has the app code and ML model packaged as single container.

This decouples the app developers and data scientists, to make sure that the production app is always running the latest code with latest ML model.

Variation to this tutorial could be consuming the ML application as an endpoint instead of packaging it in the app.

The goal is to show how easy it is do devops for an AI application.
