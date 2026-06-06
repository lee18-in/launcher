: <<"::WINDOWS_BLOCK"
@echo off
goto :windows_start
::WINDOWS_BLOCK

# ==========================================
# [Linux / macOS (Bash) 區塊]
# ==========================================
# 確保腳本使用 bash 執行 (若系統預設為 sh/dash 時的保險機制)
[ -z "$BASH_VERSION" ] && exec bash "$0" "$@"

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECTS_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECTS_ROOT" || exit 1

projects=()

add_project() {
  local dir="$1"

  if [[ ! -d "$dir/.venv" && ! -d "$dir/venv" ]]; then
    return
  fi

  shopt -s nullglob
  local py_files=("$dir"/*.py)
  shopt -u nullglob

  if (( ${#py_files[@]} > 0 )); then
    projects+=("$dir")
  fi
}

choose_from() {
  local prompt="$1"
  shift
  local items=("$@")
  local choice

  while true; do
    echo >&2
    echo "$prompt" >&2
    local i
    for i in "${!items[@]}"; do
      printf '  %d) %s\n' "$((i + 1))" "${items[$i]}" >&2
    done
    echo "  0) Exit" >&2
    printf 'Choose: ' >&2
    read -r choice
    
    # 移除使用者可能夾帶的 \r 字元 (若檔案格式在 Git 轉換中變成 CRLF 導致的小問題)
    choice="${choice%$'\r'}"

    if [[ "$choice" == "0" ]]; then
      printf '__EXIT__\n'
      return
    fi

    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#items[@]} )); then
      printf '%s\n' "${items[$((choice - 1))]}"
      return
    fi

    echo "Invalid choice." >&2
  done
}

add_project "."

for dir in */; do
  [[ -d "$dir" ]] || continue
  add_project "${dir%/}"
done

if (( ${#projects[@]} == 0 )); then
  echo "No project found. Need a folder with .venv or venv and at least one .py file."
  exit 1
fi

project="$(choose_from "Select project folder:" "${projects[@]}")"
if [[ "$project" == "__EXIT__" ]]; then
  exit 0
fi
project_dir="$(cd "$project" && pwd)"

if [[ -x "$project_dir/.venv/bin/python" ]]; then
  python_bin="$project_dir/.venv/bin/python"
elif [[ -x "$project_dir/venv/bin/python" ]]; then
  python_bin="$project_dir/venv/bin/python"
else
  echo "No Linux Python executable found in $project/.venv/bin/python or $project/venv/bin/python."
  echo "Create the Linux virtual environment first, for example: python3 -m venv .venv"
  exit 1
fi

py_files=()
for candidate in main.py app.py; do
  if [[ -f "$project/$candidate" ]]; then
    py_files+=("$candidate")
  fi
done

shopt -s nullglob
for file in "$project"/*.py; do
  name="$(basename "$file")"
  if [[ "$name" != "main.py" && "$name" != "app.py" ]]; then
    py_files+=("$name")
  fi
done
shopt -u nullglob

if [[ -f "$project/main.py" ]]; then
  main_file="main.py"
elif [[ -f "$project/mani.py" ]]; then
  main_file="mani.py"
elif (( ${#py_files[@]} == 1 )); then
  main_file="${py_files[0]}"
else
  main_file="$(choose_from "Select Python file:" "${py_files[@]}")"
  if [[ "$main_file" == "__EXIT__" ]]; then
    exit 0
  fi
fi

echo ""
echo "Running: $python_bin $project_dir/$main_file"
cd "$project_dir" || exit 1
exec "$python_bin" "$main_file"

# Bash 執行完畢後直接退出，避免往下執行到 Windows 區塊
exit 0


# ==========================================
# [Windows (Batch) 區塊]
# ==========================================
:windows_start
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

if exist "%PROJECT%\main.py" (
    set "MAIN_FILE=main.py"
    goto run_file
)
if exist "%PROJECT%\mani.py" (
    set "MAIN_FILE=mani.py"
    goto run_file
)
if "%FILE_COUNT%"=="1" (
    set "MAIN_FILE=!FILE_1!"
    goto run_file
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

:run_file
echo.
echo Running: "%PYTHON_EXE%" "%PROJECT_DIR%\%MAIN_FILE%"
pushd "%PROJECT_DIR%"
echo.
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