# Skills

[English](README.md) | [繁體中文](README.zh-TW.md)

可跨專案重用的 agent skills 與共用合作原則。Skills 依各自設定，在相關任務中載入或只能由明確指令觸發；共用規則在每次工作階段開始時提供指引。兩者分開安裝。

## 儲存庫結構

```text
rules/collaboration.md           共用英文規則的唯一來源
scripts/Install-Rules.ps1        個人層級規則安裝程式
<skill-name>/SKILL.md            可獨立安裝的 skills
README.md / README.zh-TW.md      英文／繁體中文說明
```

共用規則不再以根目錄 CLAUDE.md 或 AGENTS.md 範本保存，因此不需要用範本覆寫既有專案的指示檔。

## 安裝 skills

需要 Node.js 22.20 以上、npm 與 Git。將全部 skills 全域安裝給 Claude Code 與 Codex：

```sh
npx skills add allenstu6311/Skills --skill '*' -g -a claude-code -a codex
```

全域安裝後，同一帳號的不同專案皆可使用。只保留 `-a codex` 或 `-a claude-code` 可指定單一 agent；省略 agent 參數則以互動選單選擇。省略 `-g` 則安裝到目前專案。

只安裝一個 skill，或預覽清單而不安裝：

```sh
npx skills add allenstu6311/Skills --skill requirements-to-domain -g -a codex
npx skills add allenstu6311/Skills --list
```

在 Windows PowerShell 中，若執行原則阻擋 `npx.ps1`，改用 `npx.cmd`。這些指令只安裝 skills，不會安裝 `rules/collaboration.md`。

## 安裝共用規則

每台電腦只需下載一次此儲存庫，再用 PowerShell 5.1 以上執行：

```powershell
git clone https://github.com/allenstu6311/Skills.git
Set-Location Skills
.\scripts\Install-Rules.ps1 -Agent both
```

