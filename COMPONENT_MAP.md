# COMPONENT_MAP.md — launcher 不衰減知識庫

> - **Language and Encoding Standards**: All system files, code annotations, memory files (`LLM_MEMORY.md`), and handover logs for this project are uniformly encoded in **UTF-8** and **Traditional Chinese** by default.

## 0. 六十秒進入狀況

- **專案定位**：跨平台（Windows／Linux／macOS）Python 專案啟動器，以單一 Polyglot Batch/Bash 腳本 [run.cmd](run.cmd) 掃描上層目錄之 Python 專案與虛擬環境並互動執行。
- **建置指令**：無（純腳本工具）。
- **測試指令**：手動於 Windows（`cmd /c launcher\run.cmd`）與 Linux／macOS（`./launcher/run.cmd`）分別驗證；改動 Bash 區塊後必以 `cmd /c run.cmd < NUL` 實測 Windows 跳轉未壞。
- **程式碼慣例**：`run.cmd` 整檔維持 **LF 換行**；Bash 區塊（`:windows_start` 之前）嚴格 **ASCII-only**，禁放中文或任何非 ASCII 字元。

---

## 1. 專案結構與偵測契約

```
launcher/
├── AGENTS.md / CLAUDE.md / GEMINI.md
├── LLM_MEMORY.md / COMPONENT_MAP.md / README.md / LICENSE
├── .gitattributes / scripts/hooks/{pre-commit,commit-msg}
└── run.cmd                  ← Polyglot Batch/Bash 主啟動腳本（LF 換行）
```

- **專案偵測規則**：掃描 `launcher/` 的上層目錄，僅列出同時含 `.venv/` 或 `venv/` 且至少有 1 個 `.py` 檔之資料夾。
- **入口檔優先級**：`main.py` > `app.py` > `mani.py` > 其他 `.py`（單檔直接執行、命中優先檔自動執行、多檔顯示選單）。
- **虛擬環境路徑**：Windows `.venv\Scripts\python.exe`、Unix `.venv/bin/python`（跨平台不可共用，需各自重建）。

---

## 2. 已定案決策與不可破壞地雷（萃取自 `LLM_MEMORY.md` B1 與 `README.md`）

1. **維持單檔 Polyglot `run.cmd`**（B1 #1）：跨平台不拆雙檔，支援順序為 Python → HTML → Node.js → 其他（B1 #3）。
2. **🚨 Windows `cmd.exe` LF＋非 ASCII 跳轉崩潰（B1 #2）**：`run.cmd` 必須為 LF（否則 Bash heredoc `::WINDOWS_BLOCK` 比對失敗）；但在 LF 檔案下，Bash 區塊一旦出現中文或非 ASCII 字元，`cmd.exe` 解析 `goto :windows_start` 會算錯位置直接把 Bash 當 Batch 執行。解法：**`:windows_start` 之前嚴守純 ASCII**，`:windows_start` 之後的 Windows 區塊不限。
3. **🚨 Windows `cmd.exe` `goto` 迴圈內禁 `call :label`**：在會被 `goto` 往回重入的區段（如 `:project_menu`）內的 `for`/`if` 區塊若呼叫 `call :子標籤`，`cmd.exe` 會報「找不到指定的批次標籤」；一律改以 inline 邏輯實作（已移除 `:add_file`／`:add_file_if_exists`）。
4. **`core.hooksPath` 屬本機設定**：新 clone 或換機後須依 `AGENTS.md` §0 自檢確認 `core.hooksPath=scripts/hooks`。
