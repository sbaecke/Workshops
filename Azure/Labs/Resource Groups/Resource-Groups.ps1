#Login to Azure Account
Login-AzureRmAccount

$locName = "West Europe" #Azure datacenter location
$rgName = "testrg1" #resource group name

#View resource groups
Get-AzureRmResourceGroup

#Create resource group
New-AzureRmResourceGroup -Name $rgName -Location $locName

#View resource providers
Get-AzureRmResourceProvider -Location $locName -ListAvailable | Select ProviderNameSpace,RegistrationState | Sort ProviderNameSpace

#Delete resource groups
Remove-AzureRmResourceGroup -Name $rgName -Force