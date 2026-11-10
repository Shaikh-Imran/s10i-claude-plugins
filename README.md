# s10i-claude-plugins

[Claude Code](https://claude.ai/code) plugins by **Imran Shaikh** ([@Shaikh-Imran](https://github.com/shaikh-imran)).

---

## Adding this Marketplace

```bash
/plugin marketplace add shaikh-imran/s10i-claude-plugins
```

### Clone and Add via Local Path

> [!NOTE]
> If for any reason scripts or direct GitHub pulls are blocked, you can clone the repository and pass the local path directly to the `marketplace add` command.

```bash
git clone https://github.com/shaikh-imran/s10i-claude-plugins.git
```

```bash
/plugin marketplace add /path/to/s10i-claude-plugins
```

---

## Available Plugins

| Plugin | Description | Platform | Install |
|---|---|---|---|
| [`noti-toasti-mac`](./plugins/noti-toasti-mac) | Native macOS notifications with sound when Claude Code needs attention — shows agent name, project, and path | macOS | `/plugin install noti-toasti-mac@s10i-claude-plugins` |
| [`noti-toasti-windows`](./plugins/noti-toasti-windows) | Native Windows toast notifications with sound when Claude Code needs attention — supports WSL | Windows / WSL | `/plugin install noti-toasti-windows@s10i-claude-plugins` |
| [`metero`](./plugins/metero) | Live context meter above the prompt — tokens, cost, model, and rate limits with a color-coded bar | Any | `/plugin install metero@s10i-claude-plugins` |
| [`namer-cr`](./plugins/namer-cr) | Prompts for a session name (git-branch-aware) and chat color on startup | Any | `/plugin install namer-cr@s10i-claude-plugins` |

---

## Plugin Details

### [noti-toasti-mac](./plugins/noti-toasti-mac)

Fires native macOS Notification Center banners with sound whenever Claude Code needs user input or triggers a notification. Includes agent name, working directory, and project name in every alert. Zero external dependencies — uses built-in `osascript` (JXA).

```bash
/plugin install noti-toasti-mac@s10i-claude-plugins
```

→ [Docs](./plugins/noti-toasti-mac/README.md)

### [noti-toasti-windows](./plugins/noti-toasti-windows)

Fires native Windows toast banners with sound whenever Claude Code needs user input or triggers a notification. Uses WinRT `ToastNotificationManager` via PowerShell. Auto-detects WSL and converts paths with `wslpath`.

```bash
/plugin install noti-toasti-windows@s10i-claude-plugins
```

→ [Docs](./plugins/noti-toasti-windows/README.md)

### [metero](./plugins/metero)

Renders a live context usage bar above the input prompt. Shows token count, context window percentage, session cost in USD, active model, and rate limit status. Color shifts green → yellow → red as context fills. Updates after every turn.

```bash
/plugin install metero@s10i-claude-plugins
```

→ [Docs](./plugins/metero/README.md)

### [namer-cr](./plugins/namer-cr)

On startup, prompts you to name the session and pick a chat color. Suggests names from the git branch and folder name. Non-blocking — runs after session start.

```bash
/plugin install namer-cr@s10i-claude-plugins
```

→ [Docs](./plugins/namer-cr/README.md)

---

## Changelog
[Changelog](./CHANGELOG.md)

---

## License

[MIT License](./LICENSE)
