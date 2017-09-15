$SubscriptionName = "Marketing Automation"
$StorageAccountName = "devopsblogstorage"
$Location = "East US 2"
$ContainerName = "pretrainedmodel"
$DestinationFolder = $env:System_DefaultWorkingDirectory
Set-AzureSubscription -CurrentStorageAccountName $StorageAccountName -SubscriptionName $SubscriptionName
Get-AzureStorageBlob -Container $ContainerName
$blobs = Get-AzureStorageBlob -Container $ContainerName
New-Item -Path $DestinationFolder -ItemType Directory -Force  
$blobs | Get-AzureStorageBlobContent –Destination $DestinationFolder -Force
