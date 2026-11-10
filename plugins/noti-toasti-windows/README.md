# noti-toasti-windows

Native Windows toast notifications with sound when Claude Code needs your attention.

Works on both Windows and WSL.

## Features

- 🔔 Windows 10/11 toast banners via WinRT `ToastNotificationManager`
- 🔊 Default Windows notification sound
- 🐧 WSL-compatible — auto-converts paths via `wslpath`
- 🏷️ Shows project name and session title in the notification header

## Requirements

- Windows 10/11 or WSL
- `powershell.exe` in PATH

## Install

```bash
/plugin marketplace add shaikh-imran/s10i-claude-plugins
/plugin install noti-toasti-windows@s10i-claude-plugins
```

Local:
```bash
/plugin install ./plugins/noti-toasti-windows
```

## How It Works

1. Claude Code fires the `Notification` hook when user input is needed.
2. The hook runs the PowerShell script, translating paths via `wslpath` if in WSL.
3. PowerShell reads the JSON payload from stdin, extracts project/session info.
4. Displays a native WinRT toast notification with sound.

## File Structure

```
noti-toasti-windows/
├── .claude-plugin/plugin.json
├── hooks/hooks.json
├── scripts/noti-toasti-windows.ps1
└── README.md
```

## License

MIT
