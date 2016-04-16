# Install Azure Resource Manager PowerShell

To install Azure Resource Manager PowerShell, run the following commands in an elevated PowerShell session:
```powershell
Install-Module AzureRM
Install-AzureRM
``` 

*Note: This requires Windows Management Framework 5, which is included in Windows 10.*


To log in to Azure through PowerShell, use the following command:

```powershell
Login-AzureRmAccount
```

This will open a login window, where you enter your credentials to Azure. 