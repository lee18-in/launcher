# LLM_MEMORY.md — 工作記憶(agent 讀寫;規則見 AGENTS.md,勿在此重複)

## A. 目前狀態(每次交接必更新)

- 目前階段: **[build]** 建置階段
- 最後更新: 2026-07-06 19:35 / 當時階段: [build]
- 最新 commit: `79ea2c7` 無MAIN.py 修復
- 進行中任務: 修復 Windows 批次檔相容性，支援多語言啟動
- 阻塞點: Python 虛擬環境跨平台檢查還沒做

## B. 規劃(規劃階段 [plan] 專屬區;狀態: 草稿 | 已定案)

### B1. 架構決策(已定案後鎖定,建置/維運階段不得改)

| # | 決策 | 理由 | 狀態 |
|---|------|------|------|
| 1 | 維持 Polyglot Batch/Bash 單檔 `run.cmd` | 跨平台無需複製或切換，用戶體驗最簡單 | 已定案 |
| 2 | LF 換行 + Bash 區塊 ASCII-only | Windows cmd.exe parser bug 規避（見 README ⚠️） | 已定案 |
| 3 | 多語言支援分階段推進（Python → HTML → Node.js → 其他） | 複雜度遞增，先驗證再擴展 | 已定案 |

### B2. 短期目標(本週)

- [ ] 完成 Python 虛擬環境跨平台檢查（預檢現有.venv是否與當前OS相容）
- [ ] 驗證 run.cmd 在 Windows/Linux/macOS 上的 polyglot 執行正確性
- [ ] 若遇到新的 polyglot bug，補充到 README 〈已知踩過的坑〉

### B3. 中期目標(本月)

- [ ] 實作 HTML 靜態網站啟動（偵測 `index.html`，用系統瀏覽器打開）
- [ ] Node.js 專案支援（偵測 `package.json`，執行 `npm start` / `yarn start`）
- [ ] 統一菜單界面，支援所有已實作的專案類型

### B4. 長期目標

- [ ] 第二階段：Go / Rust / PHP / Vue/React 支援（標準化檢測與啟動邏輯）
- [ ] 第三階段：Java / C++/C / Docker 支援（需更複雜的環境管理）
- [ ] 設定檔系統（`.launcher.config` 或每個專案自訂啟動方式）
- [ ] 智慧快取機制（加速已掃描的專案列表）
- [ ] 快捷鍵/快速訪問（例如 `launcher project-name` 直接跳過菜單）

## C. 交接日誌(只追加,不刪改;最新在最上,每筆一個小節)

### 2026-07-06 19:35 [maintain] 使用工具: Claude Code (Playbook v2 升級導入)

- 完成了什麼:
  - 升級 AGENTS.md 至 Playbook v2：添加 Playbook-Version 標記、交接日誌書寫規範、§2.1 Review Loop、修改 §4 含 Git Hook 說明、移除依專案填寫的 §5 並改為指向 LLM_MEMORY.md
  - 補充 LLM_MEMORY.md〈E. 專案技術脈絡〉區：搬遷舊 AGENTS.md §5 已填的建置指令、測試指令、程式碼慣例
  - 安裝 Git Hook：建立 scripts/hooks/pre-commit 與 commit-msg，啟用 core.hooksPath

- 下一個 agent 該做什麼:
  - 完成 Python 虛擬環境跨平台檢查功能（原進行中任務）
  - 驗證 polyglot run.cmd 在各平台的相容性
  - 如有新發現的 bug，補充到 README 〈已知踩過的坑〉

- 地雷警告: 無

### 2026-07-05 14:XX [build] 使用工具: Claude Code (初始化導入)

- 完成了什麼:
  - 導入 AI agent 工作流系統（AGENTS.md / LLM_MEMORY.md / CLAUDE.md / GEMINI.md）
  - 將 README.md 中的規劃內容（第一～三階段、架構改進、未來功能）搬遷至 LLM_MEMORY.md §B
  - 在 README.md 頂端插入 AI 導引註解

- 下一個 agent 該做什麼:
  - 完成 Python 虛擬環境跨平台檢查功能
  - 驗證 polyglot run.cmd 在各平台的相容性
  - 如有新發現的 bug，補充到 README 〈已知踩過的坑〉

- 地雷警告: 無

## D. 已封存結論(自〈交接日誌〉搬入,唯讀)

（暫無封存內容）

## E. 專案技術脈絡(依專案填寫,agent 得隨專案實況更新,保持精簡)

- **建置指令**: N/A （本專案本身為啟動工具，無需構建）
- **測試指令**: 手動測試 `./run.cmd`（於 Windows/Linux/macOS 分別驗證）
- **程式碼慣例**: 
  - Polyglot Batch/Bash 混合腳本（`run.cmd`）
  - 整檔 LF 換行（勿改為 CRLF）
  - **Bash 區塊的註解與字串必須為 ASCII**，禁止中文或非 ASCII 字元（見 README ⚠️ 已知踩過的坑）
  - Windows 區塊（`:windows_start` 後）可自由使用任何字元
