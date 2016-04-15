Configuration DSCWebServer
{
    param(
        $machineName
    )
    Node $machineName
    {
        WindowsFeature IIS
        {
            Ensure = "Present"
            Name = "Web-Server"
        }

        WindowsFeature IISMgmtTools
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Tools"
        }
    }
}