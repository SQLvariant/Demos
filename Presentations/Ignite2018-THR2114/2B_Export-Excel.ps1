Invoke-Sqlcmd -ServerInstance localhost\SQL2017 -Database AdventureWorks2014 -Query "select *  from sys.tables" -OutputAs DataRows |
Export-Excel -Path c:\temp\SysTables_AdventureWorks2014.xlsx -WorksheetName Tables

Invoke-Sqlcmd -ServerInstance localhost\SQL2017 -Database AdventureWorks2014 -Query "select *  from sys.columns" -OutputAs DataRows |
Export-Excel -Path c:\temp\SysTables_AdventureWorks2014.xlsx -WorksheetName Columns -Show
