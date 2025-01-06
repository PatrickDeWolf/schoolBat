:show_wifi
cls
set count=1
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    set ssid=%%i
    set ssid=!ssid:~1!
	echo.
    echo -----------------------------------------
    echo !count!. WIFI SSID: !ssid!
    set ssid_list[!count!]=!ssid!
    netsh wlan show profile name="!ssid!" key=clear | findstr "Key Content" > temp_pw.txt
    if exist temp_pw.txt (
        for /f "tokens=2 delims=:" %%j in (temp_pw.txt) do (
            set pw=%%j
            set pw=!pw:~1!
            echo Wachtwoord: !pw!
        )
        del temp_pw.txt
    ) else (
        echo Wachtwoord: [Niet beschikbaar of niet opgeslagen]
    )
    echo -----------------------------------------
	echo.
    set /a count+=1
)
pause
goto main
