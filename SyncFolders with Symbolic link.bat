@echo off

set "fromFolder=C:\Users\austen.green\PhpstormProjects\ZSintl\HCP"
set "toFolder=C:\Users\austen.green\PhpstormProjects\HCP"

if not exist "%fromFolder%" (
    echo Source folder does not exist.
    exit /b
)

if not exist "%toFolder%" (
    echo Destination folder does not exist.
    exit /b
)

echo Syncing folders using symbolic links...
echo From: %fromFolder%
echo To: %toFolder%
echo.

for /R "%fromFolder%" %%F in (*) do (
    set "relativePath=%%~pnxF"
    setlocal enabledelayedexpansion
    mklink /H "%toFolder%!relativePath:%fromFolder%=!" "%%F"
    endlocal
)

echo.
echo Syncing complete.
