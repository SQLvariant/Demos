Describe "Invoke-DaxQuery" {
    Context "Invoke a DAX Query and test the result"{

        BeforeEach {
            $results = Invoke-DaxQuery -ServerAddress 'localhost:51735' -DatabaseName '7329df10-417b-47cf-914e-9e2d4c0ed925' -Query "EVALUATE ReportCatalog"
        }

        It "Should verify the count is correct by comparing against a static number" {
        # Run queries and compare its .count to a previously known value
            @($results).Count | Should -Be 37
        }
        
        # Test if the first row of results returned
        It "Should verify the first result (row) return matches static value" {
            $results[0].'ReportCatalogQuery[Name]' | Should -Be 'Data Sources'
        }        
    }
}