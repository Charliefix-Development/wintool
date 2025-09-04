@echo off
set "LOCAL_VERSION=1.0.0.0.beta-1"
set "EC=Enter"
set "UL========================"
setlocal EnableDelayedExpansion

if "%1"=="admin" (
    echo Batch file was started with admin rights.
) else (
    echo It's important for this batch file to have admin rights to do some operations. If you don't give it them, some operations won't be available. 
	pause
    powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c \"\"%~f0\" admin\"' -Verb RunAs"
    exit /b
)

:menu
cls
set "menu_choice=null"
echo %UL%
echo 1. Windows maintenance
echo 2. Get weather forecast
echo 0. Exit
set /p menu_choice=%EC% (0-8): 

if "%menu_choice%"=="1" goto windows_maintenance
if "%menu_choice%"=="2" goto weather_forecast
if "%menu_choice%"=="0" exit /b
goto menu


:windows_maintenance
cls
set "menu_choice=null"
echo =======================
echo 1. Clean cache
echo 2. Network Actions
echo 0. Go back
set /p menu_choice=%EC% (0-8): 

if "%menu_choice%"=="1" goto clean_cache
if "%menu_choice%"=="2" goto network_actions
if "%menu_choice%"=="0" goto menu
goto windows_maintenance

:clean_cache
cls
echo please confirm that you are going to run this at your own risk
pause
echo Seriously, this is your last warning!
pause
DEL /F /S /Q %WINDIR%\Temp\*.*
echo Cleaning %WINDIR%\Temp...
DEL /F /S /Q %SYSTEMDRIVE%\Temp\*.*
echo Cleaning %SYSTEMDRIVE%\Temp...
DEL /F /S /Q %Temp%\*.*
echo Cleaning %Temp%...
DEL /F /S /Q %Tmp%\*.*
echo Cleaning %Tmp%...

DEL /F /S /Q %WINDIR%\Prefetch\*.*
echo Cleaning %WINDIR%\Prefetch...

echo Cleaning another cache files...
taskkill /f /im explorer.exe
timeout 2 /nobreak>nul
DEL /F /S /Q /A %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db
DEL /f /s /q %systemdrive%\*.tmp
DEL /f /s /q %systemdrive%\*._mp
DEL /f /s /q %systemdrive%\*.gid
DEL /f /s /q %systemdrive%\*.chk
DEL /f /s /q %systemdrive%\*.old
DEL /f /s /q %systemdrive%\recycled\*.*
DEL /f /s /q %windir%\*.bak
DEL /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp

DEL /f /q %userprofile%\recent\*.*
DEL /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
DEL /f /s /q "%userprofile%\Local Settings\Temp\*.*"
DEL /f /s /q "%userprofile%\recent\*.*"
timeout 2 /nobreak>nul
start explorer.exe
:call PrintGreen Cache cleaning has been completed.
pause
goto windows_maintenance


:weather_forecast
cls
curl wttr.in
pause
goto menu


:: Utility functions

:PrintGreen
powershell -Command "Write-Host \"%~1\" -ForegroundColor Green"
exit /b

:PrintRed
powershell -Command "Write-Host \"%~1\" -ForegroundColor Red"
exit /b

:PrintYellow
powershell -Command "Write-Host \"%~1\" -ForegroundColor Yellow"
exit /b
