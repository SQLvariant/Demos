<img src="https://app.powerbi.com/13.0.10537.111/images/PowerBI96x96.png?raw=true" width="10%">
<img src="https://github.com/Microsoft/azuredatastudio/blob/master/samples/notebookSamples/Graphics/AzureDataStudioLogo.png?raw=true" width="10%">

# PowerShell for Power BI
These are the latest scripts & Notebooks used in my presentation

## Abstract
Power BI is designed as a user-friendly GUI based tool for creating and publishing beautiful reports. Unfortunately, it was not designed to integrate well with application lifecycle management or the DevOps methodology. For example, manually migrating the contents of one Power BI workspace to another workspace can be tedious and painful.

In this session, we will see how PowerShell will let us create environments for Dev, QA, and Prod in a reliable, repeatable way within the Power BI Service. We’ll then see how we can deploy an updated report from QA to Prod (with different data for each environment) without overwriting the Prod datasource.

In addition, we will discuss the Data Governance collection capabilities for easy and efficient auditing. By the end of this session, you’ll see how a few lines of PowerShell can save you time and frustration when dealing with Power BI Service workspaces

## Demos

+ Start Here - [GetStartedWithPowerBIcmdlets.ipynb](./GetStartedWithPowerBIcmdlets.ipynb)
+ Data Governance - [ExportPowerBIWorkspaceAssets_withPowerShell.ipynb](./Data-Governance/ExportPowerBIWorkspaceAssets_withPowerShell.ipynb) and [Export_PBI_AuditLogs.ipynb](./Data-Governance/Export_PBI_AuditLogs.ipynb)