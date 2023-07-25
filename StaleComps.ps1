# Specify the number of days of inactivity
$InactiveDays = 60

# Get the current date/time
$CurrentDate = Get-Date

# Calculate the inactive date
$InactiveDate = $CurrentDate.AddDays(-$InactiveDays)

# Query Active Directory for inactive computer accounts
$InactiveComputers = Get-ADComputer -Filter {LastLogonTimeStamp -lt $InactiveDate} -Properties LastLogonTimeStamp

# Export the results to a CSV file
$InactiveComputers | Select-Object Name, LastLogonTimeStamp | Export-Csv -NoTypeInformation -Path "C:\users\$env:UserName\Desktop\InactiveComputers.csv"
# Written by Austen Green
