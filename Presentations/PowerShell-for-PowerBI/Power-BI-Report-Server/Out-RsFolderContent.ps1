
Get-RsFolderContent -ReportServerUri $SSRSInstance -Path / | Format-Table -Property Name, Path, TypeName -AutoSize

Out-RsCatalogItem -ReportServerUri $SSRSInstance -RsItem /SimpleEmployeeReport -Destination C:\temp\PBIRSReports

Get-RsCatalogItems -ReportServerUri $SSRSInstance -Path / | %{
Out-RsCatalogItem -ReportServerUri $SSRSInstance -RsItem /SimpleEmployeeReport -Destination C:\temp\PBIRSReports
Out-RsCatalogItem -ReportServerUri $SSRSInstance -RsItem $_ -Destination C:\temp\PBIRSReports
}

Get-RsCatalogItems -ReportServerUri $SSRSInstance -RsFolder ''
Out-RsCatalogItem -ReportServerUri $SSRSInstance -RsItem /SimpleEmployeeReport -Destination C:\temp\PBIRSReports


Out-RsCatalogItem -ReportServerUri $SSRSInstance -RsItem '/SQL Server Performance Dashboard/performance_dashboard_main' -Destination C:\temp\PBIRSReports

<# How to Export Every Report in a Folder #>
Out-RsFolderContent -ReportServerUri $SSRSInstance -RsFolder '/SQL Server Performance Dashboard' -Destination C:\temp\PBIRSReports


Get-RsFolderContent -ReportServerUri http://localhost/ReportServer -RsItem '/SQL Server Performance Dashboard' |
WHERE Name -Like Wait* | 
Out-RsCatalogItem -ReportServerUri http://localhost/ReportServer -Destination C:\temp\PBIRSReports
