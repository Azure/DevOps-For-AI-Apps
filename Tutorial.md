# DevOps for AI applications: Creating Continous Integration (CI)/ Continous Delivery (CD) pipeline using Visual Studio Team Services (VSTS), Azure Kubernetes Service (AKS) and Azure Container Registry (ACR).

This tutorial demonstrates how to implement a CI/CD pipeline for an AI application. AI application is a combination of Application code embedded with a pretrained ML model. For this tutorial we are fetching a pre-trained model from a private Azure blob storage account, it could be a AWS S3 account as well.

We will use a simple python flask application, which is available on GitHub <add link here>.
  
## Introduction

At the end of this tutorial, we will have a pipeline for our AI application that picks the latest commit from GitHub repository and the latest pre-trained machine learning model from the Azure Storage container, stores the image in a private image repository on ACR and deploys it on a Kubernetes cluster running on AKS.

![Architecture](images/Architecture.PNG?raw=true)

1. Developer work on the IDE of their choice on the application code.
2. They commit the code to source control of their choice (VSTS has good support for various source controls)
3. Separately, Data scientist work on developing their model.
4. Once happy they publish the model to a model repository, in this case we are using blob storage account. This could be easily replaced with Azure ML Workbench's Model management service through their REST APIs.
5. A build is kicked off in VSTS based on the commit in GitHub.
6. VSTS Build pipeline pulls the latest model from Blob container and creates a container.
7. VSTS pushes the image to private image repository in Azure Container Registry
8. On a set schedule (nightly), release pipeline is kicked off.
9. Latest image from ACR is pulled and deployed across Kubernetes cluster on AKS.
10. Users request for the app goes through DNS server.
11. DNS server passes the request to load balancer and sends the response back to user.

## Prerequisites
* [Visual Studio Team Services Account](https://docs.microsoft.com/en-us/vsts/accounts/create-account-msa-or-work-student)
* [Azure CLI] (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
* [Azure Kubernetes Service (AKS) cluster] (https://docs.microsoft.com/en-us/azure/container-service/kubernetes/container-service-kubernetes-walkthrough)
* [Azure Container Registy (ACR) account] (https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-portal)
* [Install Kubectl to run commands against Kubernetes cluster.](https://kubernetes.io/docs/tasks/tools/install-kubectl/) We will need this to fetch configuration from AKS cluster. 
* Fork the repository to your GitHub account.

## Creating VSTS Build Definition

Go to the VSTS account that you created as part of the prereqs. You can find the URL for the VSTS account from Azure Portal under overview of your team account.

On the landing page, click on the new project icon to create a project for your work.

![VSTS New Project](images/vsts-newproject.PNG?raw=true)

Go to your project homepage and click on "Build and Releases tab" from the menu. To create a new Build Definition click on the  "+ New" icon on top right. 

![VSTS New Build Definition](images/vsts-newbuilddef.PNG?raw=true)

We will start from an empty process and add tasks for our build process. Notice here that VSTS provides some well definied build definition process for commonly used stack like ASP .Net

![VSTS Empty Process Definition](images/vsts-emptyprocess.PNG?raw=true)

Name your build definition and select a agent from the agent queue, we select Hosted Linux queue since our app is Linix based and we want to run some Linux specific command in further steps. When you queue a build, VSTS provides you an agent to run your build definition on.

![VSTS Empty Process Definition](images/vsts-build-agentselection.PNG?raw=true)

Under Get-Sources option, you can link the VSTS Build to source control of your choice. In this tutorial we are using GitHub, you can authorize VSTS to access your repository and then select it from the drop down. You can also select the branch that you want to build your app from, we select master.

![VSTS Get Sources Task Definition](images/vsts-task-getsources.PNG?raw=true)

You want to kick off a new build each time there ia new checkin to the repository, to do so you can go to the trigger tab and enable continous integration. You can again select which branch you want to build off from.

![VSTS CI Build Trigger](images/vsts-build-trigger.PNG?raw=true)

At this point we have the build definition to triggered to run on a linux agent for each commit to the repository. Let's start with adding tasks to build container for our app.

As first task we want to download the pre-trained model to the VSTS agent that we are building on, we are using a simple shell script to download the blob. Add Shell Script vsts task to execute the script.

![VSTS Docker Task](images/vsts-sshtask.PNG?raw=true)

Add the path to the script, in the arguments section pass in the value for your storage account name, access key, container name and blob names (model name and sysnet file).

![VSTS Docker Task](images/vsts-sshtaskdetails.PNG?raw=true)

Add a Docker task to run docker commands. We will use this task to build container for our AI application. We are using Dockerfile that contains all the commands to assemble an image. 

![VSTS Docker Task](images/vsts-dockertask.PNG?raw=true)

Within the Docker task, give it a name










