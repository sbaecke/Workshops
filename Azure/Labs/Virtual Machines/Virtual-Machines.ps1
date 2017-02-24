#Login to Azure Account
Login-AzureRmAccount

$locName = "West Europe" #Azure datacenter location
$rgName = "testrg4" #resource group name
$vNetName = "testvNet4" #vNet name.
$addPrefix = '10.0.0.0/16' #vNet Address prefix. Make sure this does not overlap any range in your on-premises datacenter
$subnetFE = 'FrontEnd'
$subnetFEPrefix = '10.0.10.0/24'
$vmName = 'testrg4vm'
$vmSize = 'Standard_DS1_v2'

#View resource groups
Get-AzureRmResourceGroup -Name $rgName

#Create resource group
New-AzureRmResourceGroup -Name $rgName -Location $locName

#Add new FrontEnd subnet to the vNet
$feSubnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetFE -AddressPrefix $subnetFEPrefix

#Create the vNet
$myVnet = New-AzureRmVirtualNetwork -Name $vNetName -ResourceGroupName $rgName -Location $locName -AddressPrefix $addPrefix -Subnet $feSubnet

#Create public IP Address
$myPublicIp = New-AzureRmPublicIpAddress -Name "myPublicIp" -ResourceGroupName $rgName -Location $locName -AllocationMethod Dynamic

#Create network interface
$myNIC = New-AzureRmNetworkInterface -Name "myNIC" -ResourceGroupName $rgName -Location $locName -SubnetId $myVnet.Subnets[0].Id -PublicIpAddressId $myPublicIp.Id

#Credentials for the new VM
$cred = Get-Credential -Message "Type the name and password of the local administrator account."

#Create the VM object
$myVM = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize

#Configure Operating System settings
$myVM = Set-AzureRmVMOperatingSystem -VM $myVM -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate

#Define image to use
$myVM = Set-AzureRmVMSourceImage -VM $myVM -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2012-R2-Datacenter" -Version "latest"

#Add network interface
$myVM = Add-AzureRmVMNetworkInterface -VM $myVM -Id $myNIC.Id

#Create the managed disk
$myVM = Set-AzureRmVMOSDisk -VM $myVM -Name "myOsDisk1" -StorageAccountType PremiumLRS -DiskSizeInGB 128 -CreateOption FromImage -Caching ReadWrite

#Create the VM
New-AzureRmVM -ResourceGroupName $rgName -Location $locName -VM $myVM





