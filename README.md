
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

---

## 🚀 路線圖 / Roadmap

### 短期優化方向 / Short-term

#### 1. 自動偵測執行 main.py

**目標：** 改善單一指令稿專案的使用體驗

- 若專案只有 `main.py`，直接執行（跳過選單）
- 若有 `main.py` + 其他檔案，提供快捷選項
  - 選單中優先顯示 `[Auto] main.py`
  - 按 Enter 快速執行 main.py

**實現難度：** ⭐ 低

**預期效果：** 減少重複選擇操作，加快啟動速度

---

#### 2. HTML 靜態專案支援

**目標：** 擴展至 Web 前端專案

**實現方案（階段性）：**

**Phase 1：靜態 HTML 支援**
- 偵測條件：資料夾內有 `index.html` 或任意 `*.html`
- 啟動方式：用系統預設瀏覽器打開 `index.html`
- 無需虛擬環境檢查

**Phase 2：進階支援（後期可考慮）**
- Node.js 專案：偵測 `package.json`，執行 `npm start`
- Python HTTP Server：偵測特定配置檔，啟動後自動開啟瀏覽器

**實現難度：** Phase 1 ⭐ 低 | Phase 2 ⭐⭐⭐ 中高

**預期效果：** 統一管理 Python + Web 專案，一個工具支援多類型開發

---

### 建議優先順序 / Priority Order

| 優先級 | 功能 | 預計工時 | 難度 |
|------|------|---------|------|
| 1 | 自動執行 main.py | 1-2 小時 | ⭐ |
| 2 | HTML 靜態支援 | 2-3 小時 | ⭐⭐ |
| 3 | Node.js 專案支援 | 2-3 小時 | ⭐⭐ |
| 4 | Shell Script / Ruby 支援 | 2-3 小時 | ⭐⭐ |
| 5 | 搜尋/篩選功能 | 3-4 小時 | ⭐⭐ |
| 6 | 設定檔支援 (`.launcher.config`) | 4-5 小時 | ⭐⭐⭐ |
| 7 | 記憶上次選擇 | 2-3 小時 | ⭐⭐ |

---

### 支援的語言和框架 / Supported Languages & Frameworks

#### 第一階段（易於快速支援）

| 語言/框架 | 偵測方式 | 啟動命令 | 難度 | 備註 |
|---------|--------|--------|------|------|
| **Python** ✅ | `.venv` / `venv` | `python script.py` | ⭐ | 已支援 |
| **HTML** 🔜 | `index.html` / `*.html` | 系統瀏覽器打開 | ⭐ | 即將支援 |
| **Node.js** 🔜 | `package.json` | `npm start` / `yarn start` | ⭐⭐ | 計劃支援 |
| **Shell Script** 🔜 | `*.sh` / `*.bash` | `bash script.sh` | ⭐ | 計劃支援 |
| **Ruby** 🔜 | `Gemfile` | `ruby main.rb` | ⭐⭐ | 計劃支援 |

#### 第二階段（中等複雜度）

| 語言/框架 | 偵測方式 | 啟動命令 | 難度 | 備註 |
|---------|--------|--------|------|------|
| **Go** | `main.go` / `go.mod` | `go run main.go` | ⭐⭐ | 後續擴展 |
| **Rust** | `Cargo.toml` | `cargo run` | ⭐⭐ | 後續擴展 |
| **PHP** | `index.php` / `composer.json` | `php -S localhost:8000` | ⭐⭐ | 後續擴展 |
| **Vue/React** | `package.json` + `vite.config` | `npm run dev` | ⭐⭐ | 後續擴展 |

#### 第三階段（高複雜度）

| 語言/框架 | 偵測方式 | 啟動命令 | 難度 | 備註 |
|---------|--------|--------|------|------|
| **Java** | `pom.xml` / `build.gradle` | `mvn spring-boot:run` | ⭐⭐⭐ | 遠期規劃 |
| **C/C++** | `Makefile` / `CMakeLists.txt` | `make run` | ⭐⭐⭐ | 遠期規劃 |
| **Docker** | `Dockerfile` / `docker-compose.yml` | `docker-compose up` | ⭐⭐⭐ | 遠期規劃 |

---

### 架構改進計畫 / Architecture Improvements

為了支援多種語言，計畫實現以下架構改進：

**1. 專案類型檢測系統**
```bash
project_type() {
  if [[ -f "$1/package.json" ]]; then echo "node"
  elif [[ -f "$1/Gemfile" ]]; then echo "ruby"
  elif [[ -f "$1/go.mod" ]]; then echo "go"
  elif [[ -f "$1/Cargo.toml" ]]; then echo "rust"
  elif [[ -f "$1/.venv" || -d "$1/venv" ]]; then echo "python"
  elif [[ -f "$1/index.html" ]]; then echo "html"
  fi
}
```

**2. 統一啟動邏輯**
- 根據專案類型自動選擇啟動命令
- 統一的菜單界面，支援所有專案類型
- 智能檔案偵測（每種語言的主檔案優先級）

**3. 跨平台相容性**
- Windows (`.bat`) 和 Linux/macOS (`.sh`) 均支援
- 自動選擇平台相適應的虛擬環境路徑
- 平台特定的啟動命令適配

---

### 衍生改進想法 / Future Enhancements

**核心體驗改進**
- 🔹 **OS 智慧適配**：自動根據當前作業系統選擇虛擬環境路徑
- 🔹 **快取機制**：加速已掃描的專案列表重新載入
- 🔹 **詳細除錯資訊**：指令稿執行失敗時提供更多診斷訊息
- 🔹 **跨平台虛擬環境檢查**：偵測 `.venv` 是否與當前 OS 相容

**多語言支援**
- 🔹 **共通檔案偵測**：對每種語言自動偵測主檔案（`main.py`、`index.js`、`Main.java` 等）
- 🔹 **依賴檢查**：執行前檢查必要的工具/環境是否已安裝
- 🔹 **自訂啟動命令**：允許透過 `.launcher.config` 自訂各類型專案的啟動方式

**使用者體驗**
- 🔹 **快捷鍵支援**：快速訪問常用專案（例如 `launcher project-name`）
- 🔹 **收藏夾功能**：標記常用專案以便快速存取
- 🔹 **最近使用記錄**：記住上次選擇的專案和檔案

---

## 開發進度追蹤 / Development Progress

### v1.0（已發佈）
- ✅ Python 專案自動偵測
- ✅ 虛擬環境自動選擇
- ✅ 互動式菜單
- ✅ 跨平台支援 (Windows, Linux, macOS)

### v1.1（計劃中）
- 🔜 自動執行 main.py
- 🔜 HTML 靜態網站支援
- 🔜 Node.js 專案支援

### v2.0（未來規劃）
- 🔲 多語言完整支援（Shell, Ruby, Go, Rust, PHP）
- 🔲 設定檔系統
- 🔲 智慧快取機制
- 🔲 快捷鍵/快速訪問
