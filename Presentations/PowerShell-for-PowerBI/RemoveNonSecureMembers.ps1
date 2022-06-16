#Import-module MicrosoftPowerBIMgmt
Connect-PowerBIServiceAccount -Environment #<Azure Environment>

#Import-Module AzureAD -UseWindowsPowerShell
Connect-AzureAD -AzureEnvironmentName #<Azure Environment>

#objectid =  (Get-AzureADGroup -SearchString <"Group Name">).ObjectId

$workspaces = (Get-PowerBIWorkspace).Id

ForEach($workspace in $workspaces) {
    $url =  $workspace | ForEach-Object {"https://api.high.powerbigov.us/v1.0/myorg/admin/groups/" + $_ + "/users"}
    $invoke = $url | ForEach-Object {Invoke-PowerBIRestMethod -Method GET -Url $_ } | ConvertFrom-Json
    $member = $invoke.value.emailAddress| Sort-Object -Unique
    $securityMember = (Get-AzureADGroupMember -ObjectId $objectid).UserPrincipalName
    $removeMembers = $member | Where-Object { $_ –ne $securityMember }
    $removeMembers | ForEach-Object{Remove-PowerBIWorkspaceUser -Id $workspace -UserPrincipalName $_}

}
