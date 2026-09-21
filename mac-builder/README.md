# Mac 本機 App 建置說明

此建置包供擁有者私人使用。它會在你的 Mac 上從可檢查的 Python 原始碼建立 `全能下載王.app`，並做本機臨時簽章；不會取得 Apple Developer 身分，也不是 Apple 公證版本。

## 使用前

1. 安裝 Python 3.11 以上，需包含 Tkinter。建議使用 python.org 的 Mac 安裝包。
2. 完整解壓縮此 ZIP。
3. 用文字編輯器檢查 `Build-Mac-App.sh` 與 Python 原始碼；確認內容後才執行。

## 建置

在「終端機」進入解壓縮後的資料夾，執行：

```bash
bash Build-Mac-App.sh
```

首次建置需要網路安裝 Python 套件。完成後 Finder 會顯示 `dist` 資料夾，日常使用請開啟其中的 `全能下載王.app`。

若建置腳本停止，請保留終端機完整錯誤訊息。不要停用 Gatekeeper，也不要執行移除 quarantine 屬性的指令。

## 限制

- App 只適合在執行建置的同一台 Mac 私人使用。
- 未經 Apple 公證，不保證複製到另一台 Mac 後仍能開啟。
- 建置出的 App 體積會明顯大於原本的 Mac 啟動包，因為包含 Python、Tk、FFmpeg 與相依套件。
- 若需要公開發布給其他人，仍需 Apple Developer ID 簽署與 Apple 公證。

