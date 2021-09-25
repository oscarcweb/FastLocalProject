@echo off
setlocal EnableDelayedExpansion

::: Set our variables here :::
::::::::::::::::::::::::::::::
::: Path of your www folder without last bar
set www=E:\laragon\www
::: Folder name where the projects are saved
set folder=Projects
::: Web protocol http or https
set protocol=http
::: Default main file, like index.html, demo.html, test.php, etc.
set file=demo.php

:::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~:::
:::~~~~~~~~~~~~~~~~~~~~~~~~ Don't Edit More ~~~~~~~~~~~~~~~~~~~~~~~~:::
:::~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~:::
set char=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
set count=0
set salt=6
set /a length=0 + !salt!

:Loop
set /a count+=1
set /a rand=%Random%%%62
set buffer=!buffer!!char:~%rand%,1!
if !count! leq !length! goto Loop

set name=Project_%buffer%
::echo !name!

if not exist %www%\%folder%\ mkdir %www%\%folder%\

if exist %www%\%folder%\%name%\ set name=%name%%random%

mkdir %www%\%folder%\%name%\

(
  echo;^<^^!DOCTYPE html^>
  echo;^<html^>
  echo;^<head^>
  echo;	^<meta charset^=^"utf-8^"^>
  echo;	^<meta http-equiv^=^"Cache-control^" content^=^"no-cache^, no-store^, must-revalidate^"^>
  echo;	^<meta http-equiv^=^"Pragma^" content^=^"no-cache^"^>
  echo;	^<title^>%name%^<^/title^>
  echo;	^<link href=^"./style.css^" rel^=^"stylesheet^"^>
  echo;^<^/head^>
  echo.
  echo;^<body^>
  echo.
  echo;	^<p^>I^'m waiting boss 😎^<^/p^>
  echo.
  echo;^<script src^=^"./script.js^"^>^<^/script^>
  echo;^<^/body^>
  echo;^<^/html^>
) > %www%\%folder%\%name%\%file%

echo. 2> %www%\%folder%\%name%\script.js
echo. 2> %www%\%folder%\%name%\style.css

start chrome.exe -incognito localhost/%folder%/%name%/%file%
code -r %www%\%folder%\%name%\

endlocal

exit;
