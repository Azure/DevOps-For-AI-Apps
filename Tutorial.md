# DevOps for AI applications: Creating Continous Integration (CI)/ Continous Delivery (CD) pipeline using Visual Studio Team Services (VSTS), Azure Kubernetes Service (AKS) and Azure Container Registry (ACR).

This tutorial demonstrates how to implement a CI/CD pipeline for an AI application. AI application is a combination of Application code embedded with a pretrained ML model. For this tutorial we are fetching a pre-trained model from a private Azure blob storage account, it could be a AWS S3 account as well.

We will use a simple python flask application, which is available on GitHub <add link here>.
  
## Introduction

At the end of this tutorial, we will have a pipeline for our AI application that picks the latest commit from GitHub repository and the latest pre-trained machine learning model from the Azure Storage container, stores the image in a private image repository on ACR and deploys it on a Kubernetes cluster running on AKS.

![Architecture](images/Architecture.PNG?raw=true)

1. Developer work on the IDE of their choice on the application code.
2. They commit the code to source control of their choice (VSTS has good support for various source controls)
3. Separately, Data scientist work on developing their model.
4. Once happy they publish the model to a model repository, in this case we are using blob storage account.
5. A build is kicked off in VSTS based on the commit in GitHub.
6. VSTS Build pipeline pulls the latest model from Blob container and creates a container.
7. VSTS pushes the image to private image repository in Azure Container Registry
8. On a set schedule (nightly), release pipeline is kicked off.
9. Latest image from ACR is pulled and deployed across Kubernetes cluster on AKS.
10. Users request for the app goes through DNS server.
11. DNS server passes the request to load balancer and sends the response back to user.

## Prerequisites
* A VSTS account
* An AKS cluster
* Azure Container Registy account
* 

