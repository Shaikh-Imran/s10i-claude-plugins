# noti-toasti-mac

A [Claude Code](https://claude.ai/code) plugin that generates native macOS Notification Center alerts with audio chimes whenever Claude Code requires user input, permission, or wants to notify you.

Designed specifically for **macOS**, featuring full context awareness including the **agent name** and the **agent path / working directory**.

---

## Features

- 🔔 **Native macOS Notifications**: Displays macOS banner notifications directly in Notification Center via Apple's Scripting Bridge / JavaScript for Automation (JXA).
- 🔊 **Sound Alert**: Plays native macOS alert sounds (`Glass` by default, customizable to any system sound like `Ping`, `Submarine`, `Hero`, etc.).
- 🧭 **Agent & Path Context**: Automatically extracts and displays:
  - **Agent Name**: Identifies active agent or session name (from payload, `--name`, or `/rename`).
  - **Agent Path**: Displays the full working directory (`cwd`) where the agent is running.
  - **Project Name**: Shows the project directory name in the title/subtitle.
  - **Event Reason**: Summarizes the alert (e.g. tool execution permission required, idle prompt waiting for input).
- ⚡ **Zero External Dependencies**: Uses built-in macOS tools (`osascript`, `/bin/bash`). No Homebrew, `jq`, Python, or Node required.

---

## Requirements

- **Operating System**: macOS 10.10 (Yosemite) or newer (including macOS 11 Big Sur, 12 Monterey, 13 Ventura, 14 Sonoma, 15 Sequoia, and beyond).
- Notification permissions enabled for your terminal (Terminal, iTerm2, Ghostty, Alacritty, VS Code, etc.) or Script Editor in **System Settings > Notifications**.

---

## Installation

### Via Marketplace

1. Add the marketplace to Claude Code:
   ```bash
   /plugin marketplace add shaikh-imran/s10i-claude-plugins
   ```

2. Install the plugin:
   ```bash
   /plugin install noti-toasti-mac@s10i-claude-plugins
   ```

### Local / Development

To install or test directly from this repository:
```bash
/plugin install ./plugins/noti-toasti-mac
```

---

## How It Works

1. Claude Code triggers the `Notification` hook event whenever user attention is required (e.g., tool execution confirmation or idle prompts).
2. The hook executes:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/noti-toasti-mac.sh"
   ```
3. The script reads the JSON hook payload from `stdin`, extracts the agent name, project directory, session ID, and notification message.
4. It calls `osascript` with JavaScript for Automation to display a native notification with sound and rich context:
   - **Title**: `Claude Code [Agent / Session Name]`
   - **Subtitle**: `Project Name`
   - **Body**:
     ```text
     [Action required / notification message]
     Agent: <agent-name>
     Path: <agent-working-directory-path>
     ```

---

## Configuration

You can customize the notification sound by setting environment variables in your shell configuration (`~/.zshrc` or `~/.bashrc`):

- **`CLAUDE_NOTI_SOUND`**: The system sound name to play (default: `Glass`). Options include `Ping`, `Hero`, `Submarine`, `Blow`, `Bottle`, `Pop`, `Morse`, `Purr`, `Sosumi`, `Tink`, `Basso`.
  ```bash
  export CLAUDE_NOTI_SOUND="Ping"
  ```
- **`CLAUDE_NOTI_AFPLAY`**: Set to `1` to also play audio directly via `/usr/bin/afplay` in addition to the notification chime.
  ```bash
  export CLAUDE_NOTI_AFPLAY=1
  ```

---

## File Structure

```text
noti-toasti-mac/
├── .claude-plugin/
│   └── plugin.json                     # Plugin manifest
├── hooks/
│   └── hooks.json                      # Hook configuration for Claude Code
├── hook.json                           # Hook definition
├── scripts/
│   └── noti-toasti-mac.sh              # macOS notification script
└── README.md
```

---

## License

MIT
