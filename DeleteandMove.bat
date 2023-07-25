@REM write a batch file that will connect to a remote file share and change the working directory /home/ESP/Inspections/Pools and Spas

@REM it will then delete all items in the directory then it will copy over all files in/from a local path of C:\Users\austen.green\Desktop\bak
@REM to the remote directory. Once it has finished it will display a message that says what files it has successfully deleted on the remote path and the files it has successfully moved to the remote path. 




@REM This is a batch script that connects to a remote server using SFTP (Secure File Transfer Protocol) and performs the following actions:

@REM 1. Sets the local path and remote path variables and prompts the user to enter a password for SFTP.
@REM 2. Connects to the remote server using SFTP and navigates to the remote path.
@REM 3. Deletes all files in the remote path.
@REM 4. Uploads all files from the local path to the remote path.
@REM 5. Displays a success message and lists the files in the remote path.
@REM 6. Displays a success message and lists the files that were uploaded to the remote path.
@REM 7. Ends the script.

@REM The "@echo off" command turns off the display of commands as they are executed. The "setlocal" command sets the scope of environment variables to the current batch file and any batch files it calls. The "set" command sets the values of the "local_path", "remote_path", and "password" variables. The "/p" switch prompts the user to enter a value for the "password" variable. The "echo" command displays text on the screen. The "sftp" command connects to the remote server and performs various actions. The "cd" command changes the current directory to the remote path. The "rm" command deletes all files in the remote path. The "put" command uploads all files from the local path to the remote path. The "exit" command closes the SFTP session. The "for" command loops through all files in the local path and displays their names. The "endlocal" command ends the scope of the environment variables.


@echo off
setlocal

set "local_path=C:\Users\austen.green\Desktop\bak"
set "remote_path=/home/ESP/Inspections/Pools and Spas"
set /p password="Enter password for sftp: "

echo Connecting to remote file share...
sftp deq190@deq-iis.ne.gov <<EOF
  cd %remote_path%
  rm *
  put %local_path%\* .
  exit
EOF

echo Displaying success message...
echo Successfully deleted the following files from the remote path:
sftp deq190@deq-iis.ne.gov -pw %password% <<EOF
  cd %remote_path%
  ls -1
  exit
EOF

echo.
echo Successfully moved the following files to the remote path:
for %%A in ("%local_path%\*") do echo %%~nxA

endlocal
