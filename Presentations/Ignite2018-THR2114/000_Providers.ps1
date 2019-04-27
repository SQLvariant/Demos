Import-Module SqlServer
<# cd SQLSERVER:\ #>
DIR SQLSERVER:\

<# Registered Server & CMS  #>
DIR SQLSERVER:\SQLRegistration

DIR SQLSERVER:\SQLRegistration\'Analysis Services Group'

DIR -recurse SQLSERVER:\SQLRegistration\'Database Engine Server Group'\

<# Databases #>
CD SQLSERVER:\SQL\LocalHost\SQL2017\Databases\
DIR

<# SELECT * #>
DIR SQLSERVER:\SQL\LocalHost\SQL2017\Databases\ |
SELECT *
