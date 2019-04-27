#Install-Module ImportExcel
<# The ImportExcel module is maintained by PowerShell MVP Doug Finke @dfinke on twitter #>

,(Import-Excel -Path C:\temp\Excel\SysTables_AdventureWorks2014.xlsx) |
Write-SqlTableData -ServerInstance localhost\SQL2017 -Database BlankDB -SchemaName dbo -TableName MyNewTable_fromExcel -Force


,(Import-Excel -Path C:\temp\Excel\SysColumns_AdventureWorks2014.xlsx) |
Write-SqlTableData -ServerInstance localhost\SQL2017 -Database BlankDB -SchemaName dbo -TableName MyOtherNewTable_fromExcel -Force
