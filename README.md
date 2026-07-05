<!-- AI AGENTS: Read ./AGENTS.md first, then ./LLM_MEMORY.md.
     Do NOT write planning content into this file. -->

# Python 專案啟動器 / Python Project Launcher

一個跨平台的 Python 專案啟動工具，用單一 Polyglot 腳本支援 Windows、Linux 和 macOS。快速掃描並執行位於同目錄的多個 Python 專案。

A cross-platform Python project launcher that supports Windows, Linux, and macOS with a single Polyglot script. Quickly scan and run multiple Python projects in the same directory.

## 📋 功能特性 / Features

- ✅ **一個檔案，全平台支援** — 單一 `run.cmd` 同時相容 Windows Batch、Bash (Linux/macOS)
- ✅ **自動掃描虛擬環境** — 智能偵測 `.venv` 或 `venv` 資料夾
- ✅ **互動式選單** — 逐步引導選擇專案和執行檔案
- ✅ **優先級排序** — `main.py` > `app.py` > `mani.py` > 其他 `.py` 檔案
- ✅ **單檔自動執行** — 只有一個 Python 檔案時直接運行

## 🚀 快速開始 / Quick Start

### 前置準備 / Prerequisites

在 `launcher/` 的上層目錄（通常是 `github/`）中存放 Python 專案：

```
github/
├── launcher/                   ← 啟動器在這裡
│   └── run.cmd
├── project1/                   ← Python 專案 1
│   ├── .venv/
│   └── main.py
└── project2/                   ← Python 專案 2
    ├── .venv/
    └── app.py
```

### Windows

在 `github/` 目錄中直接雙擊 `launcher/run.cmd`，或從命令列執行：

```cmd
launcher\run.cmd
```

### Linux / macOS

在終端執行：

```bash
cd ~/path/to/github
./launcher/run.cmd
```

**第一次執行時，如果沒有執行權限：**

```bash
chmod +x ./launcher/run.cmd
```

## 📖 使用流程 / Workflow

### 第一步：選擇專案 / Step 1: Select Project

啟動器會掃描並列出所有符合條件的專案：

```
Select project folder:
  1) project1
  2) project2
  3) project3
  0) Exit
Choose:
```

### 第二步：選擇執行檔案 / Step 2: Select Python File

根據檔案優先級自動排序，或提供選單讓你選擇：

```
Select Python file:
  1) main.py
  2) app.py
  3) other_script.py
  0) Exit
Choose:
```

### 第三步：執行 / Step 3: Execute

啟動器會使用該專案的虛擬環境 Python 執行選定的檔案：

```
Running: /path/to/project/.venv/bin/python main.py
```

## 🔍 專案偵測規則 / Discovery Rules

啟動器只會列出同時符合以下條件的資料夾：

- ✅ 包含虛擬環境資料夾：`.venv/` 或 `venv/`
- ✅ 至少包含一個 `.py` 檔案

其他資料夾會被忽略。

### Python 檔案優先級 / Python File Priority

選擇要執行的 Python 檔案時，優先級依序為：

1. **main.py** — 優先顯示 (自動選擇)
2. **app.py** — 次優先 (自動選擇)
3. **mani.py** — 第三優先 (自動選擇)
4. 其他 `.py` 檔案 — 按字母順序排列

### 自動執行邏輯 / Auto-run Logic

- 如果專案只有 **一個** Python 檔案 → 直接執行，不顯示選單
- 如果存在 `main.py` / `app.py` / `mani.py` 之一 → 自動選擇並執行
- 其他情況 → 顯示選單讓使用者選擇

## 🛠️ 設置虛擬環境 / Setup Virtual Environment

### 初次設置 / Initial Setup

#### Windows

```cmd
cd project_folder
py -m venv .venv
.venv\Scripts\python.exe -m pip install -r requirements.txt
```

#### Linux / macOS

```bash
cd project_folder
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

### 名稱要求 / Naming Requirements

虛擬環境資料夾**必須**命名為 `.venv` 或 `venv`（其他名稱不會被識別）。

## ❓ 常見問題 / FAQ

### Q: 為什麼我的專案沒有出現在選單？

**A:** 檢查以下條件是否都滿足：

1. 專案資料夾位於 `launcher/` 的上層目錄
2. 資料夾內有 `.venv/` 或 `venv/` 虛擬環境
3. 資料夾內至少有一個 `.py` 檔案

### Q: 如何在 Windows 和 Linux 上使用同一個專案？

**A:** 虛擬環境是平台相關的，不相容。每個平台需要單獨建立虛擬環境：

1. 在 `.gitignore` 中新增 `.venv` 和 `venv`
2. 在 Windows 上執行虛擬環境設置
3. 在 Linux/macOS 上分別執行虛擬環境設置

### Q: Python not found / 找不到 Python

**A:** 虛擬環境可能是在不同作業系統上建立的。解決方法：

```bash
# 刪除舊環境
rm -rf .venv

# 為目前系統重建虛擬環境
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

### Q: 執行後沒有反應 / Script doesn't respond

**A:** 確保：

1. 在正確的目錄執行（`launcher/` 的上層目錄）
2. 檔案有執行權限（Linux/macOS 執行 `chmod +x ./launcher/run.cmd`）
3. Python 虛擬環境路徑正確

## 📁 目錄結構示例 / Directory Structure Example

