@echo off


:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)



 
setlocal enabledelayedexpansion

:main
cls
echo.


@(cls & color 1f & cd. & goto %:^))
%:^)
echo.
echo ========================================
echo       WIFI Management Menu
echo ========================================
echo Hello, %username% 
echo Kies een optie :)

echo.
echo 1. PC informatie
echo 2. Toon alle WIFI SSIDs en wachtwoorden op deze pc overzicht
echo 3. Voe een WIFI netwerk toe
echo 4. Open configuratiescherm
echo.
echo x. Stop het programma
echo ========================================
set /p choice="Uw keuze: "

if "%choice%"=="1" goto pc-inf
if "%choice%"=="2" goto show_wifi
if "%choice%"=="3" goto add
if "%choice%"=="4" goto openConfig
if "%choice%"=="x" exit
if "%choice%"=="X" exit
echo Verkeerde keuze, druk op enter en probeer opnieuw.
pause
goto main


























