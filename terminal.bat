@echo off
setlocal enablesetdelayedexpansion

if not exist curl.exe (

wget https://github.com/gato001k1/project-batch-message-app/raw/main/curl.exe
set "curlpath=%~dp0curl.exe"
goto stof

) else (
    set "curlpath=%~dp0curl.exe"
goto stof
)
:stof
cls
echo ------------------------------------------------------------------------------------------------------------------------
echo Use config to set up a connection
echo Use connect to connect to the server
echo ------------------------------------------------------------------------------------------------------------------------
set /p menu= Enter the option:#
if "%menu%"=="config" goto conf

if "%menu%"=="connect" goto connect

echo the option selected does not exist :(
    pause
    goto stof


:conf
cls
Echo Enter the IP address or the Host name of the SFTP or FTP server:
set /p ftpServer=#:
Echo Enter the username to log in to the SFTP or FTP server:
set /p ftpUsername=#:
Echo Enter the password to log in to the SFTP or FTP server:
set /p ftpPassword=#:
rem user creator system   users
    echo creating user
rem           
    echo !ftpUsername!>username
    echo !ftpServer!>server
    echo !ftpPassword!>password
cls
:cl
echo is the server sftp?
set /p sftpchoose=(Y,N):
if "%sftpchoose%"=="y" (
    echo o > sftp
    set sftpmode="sftp"
    cls
    goto confix
    )
if "%sftpchoose%"=="n" (
    set sftpmode="ftp"
    cls
    goto confix
    )
    echo option not valid
    pause
    cls
    goto cl
    :confix
echo > hak
    set /p username=<username
set /p password=<password
set /p server=<server
echo %username%
echo %password%
echo %server%
"%curlpath%" -u %username%:%password% -T "hak" %sftpmode%://%server% -k
echo Checking connection...
if %ERRORLEVEL% EQU 0 (
   echo  Connection OK!
   pause
   goto stof
) else (
    echo Connection error.
    pause
    goto stof
)

:connect
set /p username=<username
set /p password=<password
set /p server=<server
echo %username%
echo %password%
echo %server%
if EXIST sftp (
 set "sftpmode=sftp"
) else (
set "sftpmode=ftp"
)
echo !sftpmode!
"%curlpath%" -u %username%:%password% -T "hak" %sftpmode%://%server% -k
echo Checking connection...
if %ERRORLEVEL% EQU 0 (
   echo  Connection OK!
   goto af
) else (
    echo Connection error.
    pause
    goto stof
)
cls
:af
start display.bat
start recive.bat
goto l
:l
cls
echo use "*" for internal commands
echo commands: exit, destroy,exitserver
echo Server credentials: usr: %username% usrn: Terminal pass: %password% serv: %server%
set /p terminal= Terminal#:

if "%terminal%"=="*,destroy" (
echo Wip
goto connect
)

if "%terminal%"=="*exit" (
goto stof
)

if "%terminal%"=="*exitserver" (
goto exts
)

echo Terminal:# %terminal% >> hak
echo %terminal% > com
"%curlpath%" -u %username%:%password% -T "hak" %sftpmode%://%server% -k 2>nul
if %ERRORLEVEL% EQU 0 (
   echo  sended OK!
) else (
    echo Error sending hak file
    pause
)
echo > text.refresh
"%curlpath%" -u %username%:%password% -T "com" %sftpmode%://%server% -k 2>nul
if %ERRORLEVEL% EQU 0 (

   echo  sended OK!
) else (
    echo Error sending com file
    pause
)

goto l


:exts
echo Terminal:# Warning Terminal Terminated! >> hak
echo exitser > com
"%curlpath%" -u %username%:%password% -T "hak" %sftpmode%://%server% -k 2>nul
if %ERRORLEVEL% EQU 0 (
   echo  sended OK!
) else (
    echo Error sending hak file
    pause
)
echo > text.refresh
"%curlpath%" -u %username%:%password% -T "com" %sftpmode%://%server% -k 2>nul
if %ERRORLEVEL% EQU 0 (

   echo  sended OK!
) else (
    echo Error sending com file
    pause
)

goto l