function Write-Log {
    [CmdletBinding()]
    <#
.SYNOPSIS
    Writes a log message to a CSV file and/or the console.
.DESCRIPTION
    The Write-Log function writes a log message to a CSV file and/or the console.
    The log file is saved in the specified log folder with a filename that includes
    the prefix, the current date formatted according to the specified date format,
    and the ".csv" file extension. Each log message is saved as a row in the CSV file
    with the time, source, level, and message as columns.
.PARAMETER Message
    The log message to write.
.PARAMETER Source
    The source of the log message. By default, the name of the function that called Write-Log.
.PARAMETER Level
    The severity level of the log message. Valid values are Info, Warn, Error, Success, and Debug.
    The default value is Info.
.PARAMETER HideInConsole
    If present, the log message will not be displayed on the console.
.PARAMETER LogFilePrefix
    The prefix to use in the log file name. The default value is "LOG".
.PARAMETER LogFolder
    The folder where log files will be saved. By default, the Logs folder in the same directory as the script.
.PARAMETER LogFileDateFormat
    The date format to use in the log file name. The default value is "ddMMyyyy".
.NOTES
    Version:        1.0
    Author:         Jordan LACROIX
    Creation Date:  2023-04-04
.EXAMPLE
    Write-Log -Message "Starting the script"
    Write-Log -Message "An error occurred" -Level Error
#>

    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Message,       
        [string]$Source = $MyInvocation.MyCommand.Name,   
        [ValidateSet('Info', 'Warn', 'Error', 'Success', 'Debug')]
        [string]$Level = 'Info',      
        [Parameter(Mandatory = $false)]
        [switch]$HideInConsole,    
        [string]$LogFilePrefix = 'LOG',
        [string]$LogFolder = "$PSScriptRoot\Logs",
        [string]$LogFileDateFormat = 'ddMMyyyy'
    )  
    
    Set-StrictMode -Version Latest 
   
    $VerbosePreference = 'SilentlyContinue'
    
    if (-not (Test-Path -Path $LogFolder -PathType Container)) {
        throw "Le dossier de logs '$LogFolder' n'existe pas."
    }
    
    $OutputConsole = (-not $HideInConsole)
    
    $Now = Get-Date
    $TimeFormat = $Now.ToString($LogFileDateFormat)
    $Time = Get-Date -Format g
    
    $LogObject = [PSCustomObject]@{
        Time    = $Time
        Source  = $Source
        Level   = $Level
        Message = $Message
    }
    
    $LogPath = Join-Path -Path $LogFolder -ChildPath "$LogFilePrefix-$TimeFormat.csv"
    $LogObject | Export-Csv -Path $LogPath -Append -NoTypeInformation -Delimiter ';' -Encoding UTF8
    
    switch ($Level) {
        'Info' { $Color = 'Cyan'; break }
        'Warn' { $Color = 'Yellow'; break }
        'Error' { $Color = 'Red'; break }
        'Success' { $Color = 'Green'; break }
        default { $Color = 'White' }
    }
    
    if ($OutputConsole) {
        Write-Host "$Time - $Source - $Level - $Message" -ForegroundColor $Color
    }
    
    Write-Verbose "$Time - $Source - $Level - $Message"
}
