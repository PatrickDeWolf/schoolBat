
:Add
cls
echo.
echo ========================================
echo         WIFI netwerk toevoegen:
echo ========================================
echo.
echo Opties:
echo.
echo 1. voeg GO4B-TEST-LEERLINGEN netwerk toe
echo 2. voeg WIFI SSID in
echo 3. ga terug naar het hoofdmenu
echo x. stop het programma
echo ========================================
set /p ssid="Uw keuze: "
if "%ssid%"=="1" goto ll
if "%ssid%"=="2" goto tv
if "%ssid%"=="3" goto main
if "%ssid%"=="x" exit
if "%ssid%"=="X" exit
echo Verkeerde keuze, druk op enter en probeer opnieuw.
pause
goto main


:ll
set ssid=GO4B-TEST-LEERLINGEN
set password=WIFI1080
goto addNw


:tv
set /p ssid="WIFI SSID toevoegen: "
if "%ssid%"=="" (
    echo Uw keuze mag niet leeg zijn.
    pause
    goto main
)
set /p password="Voeg het WIFI wachtwoord in: "
if "%password%"=="" (
    echo Het wachtwoord kan niet leeg zijn.
    pause
    goto main
)
goto addNw
:addNw
echo WIFI profiel toevoegen. SSID "%ssid%"...

:: Generate the XML file for the Wi-Fi profile
set profile_file=%temp%\wifi_profile.xml
(
    echo ^<?xml version="1.0" encoding="US-ASCII"^?^>
    echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
    echo     ^<name^>%ssid%^</name^>
    echo     ^<SSIDConfig^>
    echo         ^<SSID^>
    echo             ^<name^>%ssid%^</name^>
    echo         ^</SSID^>
    echo     ^</SSIDConfig^>
    echo     ^<connectionType^>ESS^</connectionType^>
    echo     ^<connectionMode^>auto^</connectionMode^>
    echo     ^<MSM^>
    echo         ^<security^>
    echo             ^<authEncryption^>
    echo                 ^<authentication^>WPA2PSK^</authentication^>
    echo                 ^<encryption^>AES^</encryption^>
    echo                 ^<useOneX^>false^</useOneX^>
    echo             ^</authEncryption^>
    echo             ^<sharedKey^>
    echo                 ^<keyType^>passPhrase^</keyType^>
    echo                 ^<protected^>false^</protected^>
    echo                 ^<keyMaterial^>%password%^</keyMaterial^>
    echo             ^</sharedKey^>
    echo         ^</security^>
    echo     ^</MSM^>
    echo ^</WLANProfile^>
) > "%profile_file%"

:: Add the profile to the system
:: netsh wlan add profile filename="%profile_file%" >nul 2>&1
netsh wlan add profile filename="%profile_file%"
cls
echo.
echo ==============================================
if %errorlevel%==0 (
    echo WIFI profiel SSID '%ssid%' succesvol toegevoegd!
) else (
    echo WIFI profileniet aangemaakt. Debugging details:
    echo ----------------------------------------
    echo Profile XML File: %profile_file%
    echo File Content:
    type "%profile_file%"
    echo ----------------------------------------
    echo Zorg ervoor dat je SSID en wachtwoord correct zijn en dat je system WPA2 ondersteund.
)
echo ==============================================
:: Cleanup
del "%profile_file%" >nul 2>&1
pause
goto main
