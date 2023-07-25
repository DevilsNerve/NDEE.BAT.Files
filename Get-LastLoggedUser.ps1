param([string]$computerName)

# Attempt to retrieve the last logged on user from the remote computer
try {
    $lastLoggedUser = (Get-WmiObject -ComputerName $computerName -Class Win32_ComputerSystem -ErrorAction Stop).UserName
} catch {
    Write-Error "Unable to connect to $computerName or retrieve last logged on user"
    return
}

# Create a PSObject to hold our output data
$output = New-Object PSObject
$output | Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $computerName
$output | Add-Member -MemberType NoteProperty -Name "LastLoggedUser" -Value $lastLoggedUser

# Output the computer name and last logged on user to output.csv
$output | Export-Csv -Path output.csv -Append -NoTypeInformation

