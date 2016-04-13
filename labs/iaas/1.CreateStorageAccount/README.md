# Create Azure Storage Account

This lab will walk you through creating a Storage Account in Azure. 
First of all, open the [Azure Portal](http://portal.azure.com) or log in through [PowerShell](../0.InstallPowerShell/README.md).

[Create with portal](#using-the-portal)

[Create with PowerShell](#using-powershell)

## Using the portal

When using the portal, go to **New** -> **Data + Storage** -> **Storage Account**:
![storageaccount1](./content/storageaccount1.png)

Make sure it says **Resource Manager** in the *Select a deployment model* dropdown box, and click **Create**:
![storageaccount2](./content/storageaccount2.png)

Here we have to fill out some information:

* Name
    * Name of the Storage Account. This has to be a globally unique name, can only be between 3 and 24 characters, and only accepts lowercase letters and numbers
* Type
    * In Azure we can work different types of storage, which will replicate data differently. For this lab a **Locally Redundant** account will do.
* Diagnostics
    * This will collect performance data about your Storage Account. These data will be stored in your Storage Account and uses a small amount of disk space. The choice is up to you :-)
* Subscription
    * If you have multiple subscriptions, make sure you have chosen the correct here. 
* Resource Group
    * Enter a new name for your Resource Group, for example **Storage**.
* Location
    * Select the location you want to deploy your Storage Account to. This has to be the same location as VMs are deployed in later on.
    
Now click **Create** and wait a minute or two, until your account has been created:
![storageaccount3](./content/storageaccount3.png)


## Using PowerShell

If you prefer PowerShell, you will need to create a new Resource Group:

```powershell
New-AzureRmResourceGroup -Name globalazure -Location "West Europe"

ResourceGroupName : globalazure
Location          : westeurope
ProvisioningState : Succeeded
Tags              : 
ResourceId        : /subscriptions/7bce381f-79b3-4521-b36e-138932735300/resourceGroups/globalazure
```

Next we will create the Storage Account, just like in the portal, we need to give it a name, select a type and a location:

```powershell
New-AzureRmStorageAccount -ResourceGroupName globalazure -Name globalazure12345 -Type Standard_LRS -Location "West Europe"

ResourceGroupName   : globalazure
StorageAccountName  : globalazure12345
Id                  : /subscriptions/7bce381f-79b3-4521-b36e-138932735300/resourceGroups/globalazure/providers/Microsoft.Storage/storageAccount
                      s/globalazure12345
Location            : westeurope
AccountType         : StandardLRS
CreationTime        : 4/13/2016 9:19:39 PM
CustomDomain        : 
LastGeoFailoverTime : 
PrimaryEndpoints    : Microsoft.Azure.Management.Storage.Models.Endpoints
PrimaryLocation     : westeurope
ProvisioningState   : Succeeded
SecondaryEndpoints  : 
SecondaryLocation   : 
StatusOfPrimary     : Available
StatusOfSecondary   : 
Tags                : {}
Context             : Microsoft.WindowsAzure.Commands.Common.Storage.AzureStorageContext
```