使用 `-Agent claude-code` 或 `-Agent codex` 可只安裝給單一 agent；加上 `-WhatIf` 可預覽寫入操作。若 Windows 阻擋腳本，先閱讀內容，再以只對本次程序生效的方式執行：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\Install-Rules.ps1 -Agent both
```

| Agent | 預設安裝位置 | 既有內容處理方式 |
| --- | --- | --- |
| Claude Code | `~/.claude/rules/allenstu-collaboration.md` | 保留個人 CLAUDE.md 與其他規則；此目標檔內容有變時，先備份再更新。 |
| Codex | `~/.codex/AGENTS.md` | 新增受管理區塊，之後只更新該區塊；保留區塊外內容，檔案有變時先備份。 |

`~` 代表使用者家目錄。腳本遵循 `CLAUDE_CONFIG_DIR` 與 `CODEX_HOME`，也可用 `-ClaudeHome`、`-CodexHome` 指定其他位置。它不會修改專案檔案。新舊專案在開啟新的 agent 工作階段時都會載入個人規則；專案指示仍會一起載入，兩者應保持一致。

非空的全域 `AGENTS.override.md` 會優先於 Codex 的 AGENTS.md。若存在該覆寫檔，腳本會拒絕 Codex 安裝步驟；同時安裝兩者時，Claude 步驟可能已經完成。

### 從舊版本遷移

若先前已將這份原則複製到個人 CLAUDE.md 或 AGENTS.md，安裝後請檢查並只移除重複的段落，保留其他指示。腳本不會自動刪除或翻譯舊文字；若 Codex AGENTS.md 恰好就是相同的英文原則，則會直接加上管理標記，避免重複。

解除安裝時，移除 Claude 的 `allenstu-collaboration.md`，以及／或僅刪除 Codex 檔案中 `<!-- allenstu6311/Skills:begin -->` 到 `<!-- allenstu6311/Skills:end -->` 的區塊。備份保存在被修改檔案旁，副檔名為 `.bak`。

## Skills 清單

| Skill | 使用時機 |
| --- | --- |
| [requirements-to-domain](requirements-to-domain/SKILL.md) | 將零散的軟體需求釐清為可供後續 OOAD 使用的需求規格。 |
| [domain-to-ooad](domain-to-ooad/SKILL.md) | 明確要求根據需求產生指定組合、可編輯的 draw.io 類別圖、循序圖或活動圖；需要相容的 draw.io 工具。 |
| [code-fault-tree](code-fault-tree/SKILL.md) | 從操作出發，根據程式碼追查故障症狀、原因與實際處理方式。 |
| [design-decision](design-decision/SKILL.md) | 在相關程式變更點評估設計模式取捨，或討論、審查設計模式的選擇。 |
| [discuss-architecture](discuss-architecture/SKILL.md) | 根據系統證據評估責任邊界、狀態歸屬、依賴、生命週期與遷移取捨。 |
| [update-domain-notes](update-domain-notes/SKILL.md) | 只能明確指令觸發；先確認主題、程式範圍與 CLAUDE.md 寫入位置，再記錄已確認決策及已查證的領域邏輯與資料流。 |

## 按需更新領域筆記

此 skill 只能用明確指令執行，不會在討論或修改程式後自動啟用：

- Claude Code：`/update-domain-notes`
- Codex：`$update-domain-notes`

每次執行都會先請你確認主題、程式範圍，以及確切的 CLAUDE.md 寫入位置。即使指令參數已指定三者，仍會等你確認後才深入讀碼或寫檔；不沿用上次執行的確認。接著更新指定檔案，或建立你已同意但尚不存在的檔案，保留其他內容。對話很長時，不會預設全部納入。

筆記整理已查證的現有邏輯、資料流、重要限制，以及已確認且理由有依據的決策。缺少理由就標示未知，已接受但未實作的方向與現有程式分開記錄。此指令只更新專案筆記；不會順便實作、修改全域規則、建立 Codex AGENTS.md 入口或提交推送，除非另有明確要求。既有筆記保留原語言；新筆記預設使用你的語言。

CLAUDE.md 預設依下列順序組織：

1. 領域目的與責任邊界。
2. 核心概念。
3. 主要流程與資料流。
4. 模組分工與狀態歸屬。
5. 必須維持的規則與限制。
6. 已確認決策：選擇、理由與代價。
7. 修改入口、驗證方式與待確認事項。

可合併相關章節，或省略沒有實質內容的章節，不必填滿七個標題、重複資訊或編造缺漏事實。更新既有筆記時保留有用的組織方式與其他指示，不為了套用架構而整份重寫。只能指令觸發及三項範圍確認流程維持不變。

手動觸發限制分別設定於 Claude 的 frontmatter `disable-model-invocation: true`，以及 Codex 的 `agents/openai.yaml` 內 `policy.allow_implicit_invocation: false`。安裝時請保留完整 skill 目錄（包含 `agents/`），才能保留 Codex 的限制。共用規則安裝腳本不會安裝此 skill。發布後若只要安裝這一個 skill：

```sh
npx skills add allenstu6311/Skills --skill update-domain-notes -g -a claude-code -a codex
```

## 更新與本機開發

從已發布的來源更新全域安裝的 skills：

```sh
npx skills update -g
```

共用規則另外在此儲存庫目錄中更新：

```powershell
git pull
.\scripts\Install-Rules.ps1 -Agent both
```

從 GitHub 安裝 skill 時，取得的是儲存庫上已發布的版本。本機修改必須提交並推送後才能供其他地方下載。已安裝的副本與規則不會自動跟隨此目錄的修改；更新後請重新執行對應安裝程序。

預覽本機修改的 skills 而不安裝：

```sh
npx skills add . --list
```

每個 skill 的參考資料都保留在自己的目錄內。Skill 指示與共用規則使用英文撰寫；輸出語言依使用者請求與各 skill 的規範決定。

## 儲存庫維護

修改 skills 或安裝方式後，請依最終變更檢查中英文 README，同步更新 skill 清單、適用範圍、必要工具、連結與指令。若只有內部調整且文件仍正確，不必修改 README。這是維護慣例，並非自動執行的 hook 或 CI 檢查。

參考文件：[skills CLI](https://github.com/vercel-labs/skills)、[Claude 記憶與規則](https://code.claude.com/docs/en/memory)、[Codex AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md)。
