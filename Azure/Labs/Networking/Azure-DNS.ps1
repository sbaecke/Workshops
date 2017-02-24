#Login to Azure Account
Login-AzureRmAccount

$locName = "West Europe" #Azure datacenter location
$rgName = "testrg1" #resource group name
$dnsZone = 'cloud.platanidemo.nl'

#Get current DNS zones
Get-AzureRmDnsZone -ResourceGroupName $rgName

#New DNS Zone
New-AzureRmDnsZone -Name $dnsZone -ResourceGroupName $rgName

#Get DNS Zone records
Get-AzureRmDnsRecordSet -ZoneName $dnsZone -ResourceGroupName $rgName

#Create new DNS recordset
New-AzureRmDnsRecordSet -Name 'portal' -RecordType "A" -ZoneName $dnsZone -ResourceGroupName $rgName -Ttl 3600 -DnsRecords (New-AzureRmDnsRecordConfig -IPv4Address '10.0.20.99')

#Resolve DNS record
Resolve-DnsName -Server 'ns1-01.azure-dns.com' -Name "portal.$dnsZone"
