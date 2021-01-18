<# Workspaces which have been deleted #>
Get-PowerBIWorkspace -Scope Organization -All -Orphaned


<# the 'My Workspace' of user accounts which have been deleted / removed #>
Get-PowerBIWorkspace -Scope Organization -All |
WHERE { $_.Name -eq 'PersonalWorkspace Of Anonymized User' }

<# Workspaces which have been deleted #>
Get-PowerBIWorkspace -Scope Organization -Deleted -All


<##################################################################################################>
<# Export results to Excel (requires the ImportExcel module from PowerShell Gallery) #>

<# Workspaces which have been deleted #>
Get-PowerBIWorkspace -Scope Organization -Deleted -All |
Export-Excel -Path c:\temp\Orphaned_Workspaces.xlsx -WorksheetName DeletedWorkspaces

<# Workspaces which have been deleted #>
Get-PowerBIWorkspace -Scope Organization -Deleted -All |
Get-PowerBIDataset -Scope Organization |
Export-Excel -Path c:\temp\Orphaned_Workspaces.xlsx -WorksheetName DatasetsIn_DeletedWorkspaces

<# Datasets within Workspaces which have been Orphaned #>
Get-PowerBIWorkspace -Scope Organization -All -Orphaned |
Export-Excel -Path c:\temp\Orphaned_Workspaces.xlsx -WorksheetName Workspaces

<# Datasets within Workspaces which have been deleted #>
Get-PowerBIWorkspace -Scope Organization -All -Orphaned |
Get-PowerBIDataset -Scope Organization |
Export-Excel -Path c:\temp\Orphaned_Workspaces.xlsx -WorksheetName DatasetsIn_Workspaces

<# the 'My Workspace' of user accounts which have been deleted / removed #>
Get-PowerBIWorkspace -Scope Organization -All |
WHERE { $_.Name -eq 'PersonalWorkspace Of Anonymized User' } |
SELECT -Property $_.Id, $_.Name, $_.IsReadOnly, $_.IsOnDedicatedCapacity, $_.CapacityId, $_.Description, $_.Type, $_.State, $_.IsOrphaned, $_.Users

Export-Excel -Path c:\temp\Orphaned_Workspaces.xlsx -WorksheetName MyWorkspaces

<# Datasets in those 'My Workspace's #>
Get-PowerBIWorkspace -Scope Organization -All |
WHERE { $_.Name -eq 'PersonalWorkspace Of Anonymized User' } |
Get-PowerBIDataset -Scope Organization |
Export-Excel -Path c:\temp\Orphaned_Workspaces.xlsx -WorksheetName DatasetsIn_MyWorkspaces -Show

<##################################################################################################>
<# Restore Workspace
To view deleted workspaces as a tenant administrator: #>

Get-PowerBIWorkspace -Scope Organization -Deleted -All

#Restores a deleted workspace:
Restore-PowerBIWorkspace -Id "3244f1c1-01cf-457f-9383-6035e4950fdc" -RestoredName "TestWorkspace" -AdminEmailAddress "john@contoso.com"

<# Recover orphaned workspaces
A workspace becomes orphaned when it has no assigned administrators. If you are a tenant administrator, run the following to view all orphaned workspaces: #>

Get-PowerBIWorkspace -Scope Organization -Orphaned -All

#To correct this issue, use:
Add-PowerBIWorkspaceUser -Scope Organization -Id f2a0fae5-1c37-4ee6-97da-c9d31851fe17 -UserPrincipalName 'john@contoso.com' -AccessRight Admin