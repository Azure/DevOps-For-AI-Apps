
# begin
# Update with the name of your subscription.
$SubscriptionName = "Marketing Automation"

# Give a name to your new storage account. It must be lowercase!
$StorageAccountName = "devopsblogstorage"

$ResourceGroup = "rijaiblog"

# Choose "West US" as an example.
$Location = "East US 2"

# Give a name to your new container.
$ContainerName = "pretrainedmodel"

$DestinationFolder = $env:System_DefaultWorkingDirectory
Write-Host $DestinationFolder

# Add your Azure account to the local PowerShell environment.
# Add-AzureAccount

# Set a default Azure subscription.
#Select-AzureSubscription -SubscriptionName $SubscriptionName
# Get-AzureRmSubscription –SubscriptionName $SubscriptionName | Select-AzureRmSubscription

Set-AzureRmCurrentStorageAccount –ResourceGroupName $ResourceGroup –StorageAccountName $StorageAccountName


# Set a default storage account.
#Set-AzureSubscription -CurrentStorageAccountName $StorageAccountName -SubscriptionName $SubscriptionName

# List all blobs in a container.
#Get-AzureStorageBlob -Container $ContainerName

# Download blobs from the container:
# Get a reference to a list of all blobs in a container.
$blobs = Get-AzureStorageBlob -Container $ContainerName

# Create the destination directory.
New-Item -Path $DestinationFolder -ItemType Directory -Force  

# Download blobs into the local destination directory.
$blobs | Get-AzureStorageBlobContent –Destination $DestinationFolder

# end
