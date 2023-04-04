function Write-Log {
    [CmdletBinding()]
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
