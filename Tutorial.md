# DevOps for AI applications: Creating Continous Integration (CI)/ Continous Delivery (CD) pipeline using Visual Studio Team Services (VSTS), Azure Kubernetes Service (AKS) and Azure Container Registry (ACR).

This tutorial demonstrates how to implement a CI/CD pipeline for an AI application. AI application is a combination of Application code embedded with a pretrained ML model. For this tutorial we are fetching a pre-trained model from a private Azure blob storage account, it could be a AWS S3 account as well.

We will use a simple python flask application, which is available on GitHub <add link here>.
  
## Introduction

At the end of this tutorial, we will have a pipeline for our AI application that picks the latest commit from GitHub repository and the latest pre-trained machine learning model from the Azure Storage container, stores the image in a private image repository on ACR and deploys it on a Kubernetes cluster running on AKS.

![Architecture](images/Architecture.png?raw=true)


