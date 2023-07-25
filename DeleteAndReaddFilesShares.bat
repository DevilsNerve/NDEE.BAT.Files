@echo off
setlocal enabledelayedexpansion

set found_disconnected=0
set found_unavailable=0

for /f "tokens=2 delims= " %%d in ('net use ^| findstr /i "Disconnected Unavailable"') do (
    echo %%d is disconnected or unavailable, checking path...
    for /f "tokens=2 delims=: " %%i in ("%%d") do set "oldpath=%%i"
    net use "!oldpath!" 2>nul && (
        echo The path !oldpath! is available, deleting...
        net use "%%d" /delete
        set /p user=Enter username for share "!oldpath!": 
        set /p pass=Enter password for share "!oldpath!": 
        net use "%%d" "!oldpath!" /user:%user% %pass% /persistent:yes && (
            echo Share !oldpath! added successfully.
        ) || (
            echo Failed to add share !oldpath!. You're probably disabled in IBM I. Have Shani or Jeff or Austen enable you, then try again.
        )
    ) || (
        echo The path !oldpath! is not available, skipping...
    )
    if "%%d" == "" set found_disconnected=1
    if "%%d" == "" set found_unavailable=1
)

if %found_disconnected% == 0 echo Error: No disconnected shares found.
if %found_unavailable% == 0 echo Error: No unavailable shares found.

pause

