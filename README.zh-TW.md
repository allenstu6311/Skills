# Skills

[English](README.md) | [繁體中文](README.zh-TW.md)

可安裝並跨專案共用的 agent skills 集合。

## 安裝

需要 Node.js、npm 與 Git。在任何目錄執行以下指令，即可將全部 skills 全域安裝給 Codex：

```sh
npx skills add allenstu6311/Skills --skill '*' -g -a codex
```

全域安裝後，同一使用者帳號下的不同專案都能使用，不需要逐一複製到專案中。若要透過互動選單選擇其他支援的 agent，省略 `-a codex` 即可。

只安裝需求整理 skill：

```sh
npx skills add allenstu6311/Skills --skill requirements-to-domain -g -a codex
```

只查看可安裝的 skills，不進行安裝：

```sh
npx skills add allenstu6311/Skills --list
```

在 Windows PowerShell 中，若執行原則阻擋 `npx.ps1`，請將 `npx` 改為 `npx.cmd`。

## Skills 清單

| Skill | 使用時機 |
| --- | --- |
| [requirements-to-domain](requirements-to-domain/SKILL.md) | 將零散的軟體需求整理、釐清為可供後續 OOAD 使用的需求規格。 |
| [domain-to-ooad](domain-to-ooad/SKILL.md) | 明確要求根據需求產生可編輯的 draw.io 類別圖、循序圖或活動圖。 |
| [code-fault-tree](code-fault-tree/SKILL.md) | 從使用者操作出發，根據程式碼追查故障症狀、原因與實際處理方式。 |
| [design-decision](design-decision/SKILL.md) | 評估目前的程式變更是否值得採用設計模式，或討論、審查設計模式的選擇。 |

## 更新

從已發布的來源更新安裝過的 skills：

```sh
npx skills update
```

從 GitHub 安裝時，取得的是儲存庫上已發布的版本。本機修改必須提交並推送後，其他地方才能下載到；已安裝的 skills 不會自動跟隨這份本機目錄的修改。

## 本機開發

在此儲存庫目錄中，確認 CLI 能找到哪些 skills：

```sh
npx skills add . --list
```

每個 skill 都有自己的目錄，內含 `SKILL.md` 與需要的參考資料。請將參考資料保留在該 skill 目錄內，讓它可以獨立安裝。

安裝方式與指令選項請參閱 [skills CLI 文件](https://github.com/vercel-labs/skills)。

## 儲存庫維護

修改 skills 或安裝方式後，請依最終變更檢查 README.md 與 README.zh-TW.md，同步更新受影響的 skill 清單、使用說明、連結、必要工具或指令。英文與繁體中文版應保持一致。若只有內部調整，而文件仍正確，則不必修改 README。

這是文件維護慣例，並非自動執行的 hook 或 CI 檢查。
