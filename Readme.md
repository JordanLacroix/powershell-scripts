# PowerShell Scripts

This repository contains useful PowerShell scripts for various tasks. Feel free to use and contribute to this repository.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Scripts](#scripts)
    - [Script 1](#script-1)
    - [Script 2](#script-2)
    - [Script 3](#script-3)

## Installation

1. Clone this repository to your local machine.
2. Open PowerShell and navigate to the directory containing the repository.
3. Run the `install.ps1` script to install any necessary dependencies.

## Usage

To use any of the scripts in this repository, simply open PowerShell and navigate to the directory containing the script. Then, run the script using the following command:

```powershell
.\scriptname.ps1
```


## Scripts

### Write-Log

The `Write-Log` function is a PowerShell script that enables logging of messages to a CSV file and optionally to the console.

## Usage

1. Import the `Write-Log` function into your PowerShell script by either copying the function into your script or dot-sourcing the script file containing the function.
2. Call the `Write-Log` function in your script by passing a message string and, optionally, specifying the source, level, and other parameters.

### Parameters

- `Message` (mandatory): The message string to be logged.
- `Source`: The name of the source or module that is logging the message. Defaults to the name of the calling script.
- `Level`: The severity level of the message. Must be one of the following values: `Info`, `Warn`, `Error`, `Success`, or `Debug`. Defaults to `Info`.
- `HideInConsole`: A switch parameter that indicates whether to hide the message in the console. By default, the message is displayed in the console.
- `LogFilePrefix`: The prefix to use for the log file name. Defaults to `LOG`.
- `LogFolder`: The path to the folder where the log file will be stored. Defaults to a subfolder named `Logs` in the script's root folder.
- `LogFileDateFormat`: The format string to use for the log file name timestamp. Defaults to `ddMMyyyy`.

## Example

```powershell
Import-Module .\Write-Log.ps1

Write-Log -Message "Starting script execution" -Level "Info"

# Do some work...

Write-Log -Message "Script execution completed" -Level "Success"
```


