# LLM_MEMORY.md — 工作記憶(agent 讀寫;規則見 AGENTS.md,勿在此重複)

> - **Language and Encoding Standards**: All system files, code annotations, memory files (`LLM_MEMORY.md`), and handover logs for this project are uniformly encoded in **UTF-8** and **Traditional Chinese** by default.

## A. 目前狀態(每次交接必更新)

- 目前階段: **[build]** 建置階段
- 最後更新: 2026-11-27 21:45 / 當時階段: build
- 交接基準 commit: 9be0628 [maintain] 依 §2.1 記錄使用者簽結並更新交接基準
- 進行中任務: 修復 Windows 批次檔相容性，支援多語言啟動
- 阻塞點: Python 虛擬環境跨平台檢查還沒做（v12／v13 已於 2026-11-18 19:39 由使用者簽結）；2026-11-23 17:00 待審下壓（基準 `9be0628..f06eec4`）：核對補建 `COMPONENT_MAP.md` 完整收錄 Polyglot 契約與兩項 `cmd.exe` 地雷。
    - 完成了什麼: 依 user「推 全倉 套WF」將本 dir `AGENTS.md` 自 Online v16 整份覆蓋升至 v17（§5 禁假優缺點＋§1 `[build]` PDCA Act 閉環；無模板外自訂規則；覆蓋前 hash `8d8635a`）；原首筆待審依 §0 下壓入〈阻塞點〉並守原交接基準。為何改：全 8 倉同步 Online v17 憲法（D41）。
    - 驗證方式: `head -n 2 AGENTS.md` 為 `Playbook-Version: 17`/`Playbook-Variant: online`，全文 `12,791 B`/93 行與母倉逐 byte 一致；日誌 `<10 KB`、本檔 `<16 KB`、本筆 `<=1200 B`。
    - 下一個 agent 該做什麼: 本次改動需要審閱：`git diff 9be0628..HEAD` 核對 Online v17 條文一致且 A 區進行中任務未改寫。等待 new session（或 `/clear` 清空 context，建議換模型）審閱。
    - 地雷警告: 依 user 明示同步後 push；依 §2.1 本 context 禁自審。
  - 2026-11-27 14:50 需要審閱（基準 `9be0628..HEAD`）：
    ### 2026-11-27 14:50 [build] Antigravity (Gemini 4 Neon)

    - 完成了什麼: 依 user「開工 做完再推」將本倉全部工作流同步至 Online v19（D45 純憲法同步免寫記憶）並更新 `scripts/hooks/pre-commit`；依 user 指示清理 v10～v18 純升版洗版日誌與假下壓（保留全部實質專案紀錄與待審）。
    - 驗證方式: `AGENTS.md`（13,590 B/95L）與 `scripts/hooks/pre-commit` 與母倉逐 byte 一致；`workflow_scan` v19 clean、`check_hooks` OK、記憶檔全合規。
    - 下一個 agent 該做什麼: 本次改動需要審閱：核對 `scripts/hooks/pre-commit` 與記憶清理未傷任何專案待審（日後純同步憲法不再觸碰記憶檔）。等待 new session 審閱。
    - 地雷警告: 依 user 明示驗證後推送（D42，push≠審結）；禁自審。
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

### 2026-11-27 21:45 [build] Antigravity (Gemini 4 Hydrogen)

- 完成了什麼: 依 `1A` 從母倉(`36e5a6a`)同步修復 macOS Bash 3.2.57 相容之 `scripts/hooks/pre-commit`（抽 `is_exempt_const_file()`），依 §0 下壓 `14:50` 待審入〈阻塞點〉並守原基準 `9be0628`。為何改：修 macOS `/bin/sh` 語法錯。
- 驗證方式: `cmp -s` 與母倉 `pre-commit` 一致(6,143 B)；`/bin/sh -n` 過；`hooksPath=scripts/hooks`；`<16KB`/`<10KB`/`<=1200B`。
- 下一個 agent 該做什麼: 本次改動需要審閱：`git diff 473ded5..HEAD -- scripts/hooks/pre-commit` 核與母倉一致並併審〈阻塞點〉。等待 new session（或 `/clear` 清空 context）審閱。
- 地雷警告: 依 1A 帶待審推遠端(D42，push≠審結)；禁自審。

### 2026-11-27 14:50 [build] Antigravity (Gemini 4 Neon)

- 完成了什麼: 依 user「開工 做完再推」將本倉全部工作流同步至 Online v19（D45 純憲法同步免寫記憶）並更新 `scripts/hooks/pre-commit`；依 user 指示清理 v10～v18 純升版洗版日誌與假下壓（保留全部實質專案紀錄與待審）。
- 驗證方式: `AGENTS.md`（13,590 B/95L）與 `scripts/hooks/pre-commit` 與母倉逐 byte 一致；`workflow_scan` v19 clean、`check_hooks` OK、記憶檔全合規。
- 下一個 agent 該做什麼: 本次改動需要審閱：核對 `scripts/hooks/pre-commit` 與記憶清理未傷任何專案待審（日後純同步憲法不再觸碰記憶檔）。等待 new session 審閱。
- 地雷警告: 依 user 明示驗證後推送（D42，push≠審結）；禁自審。

### 2026-11-23 17:00 [build] 使用工具: Antigravity

- 完成了什麼: 依使用者 2A 補建 `COMPONENT_MAP.md`（遷移舊 E 區、B1 決策及 `README.md` 兩項 Windows `cmd.exe` 硬地雷：LF+非 ASCII 跳轉崩潰、`goto` 迴圈禁 `call :label`），啟用本機 `core.hooksPath=scripts/hooks` 並覆蓋基準 `9be0628`；未改腳本。為何改：補齊 v13 三檔。
- 驗證方式: `git config --get core.hooksPath`=`scripts/hooks`；對讀 `README.md` 與 `LLM_MEMORY.md`；`python3` 驗本筆 `<1200 B`、C 區 `<10 KB`、`COMPONENT_MAP <16 KB`。
- 下一個 agent 該做什麼: 本次改動需要審閱：核對 `COMPONENT_MAP.md` 完整收錄 Polyglot 契約與兩項 `cmd.exe` 地雷。等待 `new session` 審閱。
- 地雷警告: 接手自檢原 `core.hooksPath` 空，已設 `scripts/hooks` 並 `chmod +x`；僅本地提交未 `push`。

## D. 已封存結論(自〈交接日誌〉搬入,唯讀)

- 2026-07-05～11-18 19:39（均已簽結，契約與 `cmd.exe` 地雷已收錄 `COMPONENT_MAP.md`）：導入 Playbook v2（搬出 README 規劃、裝 Git Hook）→v9（`e9d936b`，補 `.gitattributes` LF、啟用 `core.hooksPath`、遷移交接基準）→v10→v11（`8155628`）→v12（`22ec5bb`）→v13（`21fa02a`，11-18 19:39 使用者簽結）。

## E. 專案技術脈絡

（已於 2026-11-23 依 AGENTS.md §5 移入 [COMPONENT_MAP.md](COMPONENT_MAP.md)）
