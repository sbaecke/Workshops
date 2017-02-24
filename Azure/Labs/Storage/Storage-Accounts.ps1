#Login to Azure Account
Login-AzureRmAccount

$locName = "West Europe" #Azure datacenter location
$rgName = "testrg2" #resource group name
$saName = "testsa" #storage account name. This must be all lower case, and a name that is unique across Azure
$saType = "Standard_LRS" #storage account type
$newsaType = "Standard_GRS" #storage account type to which the storage account will be updated.

#View resource groups
Get-AzureRmResourceGroup

#Create resource group
New-AzureRmResourceGroup -Name $rgName -Location $locName

#View storage accounts
Get-AzureRmStorageAccount | Select StorageAccountName,ResourceGroupName,Location

#Create a storage account
New-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName –Type $saType -Location $locName

#Re-assign storage account to new resource group
Set-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName –Type $newsaType

#Delete storage account
Remove-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName -Force
