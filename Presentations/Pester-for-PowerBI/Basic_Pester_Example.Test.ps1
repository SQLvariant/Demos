Describe "Basic_Pester" {
    Context "Add numbers and test the results"{
        
        It "Should verify the count is correct by comparing against a static number" {
            2+34 | Should -Be 36
        }
        
        $a =2; $b = 34

        It "Should verify the first result (row) return matches static value" {
            $a + $b | Should -Be 36
        }        
    }

}