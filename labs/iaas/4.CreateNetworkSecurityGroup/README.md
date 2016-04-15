# Create Network Security Group

This lab will walk you through creating a Network Security Group, adding a rule to it, and assigning it to af VM.

[Create with portal](#using-the-portal)

[Create with PowerShell](#using-powershell)

## Using the portal



## Using PowerShell

First we need to create a *rule configuration*. This contains a rule with all the settings we want it to. The following command will allow port 3389/tcp from Internet to the VM, and the rule will have a priority of 100:

```powershell
$rule = New-AzureRmNetworkSecurityRuleConfig -Name "rdp" -Description "Allow RDP" -Protocol Tcp -SourcePortRange * -DestinationPortRange "3389" -SourceAddressPrefix Internet -DestinationAddressPrefix * -Access Allow -Priority 100 -Direction Inbound
```

Next we will assign this rule to a new Network Security Group:

```powershell
$nsg = New-AzureRmNetworkSecurityGroup -Name "DemoNSG" -ResourceGroupName "globalazure" -Location "West Europe" -SecurityRules $rule
```

Note that we can assign multiple rules to a Network Security Group at once, but specifying more rules on the *-SecurityRules* parameter, for example:
```powershell
$nsg = New-AzureRmNetworkSecurityGroup -Name "DemoNSG" -ResourceGroupName "globalazure" -Location "West Europe" -SecurityRules $rule1,$rule2,$rule3
``` 

Now we need to attach the NSG to our network interface. To list all available interfaces, run:
```powershell
Get-AzureRmNetworkInterface -ResourceGroupName "globalazure"
```

In the list, find the one attached to your VM, and run:
```powershell
$nic = Get-AzureRmNetworkInterface -Name <NIC NAME> -ResourceGroupName "globalazure"
```

Then run this command to attach the NSG:
```powershell
$nic.NetworkSecurityGroup = $nsg
```

And the following command to commit the changes to Azure:
```powershell
Set-AzureRmNetworkInterface -NetworkInterface $nic
```
