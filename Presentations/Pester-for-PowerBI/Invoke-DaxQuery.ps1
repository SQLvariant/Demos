<# This install step only needs to be run once per machine.
    Uncomment it, run it, and then comment it back.
    NOTE: Make sure to find out the version of the NuGet package from the $install.Payload.Directories[0].Name variable 
          and update the LoadAdomdNet function with the version you downloaded.
    #>
##install and load adomdnet if needed
#function InstallAndLoadAdomdNet {
#    "Installing ADOMD.NET"
#    $null = Register-PackageSource -Name nuget.org -Location http://www.nuget.org/api/v2 -Force -Trusted -ProviderName NuGet;
#    $install = Install-Package Microsoft.AnalysisServices.AdomdClient.retail.amd64 -ProviderName NuGet -Force;
#    $dllPath = $install.Payload.Directories[0].Location + "\" + $install.Payload.Directories[0].Name + "\lib\net45\Microsoft.AnalysisServices.AdomdClient.dll";
#    $bytes = [System.IO.File]::ReadAllBytes($dllPath)
#    return [System.Reflection.Assembly]::Load($bytes)
#}
function LoadAdomdNet {
    "Load ADOMD.NET"
    #You need to make sure the amd64.19.12.7 version matches the version you installed in the step above
    $dllPath = "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.AnalysisServices.AdomdClient.retail.amd64.19.16.0\lib\net45\Microsoft.AnalysisServices.AdomdClient.dll";
    #$dllPath = "C:\Program Files\PackageManagement\NuGet\Packages\$($install.Payload.Directories[0].Name)\lib\net45\Microsoft.AnalysisServices.AdomdClient.dll";
    $bytes = [System.IO.File]::ReadAllBytes($dllPath)
    return [System.Reflection.Assembly]::Load($bytes)
}
function Invoke-DaxQuery
{
    [CmdletBinding()]
    param(
    #input the DAX query here that should run against the endpoint
    [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
    [string]
    $Query = 'SELECT [catalog_name] as [Database Name] FROM $SYSTEM.DBSCHEMA_CATALOGS',

    #database and server details
    [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
    [string]
    $DatabaseName,

    [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
    [string]
    $ServerAddress,

    #output location
    [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
    [string]
    $outputFolder = "C:\temp\Power BI\",

    [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
    [string]
    $OutputName

    )
    #compile the final output filepath including the filename
    $outFile = "$OutputFolder\$OutputName.csv"

    #install and load adomdnet if needed
    if ($assembly -eq $null)
    {
        $assembly = LoadAdomdNet;
    }
    
    #create the Analysis Services connection object
    $conn = New-Object -TypeName Microsoft.AnalysisServices.AdomdClient.AdomdConnection;
    $conn.ConnectionString = "Provider=MSOLAP;Initial Catalog=$DatabaseName;Data Source=$ServerAddress;MDX Compatibility=1;Safety Options=2;MDX Missing Member Mode=Error;Update Isolation Level=2"
    $conn.Open();

    #create the AS command
    $cmd = New-Object -TypeName Microsoft.AnalysisServices.AdomdClient.AdomdCommand;
    $cmd.Connection = $conn;
    $cmd.CommandTimeout = 600;
    $cmd.CommandText = $Query

    #fill a dataset object with the result of the cmd
    $da = new-Object Microsoft.AnalysisServices.AdomdClient.AdomdDataAdapter($cmd)
    $ds = new-Object System.Data.DataSet
    $rowCount = $da.Fill($ds)
    
    #close your connection
    $conn.Close();
    $conn = $null;

    #export the result set as a csv
    return @($ds.Tables[0]) 
#    Export-Csv -Path $outFile -NoTypeInformation
}