:pc-inf
cls
echo ===================================================
echo                  PC INFORMATIE
echo ===================================================
echo.
for /f "tokens=*" %%A in ('hostname') do set PCName=%%A
echo Naam van de PC: %PCName%
net localgroup Administrators | findstr /i "%username%" >nul
if %errorlevel% equ 0 (
    echo Huidige gebruiker: %username% en heeft administrator rechten.
) else (
    echo Huidige gebruiker: %username% en is een lokale gebruiker.
)
echo.
echo Processor Informatie:
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors
echo.
echo Geheugen Informatie:
wmic memorychip get Capacity,Speed,Manufacturer
echo.
echo Schijfruimte C: schijf:
powershell -Command "Get-PSDrive -PSProvider FileSystem | Where-Object {$_.Name -eq 'C'} | Select-Object Name, @{Name='Used(GB)';Expression={[math]::round($_.Used/1GB, 2)}}, @{Name='Free(GB)';Expression={[math]::round($_.Free/1GB, 2)}}, @{Name='Total(GB)';Expression={[math]::round($_.Used/1GB + $_.Free/1GB, 2)}}"
echo.
echo Verbonden Netwerk:
for /f "tokens=*" %%A in ('netsh wlan show interfaces ^| findstr "SSID Signal"') do echo %%A
echo.

echo Systeeminformatie:
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model" /C:"System Type"

pause
goto main
