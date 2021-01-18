$ServerAddress = if ($env:PesterServerAddress -eq $null) { 'localhost:52800' } else { $env:PesterServerUrl }
$PbiDatabase = if ($env:PesterPbiDatabase -eq $null) { '2386f85f-23a2-4f03-8870-5a5a79f9ea1c' } else { $env:PesterPbiDatabase }

Describe "Invoke-DaxQuery" {
    Context "Invoke a DAX Query and test the result"{

        BeforeEach {
            # Run query and store results
            $PbiResults = Invoke-DaxQuery -ServerAddress $ServerAddress -Database $PbiDatabase  -Query "EVALUATE(
            SUMMARIZE(Sales, 'Date'[Month], ""Sales Amount"", SUM(Sales[Sales Amount]))
            )
            ORDER BY 'Date'[Month] DESC"
        }    

        It "Should verify the count is correct by comparing against a static number" {
            @($PbiResults).Count | Should -Be 36
        }

        It "Should verify the [Sales Amount] is correct by comparing against a static number stored" {
            $PbiResults.where({ $_.'Date[Month]' -eq '2020 May' }).'[Sales Amount]' | Should -Be 5265796.6845
        }

        It "Should verify the first Date[Month] is correct by comparing against a static value" {
            $PbiResults[0].'Date[Month]' | Should -Be '2020 May'
        }
 
    }

}

Describe "Invoke-DaxQuery_FromFile" {
    Context "Invoke a DAX Query and test the result"{

        BeforeEach {
            [string]$DaxQuery = Get-Content .\Sales_TableExample.dax
            # Run query and store results
            $PbiResults2 = Invoke-DaxQuery -ServerAddress $ServerAddress -Database $PbiDatabase  -Query $DaxQuery
        }    

        # Test if the config was retrieved
        It "Should verify the count is correct by comparing against a static number" {
            @($PbiResults2).Count | Should -Be 36
        }

        # Test if the config was retrieved
        It "Should verify the [Sales Amount] is correct by comparing against a static number stored" {
            $PbiResults2.where({ $_.'Date[Month]' -eq '2020 May' }).'[Sales Amount]' | Should -Be 5265796.6845
        }

        # Test if the config was retrieved
        It "Should verify the first Date[Month] is correct by comparing against a static value" {
            $PbiResults2[0].'Date[Month]' | Should -Be '2020 May'
        }
 
    }

}