$ServerAddress = if ($env:PesterServerAddress -eq $null) { 'localhost:51735' } else { $env:PesterServerUrl }
$PbiDatabase = if ($env:PesterPbiDatabase -eq $null) { '7329df10-417b-47cf-914e-9e2d4c0ed925' } else { $env:PesterPbiDatabase }

$SQLQuery = "; WITH ReportCatalog AS (
    SELECT ItemID -- Unique Identifier
            , [Path] --Path including object name
            , [Name] --Just the objectd name
            , ParentID --The ItemID of the folder in which it resides
            , CASE [Type] --Type, an int which can be converted using this case statement.
                WHEN 1 THEN 'Folder'
                WHEN 2 THEN 'Report'
                WHEN 3 THEN 'File'
                WHEN 4 THEN 'Linked Report'
                WHEN 5 THEN 'Data Source'
                WHEN 6 THEN 'Report Model - Rare'
                WHEN 7 THEN 'Report Part - Rare'
                WHEN 8 THEN 'Shared Data Set - Rare'
                WHEN 9 THEN 'Image'
                WHEN 13 THEN 'PBIX'
                ELSE CAST(Type as varchar(100))
              END AS TypeName
            --, content
            , LinkSourceID --If a linked report then this is the ItemID of the actual report.
            , [Description] --This is the same information as can be found in the GUI
            , [Hidden] --Is the object hidden on the screen or not
            , CreatedBy.UserName CreatedBy
            , CreationDate
            , ModifiedBy.UserName ModifiedBy
            , CTG.ModifiedDate
            , [Type]
    FROM 
      ReportServer.dbo.[Catalog] CTG
        INNER JOIN 
      ReportServer.dbo.Users CreatedBy ON CTG.CreatedByID = CreatedBy.UserID
        INNER JOIN
      ReportServer.dbo.Users ModifiedBy ON CTG.ModifiedByID = ModifiedBy.UserID)
    SELECT b.Name AS [Parent], a.*
      FROM ReportCatalog a
      JOIN ReportCatalog b
        ON a.ParentID = b.ItemID
     WHERE a.[Name] <> 'System Resources' and a.[Path] <> ''
       AND b.[Name] <> 'System Resources' "

Describe "Invoke-DaxQuery" {
    Context "Invoke a DAX Query and test the result"{

      BeforeEach {
        # Run queries and compare them
        $PbiResults = Invoke-DaxQuery -ServerAddress $ServerAddress -Database $PbiDatabase -Query "EVALUATE ReportCatalog"
    }

        It "Should verify the count is correct by comparing against a static number" {
            @($PbiResults).Count | Should -Be 26
        }

        It "Should verify the count is correct by comparing against the results of a SQL Server query" {
            # Run query against SQL Server and compare the results to Analysis Services
            $SQLQueryResults = Invoke-Sqlcmd -ServerInstance localhost -Database ReportServer -Query $SQLQuery

            @($PbiResults).Count | Should -Be @($SQLQueryResults).Count
        }
        
        # Test if the first row of results returned
        It "Should verify the first result (row) return matches static value" {
            $PbiResults[0].'ReportCatalog[Name]' | Should -Be 'Data Sources'
        }        
    }

}    