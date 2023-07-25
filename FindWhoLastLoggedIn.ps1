$ArrComputers = @("hd0731m020.stone.ne.gov", "HD07310039", "HD07310039.stone.ne.gov", "PC4")
$DesktopPath = [Environment]::GetFolderPath("Desktop")

foreach ($Computer in $ArrComputers) {

    Get-ChildItem "\\$Computer\c$\Users" | Sort-Object LastWriteTime -Descending | Select-Object Name, LastWriteTime -first 1 | Out-File "$DesktopPath\test.txt" -Append
}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
