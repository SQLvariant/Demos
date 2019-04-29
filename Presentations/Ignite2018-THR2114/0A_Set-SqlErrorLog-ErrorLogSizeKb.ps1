<# Running this command will set the SQL Server ErrorLog to
    automaticalyy roll-over when it reaches 100MB in size (102,400 KB) #>

Set-SqlErrorLog -ServerInstance localhost\SQL2017 -ErrorLogSizeKb 102400