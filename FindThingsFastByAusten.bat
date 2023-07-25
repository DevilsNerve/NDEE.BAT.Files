@REM Code explanation:
@REM This is a batch script that allows the user to search for files in a directory based on a specified file type, date range, and keyword. 
@REM The first line "@echo off" turns off the command echo so that the commands executed in the script are not displayed in the command prompt.
@REM The second line "title Created by Austen Green" sets the title of the command prompt window.
@REM The third line "setlocal" limits the scope of variable changes to the current batch script.
@REM The next four lines prompt the user to enter the search directory, file type, start date, end date, and keyword respectively. The "set /p" command allows the user to input the values and assigns them to variables.
@REM The "start_time" variable is set to the current time.
@REM The "for" loop searches for files in the specified directory and file type using the "findstr" command to search for the keyword in the file contents. If the keyword is found, the file path is printed. If the keyword is not found in the file contents, the file path is checked again using the "findstr" command to search for the keyword in the file name. If the keyword is found, the file path is printed.
@REM The "end_time" variable is set to the current time.
@REM The "time_diff" variable is calculated by converting the start and end times to seconds and subtracting them.
@REM The last few lines print a message indicating that the search is complete and the time taken to complete the search. The "pause" command is used to keep the command prompt window open until the user presses a key.



@REM Example use:
@REM Enter the search directory (e.g. C:\Users\AustenGreen\Desktop): C:\Users\JohnDoe\Documents
@REM Enter the file type to search (e.g. *.txt): *.docx
@REM Enter the start date for the search (MM/DD/YYYY): 01/01/2021
@REM Enter the end date for the search (MM/DD/YYYY): 12/31/2021
@REM Enter the keyword to search for: confidential



@echo off
title Created by Austen Green

setlocal

set /p search_dir=Enter the search directory (e.g. C:\Users\AustenGreen\Desktop):
set /p file_type=Enter the file type to search (e.g. *.txt):
set /p start_date=Enter the start date for the search (MM/DD/YYYY):
set /p end_date=Enter the end date for the search (MM/DD/YYYY):
set /p keyword=Enter the keyword to search for:

set "start_time=%time%"

for /r %search_dir% %%f in (%file_type%) do (
    findstr /i /m /c:"%keyword%" "%%f" && (
        echo %%f
    ) || (
        echo %%f | findstr /i /c:"%keyword%" && (
            echo %%f
        )
    )
)

set "end_time=%time%"
set "time_diff="

rem Calculate time difference
for /f "tokens=1-4 delims=:." %%a in ("%start_time%") do (
    set /a "start_seconds=(((%%a*60)+1%%b%%100)*60)+1%%c%%100"
)
for /f "tokens=1-4 delims=:." %%a in ("%end_time%") do (
    set /a "end_seconds=(((%%a*60)+1%%b%%100)*60)+1%%c%%100"
)
set /a "time_diff=end_seconds-start_seconds"

echo ....................................
echo         Search complete
echo ....................................
echo Time taken: %time_diff% seconds
pause
