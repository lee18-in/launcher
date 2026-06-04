#!/usr/bin/env bash
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

main_file="$(choose_from "Select Python file:" "${py_files[@]}")"
if [[ "$main_file" == "__EXIT__" ]]; then
  exit 0
fi

echo
echo "Running: $python_bin $project_dir/$main_file"
cd "$project_dir" || exit 1
exec "$python_bin" "$main_file"
