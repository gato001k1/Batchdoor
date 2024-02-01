@echo off
title DISPLAY
goto 2
:loop
if exist text.refresh (
goto 2
) else (
    goto loop
)

:2
cls
type hak
echo terminal:#
if exist text.refresh (
    del text.refresh
) else (
    goto loop
)
goto loop
