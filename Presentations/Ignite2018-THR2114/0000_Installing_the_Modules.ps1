<# Installing the modules from the PowerShell Gallery
    NOTE: You should do this from an elevated PowerShell session.
          (right-click -> Run as Administrator) #>
Install-Module -Name SqlServer -Force

Install-Module -Name ReportingServicesTools 

<# You need to check every once in a while to see if a new version is available. #>
Update-Module -Name SqlServer -WhatIf

Update-Module -Name SqlServer


<# This will help you find the commands available in each module #>
Get-Command -Module SqlServer -Noun *Job*

Get-Command -Module SqlServer | Out-GridView


Get-Command -Module SqlServer | Out-GridView -PassThru |
Get-Help -Full

