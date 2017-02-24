#Login to Azure Account
Login-AzureRmAccount

$locName = "West Europe" #Azure datacenter location
$rgName = "testrg3" #resource group name
$vNetName = "testvNet" #vNet name.
$addPrefix = '10.0.0.0/16' #vNet Address prefix. Make sure this does not overlap any range in your on-premises datacenter
$subnetFE = 'FrontEnd'
$subnetFEPrefix = '10.0.10.0/24'
$subnetBE = 'Backend'
$subnetBEPrefix = '10.0.20.0/24'

#View virtual networks
Get-AzureRmVirtualNetwork -Name $vNetName -ResourceGroupName $rgName

#Create virtual network
New-AzureRmVirtualNetwork -ResourceGroupName $rgName -Name $vNetName -AddressPrefix $addPrefix -Location $locName -Force

#Store vNet in a variable
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $rgName -Name $vNetName

#Add new FrontEnd subnet to the vNet
Add-AzureRmVirtualNetworkSubnetConfig -Name $subnetFE -VirtualNetwork $vnet -AddressPrefix $subnetFEPrefix

#Add new BackEnd subnet to the vNet
Add-AzureRmVirtualNetworkSubnetConfig -Name $subnetBE -VirtualNetwork $vnet -AddressPrefix $subnetBEPrefix

#Configure the vNet
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
