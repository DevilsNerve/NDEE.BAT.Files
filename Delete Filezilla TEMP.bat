@echo off

setlocal enabledelayedexpansion

:loop
for /l %%x in (1,1,10) do (
    echo Deleting files from C:\Users\austen.green\AppData\Local\Temp\fz3temp-%%x
    del /s /f /q "C:\Users\austen.green\AppData\Local\Temp\fz3temp-%%x\*.*"
)

echo All files have been deleted.

set /p userInput="Enter any key to run the code again or enter 'exit' to exit: "

if /i "%userInput%"=="exit" (
    exit
) else (
    goto loop
)
