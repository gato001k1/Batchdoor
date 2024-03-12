@echo off
title DISPLAY
type haks
goto 2
:loop
if exist text.refresh (
goto 2
) else (
    goto loop
)

:2
type haks
echo Terminal:#
if exist text.refresh (
    del text.refresh
) else (
    goto loop
)
goto loop
