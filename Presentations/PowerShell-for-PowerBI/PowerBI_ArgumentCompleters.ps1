<# We need an argument completer for -Workspace #>
Register-ArgumentCompleter -ParameterName Workspace -ScriptBlock {
    Get-PowerBIWorkspace | ForEach-Object {
    $CompletionText = $_.Name
    New-Object System.Management.Automation.CompletionResult (
              "(Get-PowerBIWorkspace -Name '$($CompletionText)')",
              $_.Name,
              'ParameterValue',
              "$_ (PowerBIWorkspace)"
                )
          }
};
<# We need an argument completer for -WorkspaceID #>
Register-ArgumentCompleter -ParameterName WorkspaceID -ScriptBlock {
    Get-PowerBIWorkspace | ForEach-Object {
    $CompletionText = $_.Id
    New-Object System.Management.Automation.CompletionResult (
              $CompletionText,
              $_.Name,
              'ParameterValue',
              "$_ (PowerBIWorkspaceID)"
                )
          }
};
<# We need an argument completer for -Report when -WorkspaceID has been specified. #>
Register-ArgumentCompleter -CommandName Copy-PowerBIReport -ParameterName Report -ScriptBlock {

    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    if ($fakeBoundParameter.ContainsKey('WorkspaceId')) {
    Get-PowerBIReport -WorkspaceId $($fakeBoundParameter.WorkspaceId) | ForEach-Object {
    $CompletionText = $_.Id
    New-Object System.Management.Automation.CompletionResult (
              $CompletionText,
              $_.Name,
              'ParameterValue',
              "$_ (PowerBIWorkspaceID)"
                )
          }
    }
};
<# We need an argument completer for -Id parameter of the Get-PowerBIWorkspace command #>
Register-ArgumentCompleter -CommandName Get-PowerBIWorkspace -ParameterName ID -ScriptBlock {
    Get-PowerBIWorkspace | ForEach-Object {
    $CompletionText = $_.Id
    New-Object System.Management.Automation.CompletionResult (
              $CompletionText,
              $_.Name,
              'ParameterValue',
              "$_ (PowerBIWorkspaceID)"
                )
          }
};
<# When the Report Parameter is called -Name we do this #>
Register-ArgumentCompleter -CommandName Get-PowerBIReport -ParameterName Name -ScriptBlock {

    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    #$global:__LastFakeBoundParameter = $fakeBoundParameter
    
    if ($fakeBoundParameter.ContainsKey('WorkspaceId')) {
        (Get-PowerBIReport -WorkspaceId $fakeBoundParameter.WorkspaceId).Name | ForEach-Object {
            New-Object System.Management.Automation.CompletionResult (
                "'$($_)'",
                $_,
                'ParameterValue',
                "$_ (PBIReport)"
            )
        }
    }
};