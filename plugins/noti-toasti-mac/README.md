# noti-toasti-mac

Native macOS Notification Center alerts with sound when Claude Code needs your attention.

Displays the agent name, working directory, and event reason in every notification.

## Features

- 🔔 macOS banner notifications via JXA (`osascript`)
- 🔊 Configurable system sound (`Glass` default)
- 🧭 Shows agent name, project directory, and event reason
- ⚡ Zero dependencies — uses built-in macOS tools only

## Requirements

- macOS 10.10+
- Terminal notification permissions enabled in **System Settings > Notifications**

## Install

```bash
/plugin marketplace add shaikh-imran/s10i-claude-plugins
/plugin install noti-toasti-mac@s10i-claude-plugins
```

Local:
```bash
/plugin install ./plugins/noti-toasti-mac
```

## How It Works

1. Claude Code fires the `Notification` hook when user input is needed.
2. The hook runs `scripts/noti-toasti-mac.sh`.
3. The script reads the JSON payload from stdin, extracts context (agent name, project, session ID, message).
4. Calls `osascript` (JXA) to display a banner notification with sound.

**Notification format:**
- **Title:** `Claude Code [Agent Name]`
- **Subtitle:** Project directory name
- **Body:** Event reason + agent path

## Configuration

Set in `~/.zshrc` or `~/.bashrc`:

| Variable | Default | Description |
|---|---|---|
| `CLAUDE_NOTI_SOUND` | `Glass` | System sound name (`Ping`, `Hero`, `Submarine`, `Blow`, `Bottle`, `Pop`, etc.) |
| `CLAUDE_NOTI_AFPLAY` | `0` | Set to `1` to also play audio via `/usr/bin/afplay` |

## File Structure

```
noti-toasti-mac/
├── .claude-plugin/plugin.json
├── hooks/hooks.json
├── scripts/noti-toasti-mac.sh
└── README.md
```

## License

MIT
