
https://github.com/lee18-in/

lee18.in
lee18-in · he/him
lee18.in's Toolkit. Crafting custom tools tailored to personal workflow habits. lee18.in 的軟體工具箱。撰寫屬於我自己用習慣的工具。

只要我有 VSCode + Python，我的 VSCode 就是我的跨平台軟體商店。
這個啟動器就是在實現這個理想。

# Python 專案啟動器 / Python Project Launcher

快速啟動位於同目錄的多個 Python 專案。啟動器會自動掃描虛擬環境和 Python 檔案，透過互動式選單讓你選擇要執行的專案和指令稿。

Quickly launch multiple Python projects in the same directory. The launcher automatically scans for virtual environments and Python files, then presents an interactive menu for you to select which project and script to run.

**支援平台 / Supported Platforms:**
- `launcher.bat` — Windows
- `launcher.sh` — Linux / macOS

## 結構示例 / Directory Structure

啟動器位於 `launcher/` 資料夾，會自動掃描其上層目錄的所有 Python 專案：

The launcher is in the `launcher/` folder and automatically scans Python projects in its parent directory:

```text
github/                          ← 啟動器掃描這個目錄
├── launcher/
│   ├── launcher.bat
│   ├── launcher.sh
│   └── README.md
├── FibonacciSpiralDotPattern/    ← 會被偵測到
├── PythonCPK/                    ← 會被偵測到
├── QrcodeGenerator/              ← 會被偵測到
└── VoltMatch/                    ← 會被偵測到
```

執行啟動器時，會掃描 `github/` 底下所有含有虛擬環境和 `.py` 檔案的資料夾。

When you run the launcher, it scans all folders in `github/` that contain a virtual environment and at least one `.py` file.

## 快速開始 / Quick Start

### Windows

直接雙擊 `launcher.bat`，或從 CMD/PowerShell 執行：

```bat
launcher\launcher.bat
```

### Linux / macOS

在終端執行：

```bash
./launcher/launcher.sh
```

如果沒有執行權限，先執行：

```bash
chmod +x launcher/launcher.sh
```

## 使用流程 / Workflow

啟動後，依次選擇要執行的專案和指令稿：

After launching, select the project and script you want to run:

**第一步：選擇專案 / Step 1: Select Project**

```
Select project folder:
  1) FibonacciSpiralDotPattern
  2) NP
  3) PythonCPK
  4) QrcodeGenerator
  5) VoltMatch
  6) rs232-vi-sequence-controller
  0) Exit
Choose:
```

**第二步：選擇指令稿 / Step 2: Select Script**

```
Select Python file:
  1) main.py
  2) app.py
  3) other_file.py
  0) Exit
Choose:
```

確認後，啟動器會用該專案的虛擬環境 Python 執行你選擇的指令稿。

The launcher will then execute the selected Python file using the project's virtual environment.

## 掃描規則 / Discovery Rules

### 哪些專案會被列出 / What Projects are Listed

啟動器只會列出同時符合以下條件的資料夾：

The launcher only lists folders that meet ALL these conditions:

- ✅ 含有 `.venv` 或 `venv` 虛擬環境資料夾
- ✅ 至少有一個 `.py` 檔案

Contains a `.venv` or `venv` folder AND at least one `.py` file.

### 指令稿排序 / Script Ordering

指令稿會按以下順序排列：

Scripts are ordered as follows:

1. `main.py` — 優先顯示 (Priority 1)
2. `app.py` — 次優先 (Priority 2)
3. 其他 `.py` 檔案 — 按字母順序 (Other `.py` files in alphabetical order)

## 建立虛擬環境 / Create Virtual Environment

如果新專案還沒有虛擬環境，可以手動建立：

If a project doesn't have a virtual environment yet, create one:

### Windows

```bat
py -m venv .venv
.venv\Scripts\python.exe -m pip install -r requirements.txt
```

### Linux / macOS

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

## 常見問題 / Troubleshooting

**Q: 為什麼我的專案沒有出現在選單？**

A: 請檢查專案資料夾是否同時具備：
- 虛擬環境資料夾（`.venv` 或 `venv`）
- 至少一個 `.py` 檔案

**Q: 如何在 Windows 和 Linux 上共用同一個專案？**

A: 不同平台的虛擬環境不相容。每個平台都需要單獨建立虛擬環境。建議在 `.gitignore` 中忽略 `.venv` 和 `venv` 資料夾，然後在各平台分別建立。

**Q: 啟動後提示找不到 Python？**

A: 該專案的虛擬環境可能是在不同的平台上建立的。請為目前使用的作業系統重新建立虛擬環境。

---

**Q: Why doesn't my project appear in the menu?**

A: Check that your project folder has both:
- A virtual environment folder (`.venv` or `venv`)
- At least one `.py` file

**Q: How do I share a project between Windows and Linux?**

A: Virtual environments are platform-specific. Create separate virtual environments on each platform. Add `.venv` and `venv` to `.gitignore`.

**Q: Python not found after launching?**

A: The virtual environment may have been created on a different OS. Recreate it for your current platform.

## 授權 / License

MIT License — 詳見 `LICENSE` 檔案 / See `LICENSE` file for details.
