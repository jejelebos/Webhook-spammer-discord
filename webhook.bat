@echo off

REM Go to the directory where your code is located
cd C:\Users\%USERNAME%\Desktop || (
    echo Error: The specified path does not exist.
    timeout /t 5 /nobreak >nul
    exit /b
)

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed. Attempting to install...

    REM Set the URL to download Python installer
    set "pythonInstallerUrl=https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe"
    set "installerPath=%TEMP%\python-installer.exe"

    REM Download Python installer
    powershell -command "Invoke-WebRequest -Uri %pythonInstallerUrl% -OutFile %installerPath%" || (
        echo Failed to download Python installer.
        timeout /t 5 /nobreak >nul
        exit /b
    )

    REM Install Python silently
    %installerPath% /quiet InstallAllUsers=1 PrependPath=1 || (
        echo Failed to install Python.
        timeout /t 5 /nobreak >nul
        exit /b
    )

    echo Python installation completed.
    del %installerPath%
)

REM Check if pystyle is already installed
pip show pystyle >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing pystyle...
    pip install pystyle
) else (
    echo pystyle is already installed.
)

REM Clear the terminal before running webhook.py
cls

python webhook.py

REM Wait before closing the terminal
echo Press any key to exit...
pause >nul
