@echo off
setlocal EnableExtensions EnableDelayedExpansion

cd /d "%~dp0.."
set "COUNT=0"

call :maybe_add "."

for /d %%D in (*) do (
    call :maybe_add "%%D"
)

if "%COUNT%"=="0" (
    echo No project found. Need a folder with .venv or venv and at least one .py file.
    pause
    exit /b 1
)

:project_menu
echo.
echo Select project folder:
for /l %%I in (1,1,%COUNT%) do (
    echo   %%I^) !PROJECT_%%I!
)
echo   0^) Exit
set /p "CHOICE=Choose: "

if "%CHOICE%"=="0" exit /b 0
if not defined PROJECT_%CHOICE% (
    echo Invalid choice.
    goto project_menu
)

set "PROJECT=!PROJECT_%CHOICE%!"
for %%P in ("%PROJECT%") do set "PROJECT_DIR=%%~fP"

if exist "%PROJECT_DIR%\.venv\Scripts\python.exe" (
    set "PYTHON_EXE=%PROJECT_DIR%\.venv\Scripts\python.exe"
) else if exist "%PROJECT_DIR%\venv\Scripts\python.exe" (
    set "PYTHON_EXE=%PROJECT_DIR%\venv\Scripts\python.exe"
) else (
    echo No Windows Python executable found in "%PROJECT%\.venv\Scripts\python.exe" or "%PROJECT%\venv\Scripts\python.exe".
    echo Create the Windows virtual environment first, for example: py -m venv .venv
    pause
    exit /b 1
)

set "FILE_COUNT=0"
call :add_file_if_exists "main.py"
call :add_file_if_exists "app.py"

for %%F in ("%PROJECT%\*.py") do (
    set "NAME=%%~nxF"
    if /i not "!NAME!"=="main.py" if /i not "!NAME!"=="app.py" call :add_file "!NAME!"
)

:file_menu
echo.
echo Select Python file:
for /l %%I in (1,1,%FILE_COUNT%) do (
    echo   %%I^) !FILE_%%I!
)
echo   0^) Exit
set /p "FILE_CHOICE=Choose: "

if "%FILE_CHOICE%"=="0" exit /b 0
if not defined FILE_%FILE_CHOICE% (
    echo Invalid choice.
    goto file_menu
)

set "MAIN_FILE=!FILE_%FILE_CHOICE%!"

echo.
echo Running: "%PYTHON_EXE%" "%PROJECT_DIR%\%MAIN_FILE%"
pushd "%PROJECT_DIR%"
"%PYTHON_EXE%" "%MAIN_FILE%"
set "EXIT_CODE=%ERRORLEVEL%"
popd
echo.
echo App exited with code %EXIT_CODE%.
pause
exit /b %EXIT_CODE%

:maybe_add
set "DIR=%~1"
if not exist "%DIR%\.venv\" if not exist "%DIR%\venv\" exit /b 0
dir /b "%DIR%\*.py" >nul 2>nul
if errorlevel 1 exit /b 0
set /a COUNT+=1
set "PROJECT_%COUNT%=%DIR%"
exit /b 0

:add_file_if_exists
if exist "%PROJECT%\%~1" call :add_file "%~1"
exit /b 0

:add_file
set /a FILE_COUNT+=1
set "FILE_%FILE_COUNT%=%~1"
exit /b 0