```
github/
├── .git/
├── .gitignore
├── launcher/                   ← 啟動器專案
│   ├── .git/
│   ├── run.cmd            ← 主要執行檔
│   ├── LICENSE
│   └── README.md
│
├── FibonacciSpiralDotPattern/   ← 會被偵測到 ✓
│   ├── .venv/
│   ├── fibonacci_spiral.py
│   ├── requirements.txt
│   └── README.md
│
├── PythonCPK/                   ← 會被偵測到 ✓
│   ├── .venv/
│   ├── app.py
│   ├── DATA.csv
│   ├── requirements.txt
│   └── README.md
│
├── QrcodeGenerator/             ← 會被偵測到 ✓
│   ├── .venv/
│   ├── QrcodeGenerator.py
│   ├── requirements.txt
│   └── README.md
│
├── VoltMatch/                   ← 會被偵測到 ✓
│   ├── .venv/
│   ├── main.py
│   ├── config.py
│   ├── requirements.txt
│   └── README.md
│
└── inactive_project/            ← 不會出現 ✗
    ├── main.py                  (沒有虛擬環境)
    └── requirements.txt
```

## 🔧 技術細節 / Technical Details

### Polyglot 腳本實現

`run.cmd` 是一個混合腳本，同時相容兩種環境：

- **Windows 部分** — 標準 Windows Batch 指令
- **Unix 部分** — Bash/Shell 指令碼

檔案在 Windows 上被視為批次檔執行，在 Linux/macOS 上被 shell 解釋為腳本。

### 平台差異處理

| 項目 | Windows | Linux/macOS |
|-----|---------|-----------|
| 虛擬環境路徑 | `.venv\Scripts\python.exe` | `.venv/bin/python` |
| 路徑分隔符 | `\` | `/` |
| 指令語法 | Batch | Bash |
| 文件權限 | 自動 | 需設置執行權限 |

### ⚠️ 已知踩過的坑 / Known Pitfall

**現象：** 在 Windows 上執行 `run.cmd` 時，`cmd.exe` 沒有跳到 `:windows_start`，而是把 bash 區塊的內容當成 batch 指令執行，出現一堆亂碼與 `'xxx' 不是內部或外部命令` 的錯誤（即使 `goto :windows_start` 邏輯本身完全正確）。

**根因：** `run.cmd` 是 LF-only 換行的檔案。當 bash-only 區塊裡混有非 ASCII 字元（例如中文註解）時，`cmd.exe` 掃描 `goto`/label 的內部機制會被這個「LF 換行 + 多位元組字元」的組合搞混，導致它算錯檔案位置、從錯誤的地方開始執行，而不是直接跳到 Windows 區塊。

- 純 ASCII + LF：沒問題
- CRLF + 中文：沒問題（但把整檔轉成 CRLF 會讓 bash 那邊的 heredoc 結尾標記 `::WINDOWS_BLOCK` 比對失敗，等於是拆掉 polyglot 的另一半）
- **LF + 中文（或任何非 ASCII）同時存在：會炸**

**解法：** 保持整個檔案 LF 換行不變（bash heredoc 需要），但 bash-only 區塊裡的註解一律使用 ASCII（英文），不要放中文或其他非 ASCII 字元。Windows 區塊（`:windows_start` 之後）因為 cmd 已經在正確位置執行，不受此問題影響。

**如果之後又要在 bash 區塊加中文註解：** 記得先用 `cmd /c run.cmd < NUL` 之類的方式實測一次 Windows 分支還能不能正常跳轉，不要只用肉眼看語法對不對。

---

**現象：** 在 Windows 上，當專案資料夾沒有 `main.py`/`app.py`/`mani.py`、只有兩個以上其他 `.py` 檔案時，理應跳出「Select Python file」選單讓你選，但畫面卻直接印出：

```text
The system cannot find the batch label specified - add_file
```

（中文版 Windows 顯示為「找不到指定的批次標籤」），選單內容整個消失，不像 Linux/macOS 那邊「只有一個 .py 就自動跑、多個就給選單」的邏輯一樣正常運作。

**根因：** `:project_menu ... goto project_menu` 這個「往回跳」的主選單迴圈裡，包了一個 `for %%F in (...) do ( ... call :add_file ... )` 迴圈，在裡面用 `call :標籤` 呼叫子程式。這是 `cmd.exe` 一個很經典的 parser bug：只要 `call :label` 是寫在「會被 `goto` 往回重新進入」的區塊內的 `for` 迴圈裡，`cmd.exe` 對批次標籤的搜尋就會壞掉，直接噴「找不到標籤」，跟檔案本身找不找得到 `main.py` 完全無關。

**解法：** 把 `call :add_file` / `call :add_file_if_exists` 這兩層子程式呼叫拿掉，改成直接在 `for` 迴圈內 inline 累加 `FILE_COUNT` 和 `FILE_n` 變數，不再對外 `call`，就不會踩到這個 bug。（[run.cmd](run.cmd) 已修正，並移除了不再需要的 `:add_file_if_exists` / `:add_file` 標籤。）

**通則：** Windows batch 裡，只要某段程式碼「會被 `goto` 迴圈往回重入」，裡面的 `for`/`if` 區塊就盡量避免用 `call :子程式`，改成直接 inline 邏輯，比較不會踩到這類 parser 狀態錯亂的坑。

## 📜 授權 / License

MIT License — 詳見 [LICENSE](LICENSE) 檔案

---

**作者 / Author:** lee18-in  
**GitHub:** https://github.com/lee18-in/launcher  
**更新日期 / Last Updated:** 2026-06