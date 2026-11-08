# noti-toasti-windows

A [Claude Code](https://claude.ai/code) plugin that generates native Windows Toast (Banner) notifications with audio alerts whenever Claude Code requires user input, permission, or wants to notify you.

Designed specifically for **Windows** and **WSL (Windows Subsystem for Linux)**.

---

## Features

- 🔔 **Native Windows Toast Notifications**: Displays Windows 10/11 banner notifications via the WinRT `ToastNotificationManager` API.
- 🔊 **Sound Alert**: Plays the default Windows notification chime (`Notification.Default`).
- 🐧 **WSL & Windows Compatible**: Seamlessly converts Linux paths inside WSL to Windows paths using `wslpath -w` and calls Windows `powershell.exe`.
- 🏷️ **Context-Aware Titles**: Displays your project name and session name (set via `/rename` or `--name`) or session ID in the notification header.

---

## Requirements

- **Operating System**: Windows 10 / 11, or WSL (Ubuntu, Debian, openSUSE, etc. running on Windows).
- **PowerShell**: `powershell.exe` available in the PATH.

---

## Installation

### Via Marketplace

1. Add the marketplace to Claude Code:
   ```bash
   /plugin marketplace add shaikh-imran/s10i-claude-plugins
   ```

2. Install the plugin:
   ```bash
   /plugin install noti-toasti-windows@s10i-claude-plugins
   ```

### Local / Development

To install or test directly from this repository:
```bash
/plugin install ./plugins/noti-toasti-windows
```

---

## How It Works

1. Claude Code triggers the `Notification` hook event whenever user attention is needed (e.g. tool permission requests or idle state).
2. The hook executes:
   ```bash
   p="${CLAUDE_PLUGIN_ROOT}/scripts/noti-toasti-windows.ps1"; command -v wslpath >/dev/null 2>&1 && p="$(wslpath -w "$p")"; powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$p"
   ```
3. If running in WSL, `wslpath -w` translates the script path to Windows format (e.g., `\\wsl$\...`).
4. `powershell.exe` reads the JSON event payload from `stdin`, extracts the project directory, session ID, and session title, and displays a native WinRT toast notification with sound.

---

## File Structure

```text
noti-toasti-windows/
├── .claude-plugin/
│   └── plugin.json                     # Plugin manifest
├── hooks/
│   └── hooks.json                      # Hook configuration for Claude Code
├── hook.json                           # Hook definition
├── scripts/
│   └── noti-toasti-windows.ps1         # PowerShell toast notification script
└── README.md
```

---

## License

MIT
