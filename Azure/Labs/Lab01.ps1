#Login to Azure Account
Login-AzureRmAccount

$locName = "West Europe" #Azure datacenter location
$rgName = "testrg" #resource group name
$saName = "testsa" #storage account name. This must be all lower case, and a name that is unique across Azure
$saType = "Standard_LRS" #storage account type
$newsaType = "Standard_GRS" #storage account type to which the storage account will be updated.

#View resource groups
Get-AzureRmResourceGroup

#Create resource groups
New-AzureRmResourceGroup -Name $rgName -Location $locName

#Create a storage account
New-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName –Type $saType -Location $locName

#Re-assign storage account to new resource group
Set-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName –Type $newsaType

#Delete storage account
Remove-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName -Force

#View storage accounts
Get-AzureRmStorageAccount

#Delete resource groups
Remove-AzureRmResourceGroup -Name $rgName -Force