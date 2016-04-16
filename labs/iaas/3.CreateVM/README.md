# Create Virtual Machine

This lab will guide you through creating a Windows VM in Azure.

[Create with portal](#using-the-portal)

[Create with PowerShell](#using-powershell)

## Using the portal



## Using PowerShell

Before creating the VM, we will create a Network Interface and a Public IP address for us to reach the VM on.
The Public IP is created with this command:
```powershell
$vmName = "name of virtual machine" #for example "web01"
$pip = New-AzureRmPublicIpAddress -Name ($vmName + "pip") -ResourceGroupName "globalazure" -Location "West Europe" -AllocationMethod Dynamic
```
*By using **($vmName + "pip")** we will end up with an IP address named web01-pip, if we name our VM web01.*

To connect the Network Interface we are about to create, we will first need for find the ID of our subnet. The easiest way to do this is by getting the network:
```powershell
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName "globalazure" -Name <VIRTUAL NETWORK NAME> #If you follow the lab before this one, the name should be vnet01
```

Next create a Network Interface. This command will assign the Public IP we just created to a new Network Interface:
```powershell
$nic = New-AzureRmNetworkInterface -Name ($vmName + "nic" -ResourceGroupName "globalazure" -Location "West Europe" -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id
```

Now for the VM! First we need to specify credentials for the VM. The username can **not** be *admin* or *administrator* !

```powershell
$cred = Get-Credential -Message "Type the name and password of the local administrator account."
```

Next we create a VM configuration object. This is just for us to work with offline, nothing is submitted to Azure yet. 
Specify machine name in the $vmName variable:

```powershell
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize "Standard_A1" 
```
*See [this list](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-sizes/) for more VM sizes*

Here we add our credential to the $vm object, and specify Windows as the Operating System, and enable Automatic Windows Update: 

```powershell
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
```

Now we will choose our Windows version. To see a list of commonly used operating systems and versions, see [this list](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-cli-ps-findimage/).

```powershell
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2012-R2-Datacenter -Version "latest"
```

Then add the Network Interface we created in the beginning, to your configuration:

```powershell
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
```

Select where to store the VHD. The default container to use is /vhds in your storage account. Start by getting the storage account you created earlier:

```powershell
$storageAcc = Get-AzureRmStorageAccount -ResourceGroupName globalazure -Name <NAME OF YOUR STORAGE ACCOUTN>
```

Then we create the path and add it to our configuration:

```powershell
$osDiskUri = $storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $vmName + "-os.vhd"
$vm = Set-AzureRmVMOSDisk -VM $vm -Name ($vmName + "os" -VhdUri $osDiskUri -CreateOption fromImage
```

Finally we can create our VM, by submitting our $vm configuration to Azure:

```powershell
New-AzureRmVM -ResourceGroupName "globalazure" -Location "West Europe" -VM $vm
```
