Get-SqlInstance -ServerInstance localhost\SQL2017


DIR 'SQLSERVER:\SQLRegistration\Database Engine Server Group' |
Foreach {
Get-SqlInstance -ServerInstance $_.Name
}

<# Let's check on of the Configuration Options of that instance #>
$SQL2017 = Get-SqlInstance -ServerInstance localhost\sql2017
$SQL2017.Configuration.Properties | sort DisplayName | Format-Table -AutoSize

<# What if we want to check just one property #>
$SQL2017.Configuration.Properties | 
WHERE {$_.DisplayName -eq 'max server memory (MB)'}


<# Now let's check that one property on all of our instances: #>
#DIR 'SQLSERVER:\SQLRegistration\Database Engine Server Group' |
#Foreach {
#Get-SqlInstance -ServerInstance $_.Name | 
#WHERE {$_.DisplayName -eq 'max server memory (MB)'} |
#Format-Table -AutoSize
#}


$SQL2017.Configuration.Properties | 
WHERE {$_.DisplayName -eq 'max server memory (MB)'}


<# Another option for filtering that may be faster for you: #>
($SQL2017.Configuration.Properties).Where({$_.DisplayName -eq 'max server memory (MB)'})



<# Change Database Owner #>
<# This doesn't work because .Owner is ReadOnly. #>
$Databases = Get-SqlDatabase -ServerInstance localhost\SQL2017 |
WHERE {$_.owner -ne 'sa'}

foreach ($db in $Databases)
{
"$($db.owner)";
$db.owner = 'sa';
$db.Alter()
}