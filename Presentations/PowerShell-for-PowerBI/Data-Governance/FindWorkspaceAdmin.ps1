#Login to Power BI GCCH
Connect-PowerBIServiceAccount

#Create a table to hold final data
$table = New-Object system.Data.DataTable 'Workspace Admin'
$newcol = New-Object system.Data.DataColumn Workspace,([string]); $table.columns.add($newcol)
$newcol = New-Object system.Data.DataColumn Admin,([string]); $table.columns.add($newcol)

#Get list of workspaces (not Group or Personal Workspaces) 
$workspaces = (Get-PowerBIWorkspace -Scope Organization -Type Workspace)

ForEach($workspace in $workspaces) {
  #filter out only Admins
  $user= $workspaces.users | where-object -Property AccessRight -eq "Admin"
  
  #Add admins to the table
  ForEach($user in $workspace.Users) {
    ForEach-Object {
        $row = $table.NewRow()
        $row.Workspace= ($workspace.Name)
        $row.Admin= ($user.UserPrincipalName)
        $table.Rows.Add($row)
        }
}} 

#Print out table view
$table