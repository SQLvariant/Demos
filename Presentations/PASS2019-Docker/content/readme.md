<img src="https://github.com/GodStorm91/mobydock/blob/master/mobydock/static/docker-logo.png?raw=true" width="10%"> ➕
<img src="https://github.com/Microsoft/azuredatastudio/blob/master/samples/notebookSamples/Graphics/AzureDataStudioLogo.png?raw=true" width="6.5%"> = ❤
# PowerShell & SQL Server Notebooks in a Jupyter Book

This Jupyter Book of notebooks (.ipynb) is a guide for getting started with Docker containers using SQL-on-Linux running SQL Server 2019.

This demo is expected to be run in Azure Data Studio, with the PowerShell kernel for Notebooks installed.  For instructions on how to install the PowerShell kernel in Azure Data Studio, please see [this blog post](http://sqlvariant.com/2019/11/powershell-notebooks-are-available-in-azure-data-studio/).

REQUIRED: Please make sure you also have the latest version of the SqlServer PowerShell module installed from the PowerShell Gallery.

```powershell
Install-Module SqlServer;
```

Each notebook is designed to check for its own dependencies.  A 'run all cells' will either complete successfully, or it will error out.

## Chapters

1. [Install Docker Desktop](install/readme.md) - a collection of notebooks for setting up SQL Server on Linux in a Docker container.
2. [Create your SQL Docker containers](create/readme.md) - a collection of notebooks to explore 3 common approaches for storing data with SQL Server in a container.
3. [Sample](sample/readme.md) - a collection of notebooks for downloading & restoring sample databases from GitHub.
4. [Remove](remove/readme.md) - a collection of notebooks for diagnosing situations with a Big Data Cluster.
5. [Automate](automate/readme.md) - a collection of notebooks to automate the creation & setup of your Docker containers.
6. [Common](common/readme.md) - a collection of notebooks commonly linked from other notebooks, such as azdata login / logout.
