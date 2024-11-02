@echo off

REM enter the directory where your code is located
cd C:\Users\%USERNAME%\Desktop || (
    echo Error: The specified path does not exist.
    timeout /t 5 /nobreak >nul
    exit /b
)

REM check if pystyle is already installed
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
