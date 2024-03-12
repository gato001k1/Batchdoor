@echo off
title batchdoor recive v1.2
if exist curl.exe (
goto curlpathsetb
) else (
    set curlpath=curl
    echo is recommended to have the curl provided.
    pause
    goto inic
)
rem to fix a if () bug
:curlpathsetb
    set "curlpath=%~dp0curl.exe"
    echo %curlpath% set
    goto inic

:inic
set /p username=<username
set /p password=<password
set /p server=<server
echo %username%
echo %password%
echo %server%
echo setting the protocol mode
set /p sftpmode=<sftp
if EXIST sftp (
 set sftpmode=sftp
 goto loop2
) else (
    set sftpmode=ftp
    goto loop2
)

:loop2
if NOT EXIST sftpchecker (
    mkdir sftpchecker
    goto sftpchecked
) else (
    goto sftpchecked
)
:sftpchecked
if exist hak (
    for %%A in (hak) do set local_file_size=%%~zA
) else (
    echo The hak file does not exist.
    set local_file_size=0
)
cd sftpchecker
    "%curlpath%" --user %username%:%password% -o hak %sftpmode%://%server%/hak -k
if exist hak (
    for %%A in (hak) do set server_file_size=%%~zA
    cd ..
) else (
    cd ..
    echo The hak file does not exist.
    set server_file_size=0
)

echo File size on the server: %server_file_size%
echo File size on the local machine: %local_file_size%

if %local_file_size% equ %server_file_size% (
    echo File is the same, no changes made.
    goto sftpchecked
) else (
    echo File has changed. Changing file...
        "%curlpath%" --user %username%:%password% -o hak %sftpmode%://%server%/hak -k
     setlocal enablesetdelayedexpansion
       type hak >> haks
    rem    > hak2 (
 rem for /f "delims=" %%i in (hak) do (
rem echo Don 
 rem )
rem )
    echo refreshing text screen
    echo 0 > text.refresh
    goto sftpchecked
)

:EOF
exit
